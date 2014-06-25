# vi: set ft=yaml.jinja :

vim:
  pkg.installed:
    - order:      -1
    - name:     {{ salt['config.get']('vim:pkg:name') }}

/etc/skel/.vimrc:
  file.managed:
    - order:      -1
    - source:      salt://{{ sls }}/etc/skel/.vimrc
    - user:        root
    - group:       root
    - mode:       '0644'

/root/.vimrc:
  file.managed:
    - order:      -1
    - source:      salt://{{ sls }}/etc/skel/.vimrc
    - user:        root
    - group:       root
    - mode:       '0644'
