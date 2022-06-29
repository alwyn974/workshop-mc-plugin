# Pré-requis

## Logiciels

Il vous faudra :
- Le JDK 8
- Intellij Idea (Community/Ultimate)
- Docker (pour le serveur) ou lancer manuellement
- Launcher Minecraft (ci-dessous)
- Optionel : [Plugin Minecraft Development](https://plugins.jetbrains.com/plugin/8327-minecraft-development)

## Setup du Projet

Création du Projet avec Intellij Idea, pour cela faites un nouveau projet en utilisant Gradle.
Vous allez devoir modifier le build.gradle pour celui-ci :

```groovy
plugins {
    id 'java'
    id 'idea'
}

group = 'com.github.username.workshop' //Change this
version = '1.0-SNAPSHOT'

repositories {
    mavenCentral()
    maven {
        name = 'spigotmc-repo'
        url = 'https://hub.spigotmc.org/nexus/content/repositories/snapshots/'
    }
    maven {
        name = 'sonatype'
        url = 'https://oss.sonatype.org/content/groups/public/'
    }
}

dependencies {
    compileOnly 'org.spigotmc:spigot-api:1.12.2-R0.1-SNAPSHOT'
}

def targetJavaVersion = 8
java {
    def javaVersion = JavaVersion.toVersion(targetJavaVersion)
    sourceCompatibility = javaVersion
    targetCompatibility = javaVersion
    if (JavaVersion.current() < javaVersion) {
        toolchain.languageVersion = JavaLanguageVersion.of(targetJavaVersion)
    }
}

tasks.withType(JavaCompile).configureEach {
    if (targetJavaVersion >= 10 || JavaVersion.current().isJava10Compatible()) {
        options.release = targetJavaVersion
    }
}

processResources {
    def props = [version: version]
    inputs.properties props
    filteringCharset 'UTF-8'
    filesMatching('plugin.yml') {
        expand props
    }
}
```

Ne pas oublier de recharger le projet gradle sur Intellij Idea. Pour cela à droite vous avez un onglet `gradle` avec un icon de reload

## Serveur Minecraft

### Docker

Pour faciliter l'utilisation du serveur, voici un docker-compose.yml :

```yml
version: "3"

services:
  mc:
    container_name: mc
    image: itzg/minecraft-server:java8
    ports:
      - "25565:25565"
    environment:
      - EULA=TRUE
      - MEMORY=2G
      - VERSION=1.12
      - TYPE=SPIGOT
      - OPS=VOTRE_PSEUDO_MC #CHANGEZ VOTRE PSEUDO ICI
      - SPAWN_PROTECTION=0
      - VIEW_DISTANCE=16
      - SERVER_NAME=Spigot 1.12.2
      - DIFFICULTY=normal
      - MOTD=§aSpigot Minecraft Server §e1.12.2
      - SERVER_IP=0.0.0.0
      - EXEC_DIRECTLY=true
      - STOP_SERVER_ANNOUNCE_DELAY=10
      - ENABLE_COMMAND_BLOCK=true
      - USE_AIKAR_FLAGS=true
      - ONLINE_MODE=FALSE
    tty: true
    stdin_open: true
    restart: unless-stopped
    volumes:
      - ./server:/data
```

Pour lancer le serveur il faudra simplement faire `docker-compose up -d` et ensuite faire `docker attach mc` pour pouvoir avoir une console où l'on peut entrer des commandes
Pour redémarrer le serveur faites simplement `docker-compose restart`

Si vous n'avez pas docker vous pourrez lancer un serveur Minecraft à la main.

**N'oubliez pas de faire `docker-compose down` ou `docker stop mc` à la fin du workshop. Sinon vous aurez un docker avec 4Go de ram qui tourne tout le temps**

### Manuellement

Pour lancer un serveur Minecraft manuellement, téléchargez : https://cdn.getbukkit.org/spigot/spigot-1.12.2.jar <br>
Créez un nouveau dossier `server` contenant le fichier `spigot-1.12.2.jar` <br>
Pour lancer le serveur il faudra faire `java -Xmx2048M -jar spigot-1.12.2.jar` (Xmx correspond à la mémoire maximum allouée au serveur)

## Launcher Minecraft

Si vous n'avez pas Minecraft Premium, vous pouvez utiliser ce launcher : https://tlauncher.org/en/#osselector

Il vous faudra Minecraft **1.12.2**