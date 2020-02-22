NAME='packer-utils'
DOCKERHUB_NAMESPACE='annaliseai'

build:
	docker build . -t ${NAME}

# interactive mode
run:
	docker run -it --rm \
	-v ~/.aws:/root/.aws \
	-v ~/.ssh:/root/.ssh \
	-v ${CURDIR}:/app \
	${NAME}

tag:
	docker tag ${NAME}:latest ${DOCKERHUB_NAMESPACE}/${NAME}:latest

login:
	docker login -u ${DOCKERHUB_NAMESPACE}

push:
	docker push ${DOCKERHUB_NAMESPACE}/${NAME}:latest
