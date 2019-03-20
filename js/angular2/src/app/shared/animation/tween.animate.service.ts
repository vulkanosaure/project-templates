import { Injectable } from '@angular/core';
import { TweenMax, Linear, Back, Power1 } from "gsap";
import { AnimateBase, AnimCalculations } from './animate.base.service';
import { AnimArgs, AnimType, Easing } from './animation.interface';
import { AnimationReferenceMetadata } from '@angular/animations';


@Injectable()
export class TweenAnimateService extends AnimateBase {
	
	public enableTime:boolean = true;
	
	constructor() {
		super();
		
	}
	
	public reset():TweenAnimateService
	{
		this.delay = 0;
		return this;
	}
	
	
	private exec(selector:any, delay:number, time:number, ease:Easing, calculations:AnimCalculations, options:AnimArgs):void
	{
		if(!this.enableTime){
			time = 0;
			delay = 0;
		}
		/* 
		if(calculations.styleinit && calculations.styleinit['marginRight']){
			calculations.styleinit['margin-right'] = calculations.styleinit['marginRight'];
			delete calculations.styleinit['marginRight'];
			
		}
		if(calculations.styleend && calculations.styleend['marginRight']){
			calculations.styleend['margin-right'] = calculations.styleend['marginRight'];
			delete calculations.styleend['marginRight'];
		}
		 */
		let args:any = calculations.styleend;
		if(calculations.styleinit) args.startAt = calculations.styleinit;
		args.delay = delay;
		args.ease = this.getEasing(ease);
		
		
		if(options.onComplete) args.onComplete = options.onComplete;
		if(options.onUpdate) args.onUpdate = options.onUpdate;
		
		
		//specific for tweenValue
		if(options.round){
			args.roundProps = [options.prop];
		}
		
		TweenMax.to(selector, time, args);
	}
	
	
	private easingValues:any = {
		
		[Easing.NONE] : Linear.easeNone,
		[Easing.BACK_OUT] : Back.easeOut,
		[Easing.EASE_OUT] : Power1.easeOut,
		[Easing.EASE_IN] : Power1.easeIn,
	};
	
	private getEasing(value:Easing):any
	{
		return this.easingValues[value];
	}
	
	
	
	//___________________________________________________________________
	
	
	//todo : set in options
	public bounce(selector:string, delay:number = 0, options:AnimArgs|string = null):void
	{
		options = this.getOptions(options, null);
		this.delay += delay;
		let time2:number = options.time / 2;
		
		this.exec(selector, this.delay, time2, Easing.EASE_IN, { styleend: { [options.prop]: options.endValue }}, options);
		this.exec(selector, this.delay + time2, time2, Easing.EASE_OUT, { styleend: { [options.prop]: options.startValue }}, options);
		
	}
	
	
	public flash(selector:string, delay:number = 0, options:AnimArgs|string = null):void
	{
		options = this.getOptions(options, null);
		this.delay += delay;
		let time1:number = options.time * 0.1;
		if(time1 > 0.07) time1 = 0.07;
		let time2:number = options.time - time1;
		
		this.exec(selector, this.delay, time1, Easing.NONE, { styleend: { 'opacity': 1.0 }}, options);
		this.exec(selector, this.delay + time1, time2, Easing.EASE_OUT, { styleend: { 'opacity': 0.0 }}, options);
		
	}
	
	
	public blink(selector:string, delay:number = 0, options:AnimArgs|string = null):void
	{
		options = this.getOptions(options, null);
		this.delay += delay;
		let elmt = document.querySelector(selector);
		
		
		let len:number = options.blinkTimes * 2 + 1;
		for(let i=0;i<len;i++){
			setTimeout(() => {
				(<any>elmt).style.visibility = (i % 2 == 1) ? 'hidden' : 'visible';
			}, options.blinkDelay * 0.5 * 1000 * i + this.delay * 1000);
		}
		
	}
	
	
	public tweenValue(obj:any, delay:number = 0, options:AnimArgs|string = null)
	{
		if(typeof options != 'string'){
			//condition ok (with false value)
			if(!<AnimArgs>options.round === undefined) options.round = true;
		}
		
		options = this.getOptions(options, null);
		this.delay += delay;
		
		let calculations:AnimCalculations = { styleend: { [options.prop] : options.endValue }};
		if(options.startValue){
			calculations.styleinit = { [options.prop] : options.startValue };
		}
		
		this.exec(obj, this.delay, options.time, options.ease, calculations, options);
	}
	
	
	public animBonus(obj:any, delay:number = 0, options:AnimArgs|string = null)
	{
		if(typeof options != 'string'){
			if(!<AnimArgs>options.ease) options.ease = Easing.NONE;
			if(!<AnimArgs>options.time) options.time = 0.8;
			if(!<AnimArgs>options.startValue) options.startValue = 0;
			if(!<AnimArgs>options.endValue) options.endValue = -50;
		}
		
		options = this.getOptions(options, null);
		this.delay += delay;
		
		let prop:string = options.useMargin ? 'margin-top' : 'top';
		let calculations:AnimCalculations = { 
			styleinit: {
				[prop] : options.startValue,
				opacity: 1.0,
			},
			styleend: {
				[prop] : options.endValue,
				opacity: 0.0,
			}
		};
		
		this.exec(obj, this.delay, options.time, options.ease, calculations, options);
	}
	
	
	
	
	
