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

create_manifest () {
    docker manifest create ${PREFIX}/$1:latest ${PREFIX}/$1:amd64-latest ${PREFIX}/$1:ppc64le-latest
    docker manifest annotate ${PREFIX}/$1:latest ${PREFIX}/$1:ppc64le-latest --os linux --arch ppc64le
}

echo "Manifest for core image..."
create_manifest vizier-core
create_manifest studyjob-controller
create_manifest metrics-collector
create_manifest tfevent-metrics-collector

echo "Manifest for REST API for core image..."
create_manifest vizier-core-rest

echo "Manifest for suggestion images..."
create_manifest suggestion-random
create_manifest suggestion-grid
create_manifest suggestion-hyperband
create_manifest suggestion-bayesianoptimization
create_manifest suggestion-nasrl

echo "Manifest for earlystopping images..."
create_manifest earlystopping-medianstopping

echo "Building UI image..."
create_manifest katib-ui

