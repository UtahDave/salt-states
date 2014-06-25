# vi: set ft=yaml.jinja :

include:
  -  golang-go
  -  mercurial
  -  skydns2.depend-git

/usr/local/src/skydns2:
  file.directory:
    - user:        root
    - group:       root
    - mode:       '0755'

#-------------------------------------------------------------------------------
# TODO: remove hack when source code is fixed
#-------------------------------------------------------------------------------

/usr/local/src/skydns2/server.go:
  file.replace:
    - pattern:    'serv.Ttl = s.calculateTtl\(&n, serv\)'
    - repl:       'serv.Ttl = s.calculateTtl(n, serv)'
    - require_in:
      - cmd:       go build -v ./...
    - watch:
      - git:       https://github.com/skynetservices/skydns.git

go get -d -v ./...:
  cmd.wait:
    - cwd:        /usr/local/src/skydns2
    - env:
      - GOPATH:   /usr/local
    - require:
      - pkg:       golang-go
      - pkg:       mercurial

go build -v ./...:
  cmd.wait:
    - cwd:        /usr/local/src/skydns2
    - env:
      - GOPATH:   /usr/local
    - watch:
      - cmd:       go get -d -v ./...

go install -v . ./...:
  cmd.wait:
    - cwd:        /usr/local/src/skydns2
    - env:
      - GOPATH:   /usr/local
    - watch:
      - cmd:       go build -v ./...
