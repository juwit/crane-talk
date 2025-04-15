#!/bin/bash

cp() {
  local SRC_IMAGE="$1"
  local DST_IMAGE="$2"

   # Pull the source image
  docker image pull "$SRC_IMAGE"

  # Tag the image with the new tag
  docker image tag "${SRC_IMAGE}" "${DST_IMAGE}"

  # Push the newly tagged image
  docker image push "${DST_IMAGE}"
}

# prepares the demo by cleaning up and building what is needed

REGISTRY=rg.fr-par.scw.cloud/devoxx-2025
docker image rm -f $(docker image ls | grep $REGISTRY | awk '{print $3}')
docker image rm -f $(docker image ls | grep '<none>' | awk '{print $3}')

#docker image pull eclipse-temurin:23
cp eclipse-temurin:23.0.1_11-jdk $REGISTRY/eclipse-temurin:23
cp eclipse-temurin:24 $REGISTRY/eclipse-temurin:24
cp eclipse-temurin:latest $REGISTRY/eclipse-temurin:latest
cp node:22 $REGISTRY/node:22
cp node:23 $REGISTRY/node:23
cp node:latest $REGISTRY/node:latest

cp keycloak/keycloak $REGISTRY/keycloak
cp redhat/ubi9-micro:9.5 $REGISTRY/redhat/ubi9-micro:9.5
cp ubuntu $REGISTRY/ubuntu

#cd simple-java
#docker image build --no-cache --push -t $REGISTRY/java-app:jdk-23 .
#cd ..

# build petclinic
cd spring-petclinic
docker image build --no-cache --push -t $REGISTRY/java-app:jdk-23 .
cd ..

#cd simple-nest
#docker image build --no-cache --push -t $REGISTRY/nest-app:node-22 .
#cd ..

# demo
# rebase petclinic eclipse-temurin 23 -> 24
