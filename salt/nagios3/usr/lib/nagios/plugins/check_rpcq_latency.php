<?php
/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/* This plugin makes call to master node, get the jmx-json document
 * It checks the rpc wait time in the queue, RpcQueueTimeAvgTime
 * check_rpcq_latency -h hostaddress -p port -t ServiceName -w 1 -c 1
 * Warning and Critical values are in seconds
 * Service Name = JobTracker, NameNode
 */

  $options = getopt ("h:p:w:c:n:");
  if (!array_key_exists('h', $options) || !array_key_exists('p', $options) || !array_key_exists('w', $options)
      || !array_key_exists('c', $options) || !array_key_exists('n', $options)) {
    usage();
    exit(3);
  }

  $host=$options['h'];
  $port=$options['p'];
  $master=$options['n'];
  $warn=$options['w'];
  $crit=$options['c'];

  /* Get the json document */
  $json_string = file_get_contents("http://".$host.":".$port."/jmx?qry=Hadoop:service=".$master.",name=RpcActivityForPort*");
  $json_array = json_decode($json_string, true);
  $object = $json_array['beans'][0];

  $RpcQueueTimeAvgTime = round($object['RpcQueueTimeAvgTime'], 2);
  $RpcProcessingTimeAvgTime = round($object['RpcProcessingTimeAvgTime'], 2);

  $out_msg = "RpcQueueTimeAvgTime:<" . $RpcQueueTimeAvgTime .
             "> Secs, RpcProcessingTimeAvgTime:<" . $RpcProcessingTimeAvgTime .
             "> Secs";

  if ($RpcQueueTimeAvgTime >= $crit) {
    echo "CRITICAL: " . $out_msg . "\n";
    exit (2);
  }
  if ($RpcQueueTimeAvgTime >= $warn) {
    echo "WARNING: " . $out_msg . "\n";
    exit (1);
  }
  echo "OK: " . $out_msg . "\n";
  exit(0);

  /* print usage */
  function usage() {
    echo "Usage: $0 -h <host> -p port -n <JobTracker/NameNode> -w <warn_in_sec> -c <crit_in_sec>\n";
  }
?>
