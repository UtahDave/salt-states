# vi: set ft=yaml.jinja :

{% set devs = salt['cmd.run']('ls -1d /dev/{s,{u,x,}v}d{b..z} 2>/dev/null').split('\n') %}

include:
  -  hadoop-hdfs.depend-e2fsprogs

{% for dev in devs %}
{% if  dev %}

/data/{{ loop.index }}:
  mount.mounted:
    - device:   {{ dev }}1
    - fstype:      ext4
    - mkmnt:       True
    - opts:
      - noatime,nodiratime
    - require:
      - cmd:       mkfs.ext4 -m 1 -O dir_index,extent,sparse_super {{ dev }}1

/data/{{ loop.index }}/dfs:
  file.directory:
    - user:        root
    - group:       root
    - mode:       '0755'
    - require:
      - mount:    /data/{{ loop.index }}
#   - require_in:
#     - cmd:      /root/bin/cm_client.py

{% endif %}
{% endfor %}
