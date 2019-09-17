VERSION=latest
NAME=jenkins
NO_CACHE=--no-cache=false

all: build push
build:
	docker build $(NO_CACHE) -t docker.sunet.se/$(NAME):$(VERSION) .
update: NO_CACHE=
update: build
push:
	docker push docker.sunet.se/$(NAME):$(VERSION)
