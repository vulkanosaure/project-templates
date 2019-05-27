import { Injectable } from '@angular/core';

@Injectable()
export class MouseWheelService {

	handler:(number) => void;
	constructor() { }
	
	
	init(window:any, handler:(number) => void):void
	{
		this.handler = handler;
		if (window.addEventListener)
		{
				// IE9, Chrome, Safari, Opera
				window.addEventListener("mousewheel", this.MouseWheelHandler.bind(this), false);
				// Firefox
				window.addEventListener("DOMMouseScroll", this.MouseWheelHandler.bind(this), false);
		}
		// IE 6/7/8
		else
		{
			window.attachEvent("onmousewheel", this.MouseWheelHandler.bind(this));
		}

		
	}
	
	
	
	private MouseWheelHandler(e)
	{
			// cross-browser wheel delta
			var e = window.event || e; // old IE support
			var delta = Math.max(-1, Math.min(1, (e.wheelDelta || -e.detail)));

			if(this.handler) this.handler(delta);
			return false;
	}
	
	
	
	
	
}
