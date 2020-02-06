NAME=`basename ${CURDIR}`

build:
	docker build . -t ${NAME}

# interactive mode
run:
	docker run -it --rm \
	-v ~/.aws:/root/.aws \
	-v ~/.ssh:/root/.ssh \
	-v ${CURDIR}:/app \
	${NAME}
