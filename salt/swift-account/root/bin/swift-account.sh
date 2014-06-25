#!/usr/bin/env bash
#-------------------------------------------------------------------------------
devs=( $( ls -1d /dev/{s,{u,x,}v}d{b..z}1 2>/dev/null ) )
#-------------------------------------------------------------------------------
swift-init                   account-server     start
swift-init                   account-auditor    start
swift-ring-builder           account.builder    create 18 3 1
#-------------------------------------------------------------------------------
for i in $( seq 0 $(( ${#COMPUTE[@]} - 1 )) )
do
    for dev in ${devs[@]}
    do
        dev="z${i}-${COMPUTE[${i}]}:6002/$( basename ${dev} )"
        swift-ring-builder   account.builder    add  ${dev} 100
    done
done
#-------------------------------------------------------------------------------
swift-ring-builder           account.builder    rebalance
swift-init                   account-replicator start
#-------------------------------------------------------------------------------
