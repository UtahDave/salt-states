# vi: set ft=yaml.jinja :

{% set py_lib = salt['cmd.run']('python -c "from distutils.sysconfig import get_python_lib; print get_python_lib()"') %}

include:
  -  git
  -  salt-halite

https://github.com/saltstack/halite:
  git.latest:
    - rev:         master
    - target:   {{ py_lib }}/halite
    - require:
      - pkg:       git
