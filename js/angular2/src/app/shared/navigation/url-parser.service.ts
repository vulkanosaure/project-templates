import { Injectable } from '@angular/core';

@Injectable()
export class UrlParserService {

	constructor() { }
	
	
	getRoute(url:string, outlet:string = null):string
	{
		let output:string;
		if(!outlet){
			let matches = url.match(new RegExp("\/([^(]+)"));
			if(matches && matches.length >= 1) output = matches[1];
		}
		else{
			let matches = url.match(new RegExp("\("+outlet+":([^/)]+)\)"));
			if(matches && matches.length >= 2) output = matches[2];
		}
		return output;
	}
	
	
}
