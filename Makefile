
dev:
	trap 'kill %1' SIGINT
	sam local start-api

build:
	./src/get/build.sh
	./src/post/build.sh
	./src/simple/build.sh


test: build
	./src/get/test.sh
	./src/post/test.sh
	./src/simple/test.sh

infra:
	./infrastructure/deploy.sh

# swagger-start:
# 	docker run --name swagger-editor -d -p 8080:8080 swaggerapi/swagger-editor

# swagger-stop:
# 	docker stop swagger-editor
