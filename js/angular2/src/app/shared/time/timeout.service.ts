import { Injectable } from '@angular/core';

@Injectable()
export class TimeoutService {
	
	enabled:boolean = true;

	constructor() { }
	
	setTimeout(handler:any, delay:number, enabled:boolean = true):void
	{
		if(this.enabled && enabled) setTimeout(handler, delay);
		else handler();
	}
	
}
