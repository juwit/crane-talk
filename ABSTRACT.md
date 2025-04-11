# Rebase d'images OCI / Docker avec crane

## Abstract

Les images Docker ou OCI sont aujourd'hui un standard pour exécuter du code. Le fonctionnement des images en layers permet de pouvoir partager des environnements communs entre les applications. Beaucoup d'entreprises utilisent des images de base comme celles fournies par `alpine`, `ubuntu`, ou `eclipse-temurin`. Certaines construisent même leur propres images de base, pour y intégrer les outils dont elles ont besoin (j'ai construit et maintenu de telles images par le passé).

Mais comment faire lorsqu'une faille de sécurité est détectée dans une image de base, quand on veut ajouter un certificat dans l'ensemble des images d'une application, ou bien mettre à jour un ensemble de micro-services de Java 23 à 24 ?
Re-builder des images, en lançant des pipelines après avoir mis à jour plein de Dockerfiles peut être long et pénible.

Dans ce talk, nous verrons le principe des rebase appliqués aux images OCI ou Docker.
Après avoir revu la structure d'une image OCI et ce qui est possible d'en faire, nous verrons comment l'outil crane, développé par Google, permet de rebaser des images sans avoir besoin de les re-construire !
Nous verrons alors quelques cas d'usages de patching en démo !