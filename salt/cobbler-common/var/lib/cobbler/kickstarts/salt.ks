timezone   --utc UTC
url        --url $tree
keyboard     us
lang         en_US
install
reboot
skipx
text
$SNIPPET('security_config')
$SNIPPET('network_config')
$SNIPPET('virtual_detect')
$SNIPPET('storage_config')

%packages
@base
@core

%pre
$SNIPPET('pre_install_network_config')

%post
$SNIPPET('post_install_network_config')
$SNIPPET('salt')

