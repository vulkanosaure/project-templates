import { Injectable } from '@angular/core';

@Injectable()
export class PreloadImgService {

	constructor() { }
	
	length:number;
	counter:number;
	
	preload(tab:string[], handlerComplete:()=>void = null, timeAdd:number = 0) {
		var img;
		this.length = tab.length;
		this.counter = 0;
		
		for (var i = 0; i < this.length; i++) {
				
				let url:string = tab[i];
				
				img = new Image();
				img.onload = () => {
					this.counter++;
					if(this.counter == this.length){
						console.log('preload img complete '+this.counter+' / '+this.length);
						if(handlerComplete){
							console.log('preload img COMPLETE');
							if(timeAdd == 0) handlerComplete();
							else setTimeout(handlerComplete, timeAdd);
							
						}
					}
				}
				img.src = url;
				
				var div = document.createElement("div");
				div.style.backgroundImage = "url(" + url + ")";
				document.querySelector("body").appendChild(div);
				
		}
		
		if(this.length == 0 && handlerComplete) handlerComplete();
		
	}
	
	

}
