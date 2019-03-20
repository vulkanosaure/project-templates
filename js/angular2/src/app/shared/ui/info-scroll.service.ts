import { Injectable } from '@angular/core';

@Injectable()
export class InfoScrollService {
	
	public updateHandler:()=>void;
	private elmt:any;
	public up:boolean;
	public down:boolean;
	
	private oldUp:boolean;
	private oldDown:boolean;
	
	constructor(
		
	) { }
	
	public init(elmt:any):void
	{
		this.elmt = elmt;
		this.elmt.onscroll = () => {
			this.update();
		};
		
	}
	
	
	public update():void
	{
		this.oldUp = this.up;
		this.oldDown = this.down;
		
		this.up = this.hasScrollUp();
		this.down = this.hasScrollDown();
		
		if(this.oldUp != this.up || this.oldDown != this.down){
			if(this.updateHandler) this.updateHandler();
		}
		
	}
	
	
	public hasScroll():boolean
	{
		return this.elmt.scrollHeight > this.elmt.clientHeight;
	}
	
	public hasScrollUp():boolean
	{
		return this.elmt.scrollTop > 0;
	}
	
	public hasScrollDown():boolean
	{
		let bottom:number = this.elmt.scrollTop + this.elmt.clientHeight;
		return bottom < this.elmt.scrollHeight;
		
	}
	
	
	
}
