#!/bin/sh

# rebase simple
crane rebase \
  --old_base $REGISTRY/eclipse-temurin:23 \
  --new_base $REGISTRY/eclipse-temurin:24 \
  --tag $REGISTRY/java-app:jdk-24 \
  $REGISTRY/java-app:jdk-23

crane rebase \
  --old_base $REGISTRY/eclipse-temurin:23 \
  --new_base $REGISTRY/eclipse-temurin:24 \
  --tag $REGISTRY/spring-petclinic:jdk-24 \
  $REGISTRY/spring-petclinic:jdk-23

crane rebase \
  --old_base $REGISTRY/node:22 \
  --new_base $REGISTRY/node:23 \
  --tag $REGISTRY/nest-app:node-23 \
  $REGISTRY/nest-app:node-22

# rebase avec les annotations
# lecture du manifest
crane manifest $REGISTRY/java-app:jdk-23

# poser des annotations sur l'image à rebase
crane mutate \
  -a "org.opencontainers.image.base.name=$REGISTRY/eclipse-temurin" \
  -a "org.opencontainers.image.base.digest=$(crane digest $REGISTRY/eclipse-temurin:23)" \
 $REGISTRY/java-app:jdk-23

crane mutate \
 -a "org.opencontainers.image.base.name=$REGISTRY/eclipse-temurin" \
 -a "org.opencontainers.image.base.digest=sha256:cb2693dd0d881fc66c3ed75f419d1a477fbef1d2433b6b79be654f22334700c8" \
 $REGISTRY/spring-petclinic:jdk-23

crane mutate \
 -a "org.opencontainers.image.base.name=$REGISTRY/node" \
 -a "org.opencontainers.image.base.digest=$(crane digest $REGISTRY/node:22)" \
 $REGISTRY/nest-app:node-22

# rebase plus simple
crane rebase \
  --new_base $REGISTRY/eclipse-temurin:24 \
  --tag $REGISTRY/java-app:jdk-24 \
  $REGISTRY/java-app:jdk-23

# encore plus simple, en utilisant latest
crane rebase \
  --tag $REGISTRY/java-app:jdk-24 \
  $REGISTRY/java-app:jdk-23

# rebase d'une image qu'on ne possède pas !
# identifier la layer avec docker scout
docker scout quickview $REGISTRY/keycloak

# récupérer l'image de base
docker image pull redhat/ubi9-micro:9.5
docker image tag redhat/ubi9-micro:9.5 $REGISTRY/redhat/ubi9-micro:9.5
docker image push $REGISTRY/redhat/ubi9-micro:9.5

# rebase !
crane rebase \
 --old_base $REGISTRY/redhat/ubi9-micro:9.5 \
 --new_base $REGISTRY/eclipse-temurin:23 \
 --tag $REGISTRY/keycloak:jdk-23 \
 $REGISTRY/keycloak

docker container run --rm -it $REGISTRY/keycloak:jdk-24 start-dev

# rebase abhérent
crane rebase \
  --old_base $REGISTRY/eclipse-temurin:23 \
  --new_base $REGISTRY/node:22 \
  --tag $REGISTRY/java-app:node-22 \
  $REGISTRY/java-app:jdk-23