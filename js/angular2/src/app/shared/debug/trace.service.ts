import { Injectable } from '@angular/core';

@Injectable()
export class TraceService {

	constructor() { }
	
	
	tracerec(msg:any, indent:number):void
	{
		let prefix:string = '';
		for(let i=0;i<indent;i++) prefix += '  ';
		console.log(prefix + msg);
	}
	
	
}
