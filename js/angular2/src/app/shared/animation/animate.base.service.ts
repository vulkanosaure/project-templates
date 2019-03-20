import { AnimType, Easing, AnimArgs } from './animation.interface';

/*
todo :

preset d'options enregistré sous une key
soit abandonner les options par type, ou séparer les in/out
sequenceLoop(regex{{i0|i1}}, length)	//faire passer en optional
*/




export class AnimateBase {
	
	public static enableTime:boolean = true;
	
	protected delay:number;
	
	private static paramsKey:any = {};
	
	private static params:any = {
		[AnimType.GLOBAL] :{
			dir: 'top',
			distanceIn: 300,
			distanceOut: 300,
			useMargin:false,
			fade:true,
			timeIn: 0.3,
			timeOut: 0.2,
			easeIn: Easing.EASE_OUT,
			easeOut: Easing.EASE_OUT,
			scaleStart: 0.1,
			scaleEnd: 0.1,
			zoomX:false,
			zoomY:false,
			
			time:0.5,
			
			
		},
		
		[AnimType.FADE] : {
			timeIn: 0.3,
			timeOut: 0.2,
			easeIn: Easing.EASE_OUT,
			easeOut: Easing.EASE_OUT,
		},
		
	}
	
	

	constructor() { 
		this.delay = 0;
	}
	
	public reset():AnimateBase
	{
		this.delay = 0;
		return this;
	}
	
	
	
	
	getOptions(args:AnimArgs|string, animType:AnimType = null):AnimArgs
	{
		let output:AnimArgs = {};
		
		if(typeof args == 'string'){
			if(!AnimateBase.paramsKey[args]) throw new Error('Arg options "'+args+'" doesn\'t exist');
			args = AnimateBase.paramsKey[args];
		}
		
		let tests:AnimArgs[] = [
			AnimateBase.params[AnimType.GLOBAL],
			animType && AnimateBase.params[animType],
			args,
		];
		
		for(let k in tests){
			let item = tests[k];
			if(!item) continue;
			if(item && item.hasOwnProperty('dir')) output.dir = item.dir;
			if(item && item.hasOwnProperty('timeIn')) output.timeIn = item.timeIn;
			if(item && item.hasOwnProperty('timeOut')) output.timeOut = item.timeOut;
			if(item && item.hasOwnProperty('easeIn')) output.easeIn = item.easeIn;
			if(item && item.hasOwnProperty('easeOut')) output.easeOut = item.easeOut;
			if(item && item.hasOwnProperty('distanceIn')) output.distanceIn = item.distanceIn;
			if(item && item.hasOwnProperty('distanceOut')) output.distanceOut = item.distanceOut;
			if(item && item.hasOwnProperty('useMargin')) output.useMargin = item.useMargin;
			if(item && item.hasOwnProperty('fade')) output.fade = item.fade;
			if(item && item.hasOwnProperty('scaleStart')) output.scaleStart = item.scaleStart;
			if(item && item.hasOwnProperty('scaleEnd')) output.scaleEnd = item.scaleEnd;
			if(item && item.hasOwnProperty('zoomX')) output.zoomX = item.zoomX;
			if(item && item.hasOwnProperty('zoomY')) output.zoomY = item.zoomY;
			
			if(item && item.hasOwnProperty('time')) output.time = item.time;
			if(item && item.hasOwnProperty('prop')) output.prop = item.prop;
			if(item && item.hasOwnProperty('ease')) output.ease = item.ease;
			if(item && item.hasOwnProperty('startValue')) output.startValue = item.startValue;
			if(item && item.hasOwnProperty('endValue')) output.endValue = item.endValue;
			
			if(item && item.hasOwnProperty('blinkTimes')) output.blinkTimes = item.blinkTimes;
			if(item && item.hasOwnProperty('blinkDelay')) output.blinkDelay = item.blinkDelay;
			
			if(item && item.hasOwnProperty('onComplete')) output.onComplete = item.onComplete;
			if(item && item.hasOwnProperty('onUpdate')) output.onUpdate = item.onUpdate;
			if(item && item.hasOwnProperty('round')) output.round = item.round;
		}
		
		if(!AnimateBase.enableTime){
			output.time = 0;
			output.timeIn = 0;
			output.timeOut = 0;
		}
		
		
		return output;
	}
	
