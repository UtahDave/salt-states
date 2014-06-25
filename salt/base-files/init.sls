# vi: set ft=yaml.jinja :

base-files:
  pkg.installed:
    - name:     {{ salt['config.get']('base-files:pkg:name') }}

/tmp:
  file.directory:
    - user:        root
    - group:       root
    - mode:       '1777'
    - require:
      - pkg:       base-files
