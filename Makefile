TEST?=$$(go list ./... | grep -v 'vendor')
BINARY=vault
BIN_OS=$$(go env GOOS)
BIN_ARCH=$$(go env GOARCH)
VERSION=0.1
CI?=false

default: install

lint:
	docker run --rm --privileged \
		-v $(shell pwd):/go/src/github.com/hashicorp/vault \
		-w /go/src/github.com/hashicorp/vault \
		docker.mirror.hashicorp.services/golangci/golangci-lint:latest \
		golangci-lint run ./... \
		--concurrency 16 \
		--skip-dirs-use-default \
		--verbose \
		--timeout 10m

		# \
		# --out-format github-actions