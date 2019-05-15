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

manifest_creator () {
    docker manifest create ${PREFIX}/$1:latest ${PREFIX}/$1:amd64-latest ${PREFIX}/$1:ppc64le-latest
    docker manifest annotate ${PREFIX}/$1:latest ${PREFIX}/$1:ppc64le-latest --os linux --arch ppc64le
}

echo "Manifest for core image..."
manifest_creator vizier-core
manifest_creator studyjob-controller
manifest_creator metrics-collector
manifest_creator tfevent-metrics-collector

echo "Manifest for REST API for core image..."
manifest_creator vizier-core-rest

echo "Manifest for suggestion images..."
manifest_creator suggestion-random
manifest_creator suggestion-grid
manifest_creator suggestion-hyperband
manifest_creator suggestion-bayesianoptimization
manifest_creator suggestion-nasrl

echo "Manifest for earlystopping images..."
manifest_creator earlystopping-medianstopping

echo "Building UI image..."
manifest_creator katib-ui

