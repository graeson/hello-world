#!/bin/bash

# build container hello:latest
name="hello" && docker build --tag $name .

# run container on http://localhost:8080
name="hello" && docker run \
  --detach \
  --name $name \
  --publish 8080:80 \
  $name

# stop container
name="hello" && id=$(docker ps -a -q -f name=$name) && docker stop $id

# stop & remove container
name="hello" && id=$(docker ps -a -q -f name=$name) && docker stop $id && docker rm $id

# remove dangling, non-tagged builds after rebuilding
docker rmi $(docker images -qa -f dangling=true -f)

# push image to dockerhub
docker login
docker tag hello $(whoami)/hello:latest
docker push $(whoami)/hello:latest