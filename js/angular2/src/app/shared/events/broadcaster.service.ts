import { Injectable } from '@angular/core';

@Injectable()
export class BroadcasterService {

	private listeners:any[];
	
	
	constructor() { }
	
	
	
	
  public addListener(type:string, handler:any):void
  {
    if(this.listeners == null) this.listeners = [];
    this.listeners.push({"type" : type, "handler" : handler});
	}
	
	
	public containListener(type:string):boolean
	{
    if(this.listeners == null) this.listeners = [];
		for (var i in this.listeners) {
			var obj = this.listeners[i];
			if(obj.type == type) return true;
		}
		return false;
	}
	
	
	public removeListener(type:string, handler:any):void
	{
		if(this.listeners == null) this.listeners = [];
		
		for (var i in this.listeners) {
			var obj = this.listeners[i];
			if(obj.type == type && handler == obj.handler){
				this.listeners.splice(+i, 1);
				break;
			}
		}
	}

  public dispatch(type:string):void
  {
    for (var i = 0; i < this.listeners.length; i++) {
      var item = this.listeners[i];
			if(item.type == type) item.handler();
			
    }
	}
	
	
}