	public static addTypeOptions(type:AnimType, params:AnimArgs):void
	{
		this.params[type] = {...this.params[type], ...params};
		
	}
	
	
	public static addKeyOptions(key:string, params:AnimArgs):void
	{
		this.paramsKey[key] = params;
	}
	
	
	
	protected getTransformValue(scale:number, zoomX:boolean, zoomY:boolean):string
	{
		if(zoomX) return 'scaleX('+ scale +')';
		if(zoomY) return 'scaleY('+ scale +')';
		return 'scale('+ scale +')';
	}
	
	
	
	
	//___________________________________________________________________
	
	getSlideIn(options:AnimArgs):AnimCalculations
	{
		let prop:string = (['top', 'bottom'].indexOf(options.dir) > -1) ? 'top' : 'left';
		let ratio:number = (['top', 'left'].indexOf(options.dir) > -1) ? +1 : -1;
		
		if(options.useMargin){
			
			if(options.dir == 'top') prop = 'marginBottom';
			else if(options.dir == 'bottom') prop = 'marginTop';
			else if(options.dir == 'left') prop = 'marginRight';
			else if(options.dir == 'right') prop = 'marginLeft';
			
			if(['marginBottom', 'marginRight'].indexOf(prop) > -1) ratio = -1;
		}
		
		let valuestart = options.distanceIn * ratio;
		
		let styleinit:any = { 
			[prop]: valuestart + 'px',
		};
		let styleend:any = { 
			[prop]: '0px',
		};
		
		if(options.fade){
			styleinit['opacity'] = 0;
			styleend['opacity'] = 1;
		}
		if(prop.substr(0, 6) != 'margin') styleinit['position'] = 'relative';
		
		return { styleinit, styleend };
	}
	
	
	
	
	getSlideOut(options:AnimArgs):AnimCalculations
	{
		let prop:string = (['top', 'bottom'].indexOf(options.dir) > -1) ? 'top' : 'left';
		let ratio:number = (['top', 'left'].indexOf(options.dir) > -1) ? +1 : -1;
		
		if(options.useMargin){
			
			if(options.dir == 'top') prop = 'marginBottom';
			else if(options.dir == 'bottom') prop = 'marginTop';
			else if(options.dir == 'left') prop = 'marginRight';
			else if(options.dir == 'right') prop = 'marginLeft';
			
			if(['marginBottom', 'marginRight'].indexOf(prop) > -1) ratio = -1;
		}
		
		let valueend = options.distanceIn * ratio;
		
		let styleend:any = {
			[prop]: valueend + 'px',
		};
		if(options.fade) styleend['opacity'] = 0;
		if(prop.substr(0, 6) != 'margin') styleend['position'] = 'relative';
		
		return { styleend };
	}
	
	
	
	
	getFadeIn(options:AnimArgs):AnimCalculations
	{
		let styleinit:any = { 
			opacity: 0,
		};
		let styleend:any = { 
			opacity: 1,
		};
		return { styleinit, styleend };
	}
	
	getFadeOut(options:AnimArgs):AnimCalculations
	{
		let styleinit:any = { 
			opacity: 1,
		};
		let styleend:any = { 
			opacity: 0,
		};
		return { styleinit, styleend };
	}
	
	
	
	getZoomIn(options:AnimArgs):AnimCalculations
	{
		let styleinit:any = { transform: '*' };
		
		if(options.scaleStart){
			styleinit.transform = this.getTransformValue(options.scaleStart, options.zoomX, options.zoomY);
		}
		if(options.fade) styleinit['opacity'] = 0;
		
		
		let styleend:any = {
			opacity: 1,
			transform:'*',
		};
		
		if(options.scaleEnd){
			styleend.transform = this.getTransformValue(options.scaleEnd, options.zoomX, options.zoomY);
			
		}
		
		return { styleinit, styleend };
	}
	
	
	getZoomOut(options:AnimArgs):AnimCalculations
	{
		let value:string = this.getTransformValue(options.scaleEnd, options.zoomX, options.zoomY);
		
		let styleend:any = { 
			transform: value,
		};
		if(options.fade) styleend['opacity'] = 0;
		
		return { styleend };
	}
	
	
	
}



export interface AnimCalculations{
	
	styleinit?:any;
	styleend:any;
	
}

