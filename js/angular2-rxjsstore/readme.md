# backend calls proxy

� la racine, cr�er proxy.config.json

{
	"/api":{
		"target" : "http://localhost/apps/elanguage_v2/api",
		"secure" : false,
		"logLevel" : "debug",
		"pathRewrite": {"^/api" : ""}
	}
}

package.json
ajouter au script start :  --proxy-config proxy.config.json
todo : voir comment faire pour cot� serveur

autre solution : environment.apiUrl
	ideal : mettre les data dans un fichier config.json en asset, load� dynamiquement






# compilation

ng build --base-href /app/ --aot=false
--prod for minification

environment ne marchait pas
	- mise � jour de angular/cli local (1.6)
	- un lien mort dans angular-cli.json