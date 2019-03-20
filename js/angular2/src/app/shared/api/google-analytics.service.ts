import { Injectable } from '@angular/core';

declare var ga:any;

@Injectable()
export class GoogleAnalyticsService {

	constructor() { }
	
	public enabled:boolean = true;
	
	
	public set(key:string, value:any):void
	{
		ga('set', key, value);
	}
	
	
	public emitEvent(eventCategory: string,
		eventAction: string,
		eventLabel: string = null,
		eventValue: number = null) {
		
		if(!this.enabled) return;
		console.log("GA.emitEvent("+eventCategory+", "+eventAction+")");
		
		ga('send', 'event', {
			eventCategory: eventCategory,
			eventLabel: eventLabel,
			eventAction: eventAction,
			eventValue: eventValue
		});
		
	}
	
	
	public emitPage(page:string) {
		
		if(!this.enabled) return;
		console.log("GA.emitPage("+page+")");
		
		ga('send', 'pageview', {
			'page': page,
			'title': page
		});
	}
}
