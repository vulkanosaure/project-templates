import { Injectable } from '@angular/core';

@Injectable()
export class SwipeService {

	tolerance:number;
	handler:(xDelta, yDelta) => void;
	
	constructor() { }
	
	public init(document, tolerance:number, handler:(xDelta, yDelta) => void):void
	{
		this.handler = handler;
		
		document.addEventListener('touchstart', handleTouchStart, false);        
		document.addEventListener('touchmove', handleTouchMove, false);
		
		document.addEventListener('mousedown', handleTouchStart, false);
		document.addEventListener('mousemove', handleTouchMove, false);
		document.addEventListener('mouseup', handleTouchStop, false);
		
		var xDown = null;                                                        
		var yDown = null;
		var mousedown = false;
		var prevX = null;
		var prevY = null;
		var initX = null;
		var initY = null;
		var startSwipe;
		
		function getTouches(evt) {
			return evt.touches ||             // browser API
						 (evt.originalEvent && evt.originalEvent.touches); // jQuery
		}                                                     
		
		function handleTouchStart(evt) {
			
				let touches = getTouches(evt);
				let firstTouch = touches ? touches[0] : evt;
				
				xDown = firstTouch.clientX;                                      
				yDown = firstTouch.clientY;
				prevX = xDown;
				prevY = yDown;
				initX = xDown;
				initY = yDown;
				
				mousedown = true;     
				startSwipe = false;
				                             
		};
		function handleTouchStop(evt){
			mousedown = false;
		}
		
		function handleTouchMove(evt) {
				
				let touches = getTouches(evt);
				let firstTouch = touches ? touches[0] : evt;
				
				if(mousedown){
					
					var xUp = firstTouch.clientX;                                    
					var yUp = firstTouch.clientY;
					
					var xDiff = xUp - prevX;
					var yDiff = yUp - prevY;
					
					prevX = xUp;
					prevY = yUp;
					
					let xDiffInit = Math.abs(xUp - initX);
					let yDiffInit = Math.abs(yUp - initY);
					let totalDiffInit = Math.sqrt(Math.pow(xDiffInit, 2) + Math.pow(yDiffInit, 2));
					// console.log('totalDiffInit : '+totalDiffInit);
					
					if(!startSwipe && totalDiffInit > tolerance){
						startSwipe = true;
					}
					
					if(startSwipe){
						if(handler) handler(xDiff, yDiff);
					}
					
					
				}
				
				                                          
		};
	}
	

	
	
}
