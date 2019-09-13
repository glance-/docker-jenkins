VERSION=latest
NAME=jenkins

all: build push
build:
	docker build --no-cache=true -t docker.sunet.se/$(NAME):$(VERSION) .
update:
	docker build -t docker.sunet.se/$(NAME):$(VERSION) .
push:
	docker push docker.sunet.se/$(NAME):$(VERSION)
