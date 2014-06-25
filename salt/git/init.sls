# vi: set ft=yaml.jinja :

git:
  pkg.installed:   []

color.ui:
  git.config:
    - value:      'true'
    - is_global:   True
    - watch:
      - pkg:       git
