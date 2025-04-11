# Plan détaillé

## Timings 

| Item              | Durée |
|-------------------|-------|
| Intro             | 2 m   |
| Manifest d'image  | 2 m   |
| Rebase d'image    | 2 m   |
| crane             | 2 m   |
| démo 1            | 5 m   |
| annotations hints | 2 m   |
| demo 2            | 5 m   |
| cas d'usage réels | 2 m   |
| démo keycloak     | 2 m   |
| bonnes pratiques  | 1 m   |
| limites           | 1 m   |
| Q&A               | 4 m   |

## Détail

### Intro (2 m)
Vegetops est responsable DevOps dans une grande entreprise.
Il maintient pour ses équipes des images docker de base sur différentes stacks: Java 17, 21, 22, 23, 24, Node 20, 22.
Ces images de base sont utilisées dans une centaine d'applications (microservices).
Une CVE majeure est découverte dans une librairie de l'image de base ubuntu, un samedi matin.
La vie de Vegetops bascule, il doit reconstruire rapidement ses 7 images (ça va, il relance 7 pipelines), ça lui prend une
petite heure.
Il doit ensuite prévenir ses développeurs, qui doivent mettre à jour leurs Dockerfiles, et relancer aussi leurs pipelines => ça prend des jours à tout rebuilder.

> Toute ressemblance avec des choses déjà vécues serait totalement fortuite

### Rappel de ce qu'est une image de container (manifest) (2m)
Des layers empilées, souvent sur 3 niveaux de responsabilités : une couche "distrib" (ubuntu / alpine), une couche "runtime' (java / node), une couche applicative
Le manifest est le fichier JSON qui permet de représenter une image

### Le principe de "rebase" d'une image (2 m)
Déplacer les couches supérieures d'une image (la couche applicative souvent)
=> Mise à jour de la distrib et du runtime

### Présentation de `crane` (1 m)
Outil CLI, développé par Google dans go-containerregistry
Manipulation de registry et de manifest d'images (modification de CMD / ENTRYPOINT / LABELS, etc)
`crane mutate` permet de modifier une image

### Présentation de `crane rebase` (1 m)
Permet de faire des rebase d'images, sans re-builder, en re-construisant un manifest avec les layers ré-agencées

### Démos : mise à jour d'une image (rebase eclipse-temurin 23 -> 24) (5 m)

### Les annotations hints (pour faciliter la vie) (2 m)
Préciser l'image de départ peut-être un peu relou, donc on peut aussi se simplifier la vie (ce qui aidera aussi à massifier les rebase)
Annotations issues de la spec OCI :
https://github.com/opencontainers/image-spec/blob/main/annotations.md#pre-defined-annotation-keys
org.opencontainers.image.base.digest
org.opencontainers.image.base.name

### Démo avec les annotations (2 m)

### Cas d'usage (2 m)
Mise à jour "classique"
Ajout d'un certificat dans le ca-certificates et le keystore

### Démo Keycloak

### Bonnes pratiques et limites (4 m)
Toujours produire un nouveau tag ! => ce n'est pas le comportement par défaut, il faut y faire bien attention

Le bon fonctionnement des images n'est pas garanti.
On peut rebase une appli java sur une image node ! (démo)

Coupler avec un outil de validation des images comme `container-structure-test` pour valider que les images sont ok

