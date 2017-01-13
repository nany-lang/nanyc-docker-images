#!/usr/bin/env bash

set -e
root=$(cd $(dirname "$0") && pwd)
images=()

build_docker_image() {
	local folder="$1"
	local name="$2"
	local file="${name}.dockerfile"
	echo -e "\n::: building ${name}..."
	(cd "${folder}" \
		&& docker build -f "./${file}" -t "nanyc/build:${name}" .)
}

please_publish() {
	echo -e "\n  publish: docker push nanyc/build"
}

build_all_images() {
	build_docker_image debian debian-8
	build_docker_image debian debian-9
	build_docker_image debian ubuntu-16.04
	build_docker_image debian ubuntu-17.04
	build_docker_image rhel centos-7
}

echo "Docker Images for nanyc/build"
build_all_images
please_publish
