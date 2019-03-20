import { Injectable, ElementRef } from '@angular/core';

@Injectable()
export class DragndropService {
	
	private obj:any = null;
	private offset:number[];
	private offsetItem:number[];
	public scalingRatio:number = 1.0;
	
	public onDrop:(elmt:any)=>void;
	

	constructor() { }
	
	public init(o, oRoot=null, minX=null, maxX=null, minY=null, maxY=null, bSwapHorzRef=null, bSwapVertRef=null, fXMapper=null, fYMapper=null):void
	{
		o.onmousedown	= this.start.bind(this);

		o.hmode			= bSwapHorzRef ? false : true ;
		o.vmode			= bSwapVertRef ? false : true ;

		o.root = oRoot && oRoot != null ? oRoot : o ;

		if (o.hmode  && isNaN(parseInt(o.root.style.left  ))) o.root.style.left   = "0px";
		if (o.vmode  && isNaN(parseInt(o.root.style.top   ))) o.root.style.top    = "0px";
		if (!o.hmode && isNaN(parseInt(o.root.style.right ))) o.root.style.right  = "0px";
		if (!o.vmode && isNaN(parseInt(o.root.style.bottom))) o.root.style.bottom = "0px";

		o.minX	= typeof minX != 'undefined' ? minX : null;
		o.minY	= typeof minY != 'undefined' ? minY : null;
		o.maxX	= typeof maxX != 'undefined' ? maxX : null;
		o.maxY	= typeof maxY != 'undefined' ? maxY : null;

		o.xMapper = fXMapper ? fXMapper : null;
		o.yMapper = fYMapper ? fYMapper : null;

		o.root.onDragStart	= new Function();
		o.root.onDragEnd	= new Function();
		o.root.onDrag		= new Function();
		
	}
	
	
	
	private start(e)
	{
		var o = this.obj = e.target;
		e = this.fixE(e);
		var y = parseInt(o.vmode ? o.root.style.top  : o.root.style.bottom);
		var x = parseInt(o.hmode ? o.root.style.left : o.root.style.right );
		o.root.onDragStart(x, y);

		o.lastMouseX	= e.clientX;
		o.lastMouseY	= e.clientY;
		
		this.offset = this.getOffset(o);
		this.offsetItem = [o.clientWidth * 0.5, o.clientHeight * 0.5];

		if (o.hmode) {
			if (o.minX != null)	o.minMouseX	= e.clientX - x + o.minX;
			if (o.maxX != null)	o.maxMouseX	= o.minMouseX + o.maxX - o.minX;
		} else {
			if (o.minX != null) o.maxMouseX = -o.minX + e.clientX + x;
			if (o.maxX != null) o.minMouseX = -o.maxX + e.clientX + x;
		}

		if (o.vmode) {
			if (o.minY != null)	o.minMouseY	= e.clientY - y + o.minY;
			if (o.maxY != null)	o.maxMouseY	= o.minMouseY + o.maxY - o.minY;
		} else {
			if (o.minY != null) o.maxMouseY = -o.minY + e.clientY + y;
			if (o.maxY != null) o.minMouseY = -o.maxY + e.clientY + y;
		}

		document.onmousemove	= this.drag.bind(this);
		document.onmouseup		= this.end.bind(this);

		return false;
	}

	private drag(e)
	{
		e = this.fixE(e);
		var o = this.obj;

		var ey	= e.clientY;
		var ex	= e.clientX;
		var y = parseInt(o.vmode ? o.root.style.top  : o.root.style.bottom);
		var x = parseInt(o.hmode ? o.root.style.left : o.root.style.right );
		var nx, ny;

		if (o.minX != null) ex = o.hmode ? Math.max(ex, o.minMouseX) : Math.min(ex, o.maxMouseX);
		if (o.maxX != null) ex = o.hmode ? Math.min(ex, o.maxMouseX) : Math.max(ex, o.minMouseX);
		if (o.minY != null) ey = o.vmode ? Math.max(ey, o.minMouseY) : Math.min(ey, o.maxMouseY);
		if (o.maxY != null) ey = o.vmode ? Math.min(ey, o.maxMouseY) : Math.max(ey, o.minMouseY);
		
		/* 
		nx = x + ((ex - o.lastMouseX) * (o.hmode ? 1 : -1) / this.scalingRatio);
		ny = y + ((ey - o.lastMouseY) * (o.vmode ? 1 : -1) / this.scalingRatio);
		 */
		nx = (e.clientX - this.offset[0]) / this.scalingRatio - this.offsetItem[0];
		ny = (e.clientY - this.offset[1]) / this.scalingRatio - this.offsetItem[1];

		if (o.xMapper)		nx = o.xMapper(y)
		else if (o.yMapper)	ny = o.yMapper(x)
		

		this.obj.root.style[o.hmode ? "left" : "right"] = nx + "px";
		this.obj.root.style[o.vmode ? "top" : "bottom"] = ny + "px";
		this.obj.lastMouseX	= ex;
		this.obj.lastMouseY	= ey;

		this.obj.root.onDrag(nx, ny);
		return false;
	}

	private end()
	{
		document.onmousemove = null;
		document.onmouseup   = null;
		this.obj.root.onDragEnd(	parseInt(this.obj.root.style[this.obj.hmode ? "left" : "right"]), 
									parseInt(this.obj.root.style[this.obj.vmode ? "top" : "bottom"]));
		
		if(this.onDrop) this.onDrop(this.obj);
									
		this.obj = null;
	}

	private fixE(e)
	{
		if (typeof e == 'undefined') e = window.event;
		if (typeof e.layerX == 'undefined') e.layerX = e.offsetX;
		if (typeof e.layerY == 'undefined') e.layerY = e.offsetY;
		return e;
	}
	
	private getOffset(elmt):number[]
	{
		var rect = elmt.offsetParent.getBoundingClientRect();
		return [rect.left, rect.top];
	}
	
	
	
	
}
