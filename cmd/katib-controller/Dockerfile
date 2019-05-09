# Build the manager binary
ARG ARCH
FROM golang:alpine AS build-env

# Copy in the go src
ADD . /go/src/github.com/kubeflow/katib

WORKDIR /go/src/github.com/kubeflow/katib/cmd/katib-controller
# Build
RUN CGO_ENABLED=0 GOOS=linux GOARCH=${ARCH} go build -a -o studyjobcontroller  ./v1alpha1
RUN CGO_ENABLED=0 GOOS=linux GOARCH=${ARCH} go build -a -o katib-controller.v1alpha2  ./v1alpha2
# Copy the controller-manager into a thin image
FROM ${ARCH}/alpine:3.7
WORKDIR /app
COPY --from=build-env /go/src/github.com/kubeflow/katib/cmd/katib-controller/studyjobcontroller .
COPY --from=build-env /go/src/github.com/kubeflow/katib/cmd/katib-controller/katib-controller.v1alpha2 .
ENTRYPOINT ["./studyjobcontroller"]
