import { Injectable } from '@angular/core';

@Injectable()
export class PreloadImgService {

	constructor() { }
	
	preload(tab:string[]) {
		var img;
		for (var i = 0; i < tab.length; i++) {
				/* 
				img = new Image()
				img.src = tab[i];
				*/
				var div = document.createElement("div");
				div.style.backgroundImage = "url("+tab[i]+")";
				document.querySelector("body").appendChild(div);
		}
	}
	
	

}
