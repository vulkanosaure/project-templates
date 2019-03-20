import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class PlatformService {

	constructor() { }
	
	isAndroid():boolean
	{
		var ua = navigator.userAgent.toLowerCase();
		return ua.indexOf("android") > -1;
	}
	
	isIOS():boolean
	{
		var ios = /iPad|iPhone|iPod/.test(navigator.userAgent) && !(<any>window).MSStream;
		return ios;
	}
	
	
	isMobile():boolean
	{
		//totest
		var ua = navigator.userAgent.toLowerCase();
		var matches = navigator.userAgent.match(/(ipad)|(iphone)|(ipod)|(android)|(webos)/i);
		return matches != null;
	}
	
	
	
	
	isFirefox():boolean
	{
		return navigator.userAgent.toLowerCase().indexOf('firefox') > -1;
	}
	
	
	
	
}
