VERSION=latest
NAME=jenkins
NO_CACHE=--no-cache=true
PULL=

all: build push
build:
	docker build $(PULL) $(NO_CACHE) -t docker.sunet.se/sunet/docker-$(NAME):$(VERSION) .
update: NO_CACHE=
update: build
pull:
	$(eval PULL=--pull)
push:
	docker push docker.sunet.se/sunet/docker-$(NAME):$(VERSION)
