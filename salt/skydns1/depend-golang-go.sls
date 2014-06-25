# vi: set ft=yaml.jinja :

include:
  -  golang-go
  -  mercurial
  -  skydns1.depend-git

/usr/local/src/skydns1:
  file.directory:
    - user:        root
    - group:       root
    - mode:       '0755'

go get -d -v ./...:
  cmd.wait:
    - cwd:        /usr/local/src/skydns1
    - env:
      - GOPATH:   /usr/local
    - require:
      - pkg:       golang-go
      - pkg:       mercurial

go build -v ./...:
  cmd.wait:
    - cwd:        /usr/local/src/skydns1
    - env:
      - GOPATH:   /usr/local
    - watch:
      - cmd:       go get -d -v ./...

go install -v . ./...:
  cmd.wait:
    - cwd:        /usr/local/src/skydns1
    - env:
      - GOPATH:   /usr/local
    - watch:
      - cmd:       go build -v ./...
