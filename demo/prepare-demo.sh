#!/bin/sh

# prepares the demo by cleaning up and building what is needed

REGISTRY=rg.fr-par.scw.cloud/devoxx-2025

# delete old images
#crane delete $REGISTRY/eclipse-temurin:23
#crane delete $REGISTRY/eclipse-temurin:24
#crane delete $REGISTRY/java-app:jdk-23
#crane delete $REGISTRY/java-app:jdk-24

docker image rm $REGISTRY/eclipse-temurin:23
docker image rm $REGISTRY/eclipse-temurin:24
docker image rm $REGISTRY/java-app:jdk-23
docker image rm $REGISTRY/java-app:jdk-24

docker image pull eclipse-temurin:23
docker image tag eclipse-temurin:23 $REGISTRY/eclipse-temurin:23
docker image push $REGISTRY/eclipse-temurin:23

docker image pull eclipse-temurin:24
docker image tag eclipse-temurin:24 $REGISTRY/eclipse-temurin:24
docker image push $REGISTRY/eclipse-temurin:24
docker image tag eclipse-temurin:24 $REGISTRY/eclipse-temurin:latest
docker image push $REGISTRY/eclipse-temurin:latest

docker image pull node:22
docker image tag node:22 $REGISTRY/node:22
docker image push $REGISTRY/node:22

docker image pull keycloak/keycloak
docker image tag keycloak/keycloak $REGISTRY/keycloak
docker image push $REGISTRY/keycloak

cd simple-java
docker image build --no-cache --push -t $REGISTRY/java-app:jdk-23 .
cd ..

# build petclinic
cd spring-petclinic
docker image build --no-cache --push -t $REGISTRY/spring-petclinic:jdk-23 .
cd ..

# demo
# rebase petclinic eclipse-temurin 23 -> 24
