#!/bin/bash -e

containerID=$(docker run --detach mre0/armhf-rust-cc)
docker cp $containerID:/project/target target
sleep 1
docker rm $containerID
