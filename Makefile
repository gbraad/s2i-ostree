IMAGE_NAME = ostree-compose

build:
	docker build -t $(IMAGE_NAME) .

