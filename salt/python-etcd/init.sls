# vi: set ft=yaml.jinja :

include:
  -  python-openssl
  -  python-pip
  -  python-urllib3

python-etcd:
  pip.installed:
    - no_deps:     True
    - require:
      - pkg:       python-openssl
      - pkg:       python-pip
      - pkg:       python-urllib3
