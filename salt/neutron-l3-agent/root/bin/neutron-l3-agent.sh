#!/usr/bin/env bash
#-------------------------------------------------------------------------------
ovs-vsctl add-br   br-ext
ovs-vsctl add-port br-ext eth1
#-------------------------------------------------------------------------------