# Étape 1 : Construction de l'application
FROM eclipse-temurin:23 AS builder
# Définir le répertoire de travail
WORKDIR /workspace
# Copier les fichiers nécessaires pour Maven
COPY .mvn .mvn
COPY mvnw pom.xml ./
# Télécharger les dépendances Maven pour accélérer la construction
RUN ./mvnw dependency:go-offline
# Copier le code source de l'application
COPY src ./src
# Construire l'application (générer le fichier JAR)
RUN ./mvnw clean package -DskipTests

# Étape 2 : Image finale pour exécution
FROM eclipse-temurin:23 AS runtime
# Définir le répertoire de travail
WORKDIR /app
# Exposer le port utilisé par l'application Spring Boot
EXPOSE 8080
# Copier le fichier JAR généré depuis l'étape précédente
COPY --from=builder /workspace/target/*.jar /app/app.jar
# Commande d'exécution de l'application Spring Boot
ENTRYPOINT ["/bin/bash", "start.sh"]
