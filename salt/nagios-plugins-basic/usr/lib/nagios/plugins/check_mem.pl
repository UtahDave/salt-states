#!/usr/bin/perl -w
# $Id: check_mem.pl,v 1.2.1.1 2008/06/30 11:15:52 gherteg Exp $

# Based on:  check_mem.pl Copyright (C) 2000 Dan Larsson <dl@tyfon.net>
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty
# of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# you should have received a copy of the GNU General Public License
# along with this program (or with Nagios);  if not, write to the
# Free Software Foundation, Inc., 59 Temple Place - Suite 330,
# Boston, MA 02111-1307, USA

# Tell Perl what we need to use
use strict;
use Getopt::Std;

use vars qw($opt_c $opt_f $opt_u $opt_w $opt_F $opt_U
            $free_memory $used_memory $total_memory $buffers $cached
            $crit_level $warn_level
            %exit_codes @memlist
            $percent $fmt_pct
            $verb_err $command_line);

# Predefined exit codes for Nagios
%exit_codes   = ('UNKNOWN' ,-1,
                 'OK'      , 0,
                 'WARNING' , 1,
                 'CRITICAL', 2,);

# Turn this to 1 to see reason for parameter errors (if any)
# There is really no reason to set this to zero
$verb_err     = 1;

my $perf="";
my $stats_file = "/proc/meminfo";
my $line;
my $L_key;
my $L_val;

if (open(FILE, "$stats_file")) {
    while(<FILE>) {
        chomp;
        $line = $_;
        $L_val=0;
        $L_key="";
        unless ($line =~ /^(\w+):\s+(\d+)/) { next };
        $L_key = $1;
        $L_val = $2;
        if   ("$L_key" eq "MemTotal")  { $total_memory   = $L_val; }
        elsif("$L_key" eq "MemFree")   { $free_memory    = $L_val; }
        elsif("$L_key" eq "Buffers")   { $buffers        = $L_val; }
        elsif("$L_key" eq "Cached")    { $cached         = $L_val; }
    }
} else {
  print "UNKNOWN:  Can't access $stats_file";
  exit(-1);
}


# This the unix command string that brings Perl the data
#$command_line = `vmstat | tail -1 | awk '{print \$4,\$5}'`;

#chomp $command_line;
#@memlist      = split(/ /, $command_line);

# Define the calculating scalars
#$used_memory  = $memlist[1];
#$free_memory  = $memlist[0];
#$total_memory = $used_memory + $free_memory;

# Get the options
if ($#ARGV le 0)
{
  &usage;
}
else
{
  getopts('c:fuFUw:');
}

# Simplify the later processing, so we don't need to check twice as many flags.
$opt_f = 1 if $opt_F;
$opt_u = 1 if $opt_U;

# Shortcircuit the switches
if (!$opt_w or $opt_w == 0 or !$opt_c or $opt_c == 0)
{
  print "*** You must define WARN and CRITICAL levels!" if ($verb_err);
  &usage;
}
elsif (!$opt_f and !$opt_u)
{
  print "*** You must select to monitor either free, used, FREE, or USED memory!" if ($verb_err);
  &usage;
}

# Check if levels are sane
if ($opt_w <= $opt_c and $opt_f)
{
  print "*** WARN level must not be less than CRITICAL when checking free or FREE memory!" if ($verb_err);
  &usage;
}
elsif ($opt_w >= $opt_c and $opt_u)
{
  print "*** WARN level must not be greater than CRITICAL when checking used or USED memory!" if ($verb_err);
  &usage;
}

$warn_level   = $opt_w;
$crit_level   = $opt_c;

# Here's the one place where the difference between the capital and lowercase options comes into play.
if ($opt_F || $opt_U) {
    $free_memory += $buffers + $cached;
}
$used_memory = $total_memory - $free_memory;

if ($opt_f)
{
  $percent    = $free_memory / $total_memory * 100;
  $fmt_pct    = sprintf "%.1f", $percent;
  if ($percent <= $crit_level)
  {
    print "Memory CRITICAL - $fmt_pct% ($free_memory kB) free |pct=$fmt_pct;$warn_level;$crit_level;0;100\n";
    exit $exit_codes{'CRITICAL'};
  }
  elsif ($percent <= $warn_level)
  {
    print "Memory WARNING - $fmt_pct% ($free_memory kB) free |pct=$fmt_pct;$warn_level;$crit_level;0;100\n";
    exit $exit_codes{'WARNING'};
  }
  else
  {
    print "Memory OK - $fmt_pct% ($free_memory kB) free |pct=$fmt_pct;$warn_level;$crit_level;0;100\n";
    exit $exit_codes{'OK'};
  }
}
elsif ($opt_u)
{
  $percent    = $used_memory / $total_memory * 100;
  $fmt_pct    = sprintf "%.1f", $percent;
  if ($percent >= $crit_level)
  {
    print "Memory CRITICAL - $fmt_pct% ($used_memory kB) used |pct=$fmt_pct;$warn_level;$crit_level;0;100\n";
    exit $exit_codes{'CRITICAL'};
  }
  elsif ($percent >= $warn_level)
  {
    print "Memory WARNING - $fmt_pct% ($used_memory kB) used |pct=$fmt_pct;$warn_level;$crit_level;0;100\n";
    exit $exit_codes{'WARNING'};
  }
  else
  {
    print "Memory OK - $fmt_pct% ($used_memory kB) used |pct=$fmt_pct;$warn_level;$crit_level;0;100\n";
    exit $exit_codes{'OK'};
  }
}

# Show usage
sub usage()
{
  print "\ncheck_mem.pl v1.2 - Nagios Plugin\n\n";
  print "usage:\n";
  print " check_mem.pl -<f|u|F|U> -w <warnlevel> -c <critlevel>\n\n";
  print "options:\n";
  print " -f           Check free memory (completely unused)\n";
  print " -u           Check used memory (allocated for any purpose)\n";
  print " -F           Check FREE memory (potentially available)\n";
  print " -U           Check USED memory (not counting buffers or cache)\n";
  print " -w PERCENT   Percent free/used/FREE/USED when to warn\n";
  print " -c PERCENT   Percent free/used/FREE/USED when critical\n";
  print "free is the strictly-interpreted value from meminfo;\n";
  print "FREE is the sum of free, buffers, and cache from meminfo;\n";
  print "used/USED is memory that isn't free/FREE;\n";
  print "which means used is the sum of USED, buffers, and cache.\n";
  print "\nThese measures of memory usage are split like this:\n\n";
  print "    free buffers cache USED\n";
  print "    ---- ------- ----- ----\n";
  print "    free <======used======>\n";
  print "    <======FREE======> USED\n";
  print "\nSo that:  Total == free+used == FREE+USED\n";
  print "\nCopyright (C) 2000 Dan Larsson <dl\@tyfon.net>\n";
  print "\nRevised version (c) 2008 GPL GroundWork\n";
  print "check_mem.pl comes with absolutely NO WARRANTY either implied or explicit\n";
  print "This program is licensed under the terms of the\n";
  print "GNU General Public License (check source code for details)\n";
  exit $exit_codes{'UNKNOWN'};
}
