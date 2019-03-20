import { Injectable } from '@angular/core';

@Injectable()
export class TurnBasedService {
	
	
	public onNewTurn:(number)=>void;
	
	public nbturn:number;
	public lockUI:boolean;
	
	
	private index:number;
	

	constructor() { }
	
	
	init(index:number = 0):void
	{
		this.index = index;
		this.update();
	}
	
	
	public getIndex():number
	{
		return this.index;
	}
	
	private update():void
	{
		//test gameover
		
		if(this.nbturn && this.nbturn == this.index){
			
			//clearinterval timer
		}
		
		this.lockUI = false;
		//clearinterval timer
		
		/* 
		init timer
		interval timer
			decrement
			test timer : timeout
		 */
		
		if(this.onNewTurn) this.onNewTurn(this.index);
	}
	
	
	timeout():void
	{
		// sound
		// clearinterval
		// index++, update
	}
	
	
	valid():void
	{
		this.lockUI = true;
		//clearinterval timer
		
		
		this.index++;
		this.update();
	}
	
	
}