	public slideIn(selector:string, delay:number = 0, options:AnimArgs|string = null):void
	{
		options = this.getOptions(options, AnimType.SLIDE);
		this.delay += delay;
		let output:AnimCalculations = this.getSlideIn(options);
		this.exec(selector, this.delay, options.timeIn, options.easeIn, output, options);
	}
	
	public slideOut(selector:string, delay:number = 0, options:AnimArgs|string = null):void
	{
		options = this.getOptions(options, AnimType.SLIDE);
		this.delay += delay;
		let output:AnimCalculations = this.getSlideOut(options);
		this.exec(selector, this.delay, options.timeOut, options.easeOut, output, options);
	}
	
	public zoomIn(selector:string, delay:number = 0, options:AnimArgs|string = null):void
	{
		options = this.getOptions(options, AnimType.ZOOM);
		this.delay += delay;
		let output:AnimCalculations = this.getZoomIn(options);
		this.correctCalculations(output);
		
		
		this.exec(selector, this.delay, options.timeIn, options.easeIn, output, options);
	}
	
	public zoomOut(selector:string, delay:number = 0, options:AnimArgs|string = null):void
	{
		options = this.getOptions(options, AnimType.ZOOM);
		this.delay += delay;
		let output:AnimCalculations = this.getZoomOut(options);
		this.correctCalculations(output);
		
		this.exec(selector, this.delay, options.timeOut, options.easeOut, output, options);
	}
	
	public fadeIn(selector:string, delay:number = 0, options:AnimArgs|string = null):void
	{
		options = this.getOptions(options, AnimType.SLIDE);
		this.delay += delay;
		let output:AnimCalculations = this.getFadeIn(options);
		this.exec(selector, this.delay, options.timeIn, options.easeIn, output, options);
	}
	public fadeOut(selector:string, delay:number = 0, options:AnimArgs|string = null):void
	{
		options = this.getOptions(options, AnimType.SLIDE);
		this.delay += delay;
		let output:AnimCalculations = this.getFadeOut(options);
		this.exec(selector, this.delay, options.timeOut, options.easeOut, output, options);
	}
	
	
	private correctCalculations(output:AnimCalculations):void
	{
		if(output.styleinit.transform == '*') output.styleinit.transform = 'scale(1)';
		if(output.styleend.transform == '*') output.styleend.transform = 'scale(1)';
	}
	
	
	
}
