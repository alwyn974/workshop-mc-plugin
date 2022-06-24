---
module:         B-INN-000
title:          Workshop Plugin Minecraft
subtitle:		Créer son premier plugin Minecraft

language:		java
build:			gradle

noFormalities:	false
noCleanRepo:	false
noBonusDir:		true
noErrorMess:	true

author:			Alwyn, Hugo
version:		1.0
---

# Workshop plugin Minecraft

## Pré-requis

Si vous n'avez pas déjà installé les outils nécessaires à ce workshop suivez les instructions situées ici : #br
[https://github.com/alwyn974/workshop-mc-plugin/blob/master/REQUIREMENTS.md](https://github.com/alwyn974/workshop-mc-plugin/blob/master/REQUIREMENTS.md)

## Configuration

### Création d'une task gradle

Pour pouvoir tester votre plugin, vous devez créer une task gradle, pour déplacer le plugin dans le dossier `server/plugins/`
Cette task aura pour nom `buildAndMove` devra dépendre de `build` et respecter les prérequis suivants :

- Etre exécuté en dernier
- Utiliser la task copy pour copier le plugin générer par le build dans le dossier `./server/plugins/`

#hint(Task avec gradle [Script basique](https://docs.gradle.org/current/userguide/tutorial_using_tasks.html), [Doc de la classe Task](https://docs.gradle.org/current/dsl/org.gradle.api.Task.html))

#hint(Utilisez `String.format` pour récupérer le nom du jar plus facilement, avec `archivesBaseName` et `version`)

### Création de la classe principale

Créez votre propre package, moi, ça sera `re.alwyn974.plugin.workshop`, dans ce package créer une classe `PluginNamePlugin` (ex: WorkshopPlugin).
Cette classe devra hériter de `JavaPlugin` de `org.bukkit.plugin.java` et surcharger les méthodes `onEnable()` et `onDisable()`
Dans chacune des méthodes ajouter simplement un message dans la console.

### Création du fichier `plugin.yml`

Dans le dossier `src/resources` créez le fichier `plugin.yml` avec le contenu suivant :

```yml
name: Plugin Name
version: 1.0
author: Your Name
main: com.github.pluginname.Main
```

Remplacez le `main` par votre classe qui hérite de `JavaPlugin` et le `name` par le nom de votre plugin.

#hint(Plus d'informations sur le [plugin.yml](https://www.spigotmc.org/wiki/plugin-yml/))

### Build

Pour tester votre plugin, vous devez exécuter la task gradle `buildAndMove` et ensuite lancer le docker-compose.

Si votre plugin est reconnu dans la console vous aurez quelque chose comme ceci :

#terminal(Affichage dans la console du serveur
[10:59:24 INFO]: [WorkshopPlugin] Loading WorkshopPlugin v1.0-SNAPSHOT
[10:59:24 INFO]: [WorkshopPlugin] Enabling WorkshopPlugin v1.0-SNAPSHOT
)

## Utilisation d'events

Comme avec Forge, les plugins utilisent aussi des events. 
Créez une classe `Events` qui implementera `Listener` de `org.bukkit.event`.
Pour chaque méthode qui recevra un event il faudra ajouter une annotation spécifique.

#hint(Comment utiliser les events spigot [Documentation](http://www.spigotmc.org/wiki/using-the-event-api/))

#newpage
### Modifier le message de connexion d'un joueur

En utilisant l'event `PlayerJoinEvent` créez une méthode `onPlayerJoin` qui recevra un event `PlayerJoinEvent`.
Lorsqu'un joueur rejoindra le serveur il faudra afficher un nouveau message que `PlayerName joined the game`.
<br>
Exemple: `[+] alwyn974 - 1/20`
<br>
Si vous voulez ajouter des couleurs au message vous pouvez utiliser la classe `ChatColor` de `org.bukkit.ChatColor` ou utiliser les colors codes.

#hint([Color Codes](https://minecraft.fandom.com/fr/wiki/Codes_de_mise_en_forme). Javadoc de [ChatColor](https://hub.spigotmc.org/javadocs/spigot/org/bukkit/ChatColor.html))

### Modifier le message de déconnexion d'un joueur

En utilisant l'event `PlayerQuitEvent` créez une méthode `onPlayerQuit` qui recevra un event `PlayerQuitEvent`.
Lorsqu'un joueur quittera le serveur il faudra afficher un nouveau que `PlayerName left the game`.
<br>
Exemple: `[-] alwyn974 - 0/20`

#hint(Avec de la couleur, c'est toujours mieux !)

## Création d'une commande simple

Pour créer une commande, il faut créer une classe qui implémente `CommandExecutor` de `org.bukkit.command` et surcharger la méthode `boolean onCommand`.
<br>
Créez une classe `EpitechCommand` dans le package `command` qui hérite de `CommandExecutor` et surcharge la méthode.
La commande devra :

- Lorsqu'elle est exécutée répondre à l'utilisateur avec le message `Marvin -42` en cyan
- Elle devra être utilisable par tout le monde
- Elle devra avoir aucune permission
- Lorsque l'on fait /help epitech, il faudra que la description soit: `Vous donne -42 de la part de Marvin :)`

Exemple depuis la console :

```log
[12:21:39 INFO]: --------- Help: /epitech -----------------------
[12:21:39 INFO]: Description: Vous donne -42 de la part de Marvin
[12:21:39 INFO]: Usage: /epitech
```

#hint(Documentation spigot pour créer une commande : [lien](https://www.spigotmc.org/wiki/create-a-simple-command/))
