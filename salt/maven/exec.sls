mvn:
  cmd.run:
    - name:     . /etc/profile && mvn
    - require:
      - pkg:       maven
