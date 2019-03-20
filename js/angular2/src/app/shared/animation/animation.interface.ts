export enum Easing{
	
	NONE,
	BACK_OUT,
	EASE_OUT,
	EASE_IN,
	EASE_IN_OUT,
	
} 

export enum AnimType{
	
	GLOBAL,
	SLIDE,
	FADE,
	ZOOM,
	
}

export interface AnimArgs{
	
	dir?:string,
	timeIn?:number,
	timeOut?:number,
	easeIn?:Easing,
	easeOut?:Easing,
	distanceIn?:number,
	distanceOut?:number,
	useMargin?:boolean,
	fade?:boolean,
	
	scaleStart?:number,
	scaleEnd?:number,
	zoomX?:boolean,	//x only
	zoomY?:boolean,	//y only
	
	
	time?:number, 
	prop?:string,
	ease?:Easing, 
	startValue?:any, 
	endValue?:any,
	round?:boolean,
	
	blinkTimes?:number,
	blinkDelay?:number,
	
	onComplete?:() => void,
	onUpdate?:() => void,
	
	
}
