# vi: set ft=yaml.jinja :

calamari:
  postgres_user.present:
    - password: {{ salt['config.get']('calamari.db.password') }}
    - user:        postgres
    - require:
      - service:   postgresql
  postgres_database.present:
    - encoding:    UTF8
    - lc_collate:  en_US.UTF8
    - lc_ctype:    en_US.UTF8
    - owner:       calamari
    - template:    template0
    - user:        postgres
    - require:
      - postgres_user:  calamari
