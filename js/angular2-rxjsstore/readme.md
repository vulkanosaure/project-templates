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

todo : voir comment faire pour backend






# compilation

todo...