# vi: set ft=yaml.jinja :

{% set version = 'cm4' %}

include:
  -  docker.sensu
  -  docker.kibana
  -  docker.grafana
  -  docker.skydns2
  -  docker.cloudera-{{ version }}-server
  -  docker.zookeeper-server
  -  docker.hadoop-hdfs-datanode
  -  docker.hadoop-hdfs-journalnode
  -  docker.hadoop-hdfs-secondarynamenode
  -  docker.hadop-hdfs-namenode
  -  docker.hbase-regionserver
  -  docker.hbase-master
