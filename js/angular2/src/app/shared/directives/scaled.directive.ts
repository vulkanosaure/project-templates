import { Directive, Host, Self, Optional, ElementRef, Renderer2, HostListener, Input, SimpleChange, SimpleChanges } from '@angular/core';
import { WindowRef } from '../utils/window.service';

@Directive({
  selector: '[scaledLayout]'
})
export class ScaledDirective {
	
	@Input('scaledLayout') options:scaledOptions;
	@Input('vnScaledMode') mode:string;
	@Input('vnScaledEnabled') enabled:boolean = true;
	//default : center
	@Input('vnScaledAnchor') anchor:scaledAnchorProp = null;
	
	
	
	
	@HostListener('window:resize', ['$event']) 
	onResize($event):void
	{
		this.handleResize($event.target);
	}

  constructor(
		@Host() @Self() @Optional() public host : ElementRef,
		public renderer: Renderer2,
		private windowRef:WindowRef,
	) {
	}
	
	
	
	handleResize(window):void
	{
		let enabled:boolean = this.getEnabled();
		if(!enabled) return;
		
		let windowWidth:number = window.innerWidth;
		let windowHeight:number = window.innerHeight;
		
		let el:any= this.host.nativeElement;
		/* 
		let elWidth:number = el.clientWidth;
		let elHeight:number = el.clientHeight;
		*/
		
		let scale:number;
		
		let mode:string = this.getMode();
		if(mode == 'contain'){
			scale = Math.min(
				windowWidth / this.options.uiWidth,
				windowHeight / this.options.uiHeight,
			);
			
			console.log('scale : ');
			console.log(windowWidth+' / '+this.options.uiWidth);
			console.log(windowHeight+' / '+this.options.uiHeight);
			console.log('= '+scale);
			
			
		}
		else if(mode == 'cover'){
			scale = Math.max(
				windowWidth / this.options.uiWidth,
				windowHeight / this.options.uiHeight,
			);
		}
		else throw new Error('ScaledDirective mode '+mode+' doesnt exist');
		
		let factor:number = this.options.scaleFactor || 1;
		scale *= factor;
		
		
		let anchorstr:string = '';
		let anchor = this.getAnchor();
		let translateValues:number[];
		
		if(anchor == scaledAnchorProp.TOP_LEFT) translateValues = [0, 0];
		if(anchor == scaledAnchorProp.TOP) translateValues = [-50, 0];
		if(anchor == scaledAnchorProp.TOP_RIGHT) translateValues = [-100, 0];
		
		else if(anchor == scaledAnchorProp.CENTER_LEFT) translateValues = [0, -50];
		else if(anchor == scaledAnchorProp.CENTER) translateValues = [-50, -50];
		else if(anchor == scaledAnchorProp.CENTER_RIGHT) translateValues = [-100, -50];
		
		else if(anchor == scaledAnchorProp.BOTTOM_LEFT) translateValues = [0, -100];
		else if(anchor == scaledAnchorProp.BOTTOM) translateValues = [-50, -100];
		else if(anchor == scaledAnchorProp.BOTTOM_RIGHT) translateValues = [-100, -100];
		
		let scalePercent:number = scale * 100;
		let translateX:number = this.getResizeValue(scalePercent, translateValues[0]);
		let translateY:number = this.getResizeValue(scalePercent, translateValues[1]);
		
		anchorstr = 'translate('+translateX+'%, '+translateY+'%)';
		
		let value:string = anchorstr + " " + "scale(" + scale + ")";
		this.renderer.setStyle(el, 'transform', value);
		
		
		// console.log('ui : '+this.options.uiWidth+', '+this.options.uiHeight+' w : '+windowWidth+','+windowHeight+', scale : '+scale);
		
	}
	
	
	private getResizeValue(scalePercent:number, translateValue:number):number
	{
		// if(translateValue == -100) return -scalePercent - (-translateValue - scalePercent) *0.5;
		if(translateValue == -100) return scalePercent * -0.5 + 50;
		else if(translateValue == 0) return scalePercent * 0.5 - 50;
		//100 = 0
		//50 = -25
		//0 = -50
		
		//bottom :
		//0% 		=> +50
		//50% 	=> +25
		//100% 	=> 0
		
		
		
		else if(translateValue == -50) return translateValue;
	}
	
	
	
	ngOnInit(): void {
		this.handleResize(this.windowRef.nativeWindow);
		
		this.enabled;
		
	}
	
	ngOnChanges(changes:SimpleChanges):void
	{
		if(changes.enabled){
			
			if(!this.enabled) this.reset();
			else this.handleResize(this.windowRef.nativeWindow);
			
		}
	}
	
	reset():void
	{
		let el:any= this.host.nativeElement;
		this.renderer.setStyle(el, 'transform', null);
	}
	
	getScaleFactor():number
	{
		return 
	}
	getAnchor():scaledAnchorProp
	{
		if(this.anchor) return this.anchor;
		else if(this.options.anchor) return this.options.anchor;
		return scaledAnchorProp.CENTER;
	}
	getMode():string
	{
		if(this.mode) return this.mode;
		else if(this.options.mode) return this.options.mode;
		return 'contain';
	}
	getEnabled():boolean
	{
		// console.log('get enabled '+this.enabled);
		return this.enabled;
	}
	
	

}




export interface scaledOptions{
	
	mode:string,
	uiWidth:number,
	uiHeight:number,
	anchor:scaledAnchorProp,
	scaleFactor?:number,
	
}


export enum scaledAnchorProp{
	TOP_LEFT = 'TOP_LEFT',
	TOP = 'TOP',
	TOP_RIGHT = 'TOP_RIGHT',
	CENTER_LEFT = 'CENTER_LEFT',
	CENTER = 'CENTER',
	CENTER_RIGHT = 'CENTER_RIGHT',
	BOTTOM_LEFT = 'BOTTOM_LEFT',
	BOTTOM = 'BOTTOM',
	BOTTOM_RIGHT = 'BOTTOM_RIGHT',
}