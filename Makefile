default: build

get_latest: ## get latest build artifacts
	python hack/get-latest-build.py

build: ## build docker image
	docker build -t docker-terraform-tflint .
