ARG ARCH
FROM golang:alpine AS build-env
# The GOPATH in the image is /go.
ADD . /go/src/github.com/kubeflow/katib
WORKDIR /go/src/github.com/kubeflow/katib/cmd/suggestion/hyperband
RUN GOARCH=${ARCH} go build -o hyperband ./v1alpha1

FROM ${ARCH}/alpine:3.7
WORKDIR /app
COPY --from=build-env /go/src/github.com/kubeflow/katib/cmd/suggestion/hyperband /app/
ENTRYPOINT ["./hyperband"]
