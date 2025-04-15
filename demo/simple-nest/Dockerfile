FROM node:22

# Créer un répertoire pour l'application
WORKDIR /usr/src/app

# Copier les fichiers package.json et package-lock.json
COPY package*.json ./

# Installer les dépendances
RUN npm install

# Copier le reste des fichiers de l'application
COPY . .

RUN npm run build

# Exposer le port 3000
EXPOSE 3000

# Définir la variable d'environnement NODE_ENV
ENV NODE_ENV=production

# Démarrer l'application
CMD ["/bin/bash", "start.sh"]