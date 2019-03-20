import { Injectable } from '@angular/core';
import { AnimationReferenceMetadata, animation, style, animate, useAnimation, AnimationMetadata, query } from '@angular/animations';
import { AnimType, Easing, AnimArgs } from './animation.interface';
import { AnimateBase, AnimCalculations } from './animate.base.service';

/*
todo :

preset d'options enregistré sous une key
soit abandonner les options par type, ou séparer les in/out
sequenceLoop(regex{{i0|i1}}, length)	//faire passer en optional


*/


type DslAnimFunction = (delay?:number, options?:AnimArgs) => AnimationReferenceMetadata;

@Injectable()
export class DslAnimateService extends AnimateBase {
	
	constructor() { 
		super();
		
	}
	
	public reset():DslAnimateService
	{
		this.delay = 0;
		return this;
	}
	
	
	
	//___________________________________________________________________
	
	
	
	
	private easingValues:any = {
		[Easing.NONE] : 'linear',
		[Easing.BACK_OUT] : 'cubic-bezier(0.175, 0.885, 0.32, 1.275)',
		[Easing.EASE_OUT] : 'ease-out',
		[Easing.EASE_IN] : 'ease-in',
		[Easing.EASE_IN_OUT] : 'ease-in-out',
	};
	
	private getEasing(value:Easing):any
	{
		return this.easingValues[value];
	}
	
	
	
	public sequenceLoop(selectorPattern:string, limit:number, func:DslAnimFunction, delay:number, delayInit:number = 0, reverse:boolean = false, options:AnimArgs = null):AnimationMetadata[]
	{
		let selectors:string[] = [];
		for(let i=0;i<limit;i++){
			
			let str:string = selectorPattern.replace('{{i0}}', i+'');
			str = str.replace('{{i1}}', (i + 1)+'');
			selectors.push(str);
		}
		return this.sequence(selectors, func, delay, delayInit, reverse, options, true);
		
	}
	
	
	
	public sequence(selectors:string[], func:DslAnimFunction, delay:number, delayInit:number = 0, reverse:boolean = false, options:AnimArgs = null, optional:boolean = false):AnimationMetadata[]
	{
		func = func.bind(this);
		
		let output:AnimationMetadata[] = [];
		if(reverse) selectors.reverse();
		
		let count:number = 0;
		for(let k in selectors){
			
			let d = count > 0 ? delay : delayInit;
			let selector = selectors[k];
			output.push(query(
				selector,
				func(d, options),
				{optional : optional}
			));
			count++;
		}
		
		return output;
	}
	
	
	
	
	public combine(functions:DslAnimFunction[], delay:number = 0, options:AnimArgs = null):AnimationReferenceMetadata
	{
		options = this.getOptions(options, null);
		
		var output:AnimationReferenceMetadata;
		let indexStyle:number;
		
		for(let i=0; i<functions.length; i++){
			let func = functions[i];
			func = func.bind(this);
			let item:AnimationReferenceMetadata = func(delay, options);
			if(i == 0){
				output = item;
				
				for(let j=0; j<functions.length; j++){
					let anim = item.animation[j];
					if(!anim.styles.styles || anim.styles.styles != '*'){
						indexStyle = j;
						break;	
					}
				}
				
			}
			else{
				
				this.delay -= delay;
				
				for(let j=0; j<functions.length; j++){
					
					let anim = item.animation[j];
					if(!anim.styles.styles || anim.styles.styles != '*'){
						let mix = output.animation[j].styles;
						output.animation[indexStyle].styles = {...anim.styles, ...mix};
					}
				}
			}
		}
		
		return output;
	}
	
	
	
	private addDelay(delay:number):void
	{
		this.delay += delay;
		if(!AnimateBase.enableTime) this.delay = 0;
	}
	
	
	
	//__________________________________________________________________
	
	
	
	
	public slideIn(delay:number = 0, options:AnimArgs|string = null):AnimationReferenceMetadata
	{
		options = this.getOptions(options, AnimType.SLIDE);
		this.addDelay(delay);
		let output:AnimCalculations = this.getSlideIn(options);
		
		return animation([
				style(output.styleinit),
				animate(options.timeIn + 's ' + (this.delay*1000) + 'ms ' + this.getEasing(options.easeIn), 
				style(output.styleend))
			]
		);
		
	}
	
	
	
	
	public slideOut(delay:number = 0, options:AnimArgs|string = null):AnimationReferenceMetadata
	{
		options = this.getOptions(options, AnimType.SLIDE);
		this.addDelay(delay);
		
		let output:AnimCalculations = this.getSlideOut(options);
		
		return animation([
				animate(options.timeOut + 's ' + (this.delay*1000) + 'ms ' + this.getEasing(options.easeOut), 
				style(output.styleend))
			]
		);
	}
	
	
	
	public fadeIn(delay:number = 0, options:AnimArgs|string = null):AnimationReferenceMetadata
	{
		options = this.getOptions(options, AnimType.FADE);
		this.addDelay(delay);
		
		return animation([
				style({opacity:0}),
				animate(options.timeIn + 's ' + (this.delay*1000) + 'ms', style('*'))
			]
		);
		
	}
	
	public fadeOut(delay:number = 0, options:AnimArgs|string = null):AnimationReferenceMetadata
	{
		options = this.getOptions(options, AnimType.FADE);
		this.addDelay(delay);
		
		return animation([
				animate(options.timeOut + 's ' + (this.delay*1000) + 'ms', style({opacity : 0}))
			]
		);
	}
	
	
	
	
	
	public zoomIn(delay:number = 0, options:AnimArgs|string = null):AnimationReferenceMetadata
	{
		options = this.getOptions(options, AnimType.ZOOM);
		this.addDelay(delay);
		let output:AnimCalculations = this.getZoomIn(options);
		
		return animation([
			style(output.styleinit),
			animate(options.timeIn + 's ' + (this.delay*1000) + 'ms ' + this.getEasing(options.easeIn), style(output.styleend))
		]);
		
	}
	
	public zoomOut(delay:number = 0, options:AnimArgs|string = null):AnimationReferenceMetadata
	{
		options = this.getOptions(options, AnimType.ZOOM);
		this.addDelay(delay);
		let output:AnimCalculations = this.getZoomOut(options);
		
		return animation([
			animate(options.timeIn + 's ' + (this.delay*1000) + 'ms ' + this.getEasing(options.easeIn), 
			style(output.styleend)
		)]
		);
		
	}
	
	
}

