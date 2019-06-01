# Run tests

ARCH ?= $(shell uname -m)

test:
	go test ./pkg/... ./cmd/...

# Build Katib images
build: 
	sh scripts/v1alpha1/build.sh ${ARCH}

# Push images to repository
push:
	sh scripts/v1alpha1/push.sh ${ARCH}

# Deploy katib manifests into a k8s cluster
deploy: 
	sh scripts/v1alpha1/deploy.sh

# Run go fmt against code
fmt:
	go fmt ./pkg/... ./cmd/...

# Run go vet against code
vet:
	go vet ./pkg/... ./cmd/...

build-multi-arch:
	sh scripts/v1alpha1/build.sh amd64
	sh scripts/v1alpha1/build.sh ppc64le

push-multi-arch:
	sh scripts/v1alpha1/build.sh amd64
	sh scripts/v1alpha1/build.sh ppc64le

create-docker-manifest:
	sh scripts/v1alpha1/create_manifest.sh

push-docker-manifest:
	sh scripts/v1alpha1/push_manifest.sh

# Generate code
generate:
ifndef GOPATH
	$(error GOPATH not defined, please define GOPATH. Run "go help gopath" to learn more about GOPATH)
endif
	go generate ./pkg/... ./cmd/...
