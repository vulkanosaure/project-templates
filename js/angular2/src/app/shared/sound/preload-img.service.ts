import { Injectable } from '@angular/core';

@Injectable()
export class PreloadImgService {

	constructor() { }
	
	length:number;
	counter:number;
	
	preload(tab:string[], handlerComplete:()=>void = null) {
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
							handlerComplete();
						}
					}
				}
				img.src = url;
				
				var div = document.createElement("div");
				div.style.backgroundImage = "url(" + url + ")";
				document.querySelector("body").appendChild(div);
				
		}
	}
	
	

}
