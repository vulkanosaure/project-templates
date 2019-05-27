import { Injectable } from '@angular/core';

@Injectable()
export class KeyboardService {

	handler:(number) => void;
	constructor() { }
	
	
	init(window:any, handler:(number) => void):void
	{
		this.handler = handler;
		
		window.onkeydown = function(e) {
			var key = e.keyCode ? e.keyCode : e.which;
			if(this.handler) this.handler(key);
	 	}.bind(this);
		
	}
}
