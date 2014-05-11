BikeWarSDK_hx
=============

Haxe SDK pour Bikewar

depends on taminahx : https://github.com/damoebius/taminahx.git

Instructions :

- Installez haxe 
http://haxe.org/download

- Installez Git
http://git-scm.com/downloads

- Installez taminahx
haxelib git taminahx https://github.com/damoebius/taminahx.git master tamina/src

- Compilez votre robot
haxe -cp src -js MyIA.js -main MyIA -debug -lib taminahx
avec src le chemin vers le dossier src du sdk
