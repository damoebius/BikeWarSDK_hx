BikeWarSDK_hx: Développer en Haxe pour Code Of War: Bike War
----

#### Méthode la plus simple

La méthode la plus simple est d'utiliser IntelliJ IDEA avec le plugin Haxe pour développer et compiler. Tout est préconfiguré et ne nécessite que quelques étapes.

1. Télécharger [IntelliJ IDEA](http://www.jetbrains.com/idea/) et l'installer
2. Télécharger le [plugin Haxe pour IntelliJ](http://plugins.jetbrains.com/plugin/download?pr=idea&updateId=15798) et l'installer:
  * Lancer IntelliJ
  * Sur l'écran d'accueil, cliquer sur Configure > Plugins
  * En bas de la liste, cliquer sur le bouton Install plugin from disk...
  * Sélectionner le fichier zip du plugin
3. Télécharger et installer [NodeJS](http://nodejs.org/download/) (utilisé pour NodeJS Package Manager aka NPM).
4. Télécharger une copie du [SDK Code Of War: Bike War](https://github.com/thearsenik/BikeWarSDK_hx/archive/master.zip) et le dézipper.
5. Ouvrir une console et se placer dans le répertoire de Bike War
6. Lancer la commande suivante: npm install
7. Lancer IntelliJ et ouvrir le projet Bike War

Si tout s'est bien passé, vous devriez pouvoir compiler l'IA de base sans problème.

Pour faciliter le développement, il est utile d'avoir un moyen de tester l'IA en local. Voici comment optimiser le développement:

1. Télécharger [le runtime en local](http://www.tamina-online.com/expantion-origin/local.zip) et le dézipper. Nous appelerons ce dossier [local].
2. Dans IntelliJ faire un clique droit sur le projet > Open Module Settings
3. Dans la fenêtre qui s'ouvre, dans la section Modules > BikeWarHx > Haxe:
  * Changer le champ Output file name pour lui donner le nom que vous souhaitez (exemple: sons-of-anarchy.js)
  * Dans le champ Output folder, mettre le chemin vers le dossier [local]/js
4. Editer le fichier [local]/index.html et changer la ligne suivante:

```
com.tamina.bikewar.PlayerUI.init("damo","js/release/Basic_IA.js","moebius","js/release/Basic_IA.js",false);
```

Enfin, changer le chemin d'un des deux fichier js pour le votre. Par exemple:

```
com.tamina.bikewar.PlayerUI.init("damo","js/release/Basic_IA.js","The Biker","js/release/sons-of-anarchy.js",false);
```

Vous pouvez maintenant lancer le fichier [local]/index.html pour tester votre IA. Appuyer sur le bouton "Fight" pour voir que votre IA ne fonctionne pas correctement (Eh oui, personne n'y arrive jamais du premier coup).

#### Autres méthodes

Code Of War: Bike War dépend de taminahx : https://github.com/damoebius/taminahx.git.
Vous pouvez l'installer avec la commande `haxelib git taminahx https://github.com/damoebius/taminahx.git master tamina/src` (installer Git ou Git-scm si besoin).

Il vous faudra pour cela télécharger le SDK haxe: [http://haxe.org/download](http://haxe.org/download)

Compilez votre robot en utilisant la commande

```
haxe -cp src -js MyIA.js -main MyIA -debug -lib taminahx
```

avec src le chemin vers le dossier src de Bike War SDK.

Si vous rencontrez un problème avec la lib taminahx, vous pouvez copier les sources qui a été téléchargée dans le répertoire de Haxe

