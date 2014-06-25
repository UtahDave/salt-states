#!/usr/bin/env bash
#-------------------------------------------------------------------------------
devs=( $( ls -1d /dev/{s,{u,x,}v}d{b..z}1 2>/dev/null ) )
#-------------------------------------------------------------------------------
swift-init                    object-server     start
swift-init                    object-auditor    start
swift-ring-builder            object.builder    create 18 3 1
#-------------------------------------------------------------------------------
for i in $( seq 0 $(( ${#COMPUTE[@]} - 1 )) )
do
    for dev in ${devs[@]}
    do
        dev="z${i}-${COMPUTE[${i}]}:6002/$( basename ${dev} )"
        swift-ring-builder    object.builder    add  ${dev} 100
    done
done
#-------------------------------------------------------------------------------
swift-ring-builder            object.builder    rebalance
swift-init                    object-replicator start
#-------------------------------------------------------------------------------
