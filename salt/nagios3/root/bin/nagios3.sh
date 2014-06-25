#!/usr/bin/env bash
#-------------------------------------------------------------------------------
   dpkg-statoverride --list                                                    \
 |             egrep -q            'nagios nagios 751 /var/lib/nagios3'        \
|| dpkg-statoverride --update --add nagios nagios 751  /var/lib/nagios3
#-------------------------------------------------------------------------------
   dpkg-statoverride --list                                                    \
 |             egrep -q            'nagios www-data 2710 /var/lib/nagios3/rw'  \
|| dpkg-statoverride --update --add nagios www-data 2710 /var/lib/nagios3/rw
#-------------------------------------------------------------------------------
