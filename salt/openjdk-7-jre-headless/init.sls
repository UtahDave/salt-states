# vi: set ft=yaml.jinja :

openjdk-7-jre-headless:
  pkg.installed:
    - name:     {{ salt['config.get']('openjdk-7-jre-headless:pkg:name') }}
