# vi: set ft=yaml.jinja :

bash:
  pkg.installed:
    - order:      -1
    - name:     {{ salt['config.get']('bash:pkg:name') }}

/etc/bash.bashrc:
  file.append:
    - name:     {{ salt['config.get']('/etc/bash.bashrc:file:name') }}
    - text:       "set -o vi"
    - watch:
      - pkg:       bash
