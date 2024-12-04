# Étape 1 : Préparer le dépôt APT de Docker
echo "Mise à jour et installation des dépendances de Docker..."
apt-get update -y
apt-get install -y ca-certificates curl

# Configuration des permissions et téléchargement de la clé GPG Docker
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

# Étape 2 : Ajouter le dépôt Docker
echo "Ajout du dépôt Docker..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update -y

# Étape 3 : Installer Docker et les plugins nécessaires
echo "Installation de Docker et des plugins..."
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Vérifier que Docker est installé
echo "Vérification de l'installation de Docker..."
docker --versionc

# Étape 4 : Exécuter un test avec Docker
echo "Exécution du test Docker hello-world..."
docker run hello-world


echo "Installation terminée !"

mkdir -p ~/docker-services

sudo curl -L "https://github.com/docker/compose/releases/download/$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
