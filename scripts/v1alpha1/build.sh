#!/bin/bash

# Copyright 2018 The Kubeflow Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -o errexit
set -o nounset
set -o pipefail

PREFIX="katib"
CMD_PREFIX="cmd"
echo $1
ARCH=$1

if [ "${ARCH}" = "" ]; then \
    ARCH="$(uname -m)"
fi

if [ "${ARCH}" = "x86_64" ]; then \
    ARCH="amd64"
fi

SCRIPT_ROOT=$(dirname ${BASH_SOURCE})/../..
cd ${SCRIPT_ROOT}

echo "Building core image..."
docker build --build-arg ARCH=${ARCH} -t ${PREFIX}/vizier-core:${ARCH}-latest -f ${CMD_PREFIX}/manager/Dockerfile .
docker build --build-arg ARCH=${ARCH} -t ${PREFIX}/studyjob-controller:${ARCH}-latest -f ${CMD_PREFIX}/katib-controller/Dockerfile .
docker build --build-arg ARCH=${ARCH} -t ${PREFIX}/metrics-collector:${ARCH}-latest -f ${CMD_PREFIX}/metricscollector/Dockerfile .
docker build --build-arg ARCH=${ARCH} -t ${PREFIX}/tfevent-metrics-collector:${ARCH}-latest -f ${CMD_PREFIX}/tfevent-metricscollector/Dockerfile .

echo "Building REST API for core image..."
docker build --build-arg ARCH=${ARCH} -t ${PREFIX}/vizier-core-rest:${ARCH}-latest -f ${CMD_PREFIX}/manager-rest/Dockerfile .

echo "Building suggestion images..."
docker build --build-arg ARCH=${ARCH} -t ${PREFIX}/suggestion-random:${ARCH}-latest -f ${CMD_PREFIX}/suggestion/random/Dockerfile .
docker build --build-arg ARCH=${ARCH} -t ${PREFIX}/suggestion-grid:${ARCH}-latest -f ${CMD_PREFIX}/suggestion/grid/Dockerfile .
docker build --build-arg ARCH=${ARCH} -t ${PREFIX}/suggestion-hyperband:${ARCH}-latest -f ${CMD_PREFIX}/suggestion/hyperband/Dockerfile .
docker build --build-arg ARCH=${ARCH} -t ${PREFIX}/suggestion-bayesianoptimization:${ARCH}-latest -f ${CMD_PREFIX}/suggestion/bayesianoptimization/Dockerfile .
docker build --build-arg ARCH=${ARCH} -t ${PREFIX}/suggestion-nasrl:${ARCH}-latest -f ${CMD_PREFIX}/suggestion/nasrl/Dockerfile .

echo "Building earlystopping images..."
docker build --build-arg ARCH=${ARCH} -t ${PREFIX}/earlystopping-medianstopping:${ARCH}-latest -f ${CMD_PREFIX}/earlystopping/medianstopping/Dockerfile .

echo "Building UI image..."
docker build --build-arg ARCH=${ARCH} -t ${PREFIX}/katib-ui:${ARCH}-latest -f ${CMD_PREFIX}/ui/Dockerfile .

