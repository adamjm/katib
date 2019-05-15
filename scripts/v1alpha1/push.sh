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

SCRIPT_ROOT=$(dirname ${BASH_SOURCE})/../..
cd ${SCRIPT_ROOT}

push_images () {
    docker push ${PREFIX}/$1:latest-$2
}

echo "Manifest for core image..."
push_images vizier-core ${ARCH}
push_images studyjob-controller ${ARCH}
push_images metrics-collector ${ARCH}
push_images tfevent-metrics-collector ${ARCH}

echo "Manifest for REST API for core image..."
push_images vizier-core-rest ${ARCH}

echo "Manifest for suggestion images..."
push_images suggestion-random ${ARCH}
push_images suggestion-grid ${ARCH}
push_images suggestion-hyperband ${ARCH}
push_images suggestion-bayesianoptimization ${ARCH}
push_images suggestion-nasrl ${ARCH}

echo "Manifest for earlystopping images..."
push_images earlystopping-medianstopping ${ARCH}

echo "Building UI image..."
push_images katib-ui ${ARCH}

