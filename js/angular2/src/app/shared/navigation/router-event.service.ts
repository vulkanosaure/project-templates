import { Injectable } from '@angular/core';
import { UrlParserService } from './url-parser.service';
import { NavigationEnd, Router, Routes } from '@angular/router';




/*
TODO : 
ptet configurer des include / exclude (la j'ai que des include)

*/


@Injectable()
export class RouterEventService {

	private options:RouterListenerOptions[];
	private outlets:string[];
	private routes:Routes;
	
	private routeActive:any = {};
	private outletActive:any = {};
	
	
  constructor(
		private urlParser:UrlParserService,
		private router:Router,
	) {
		
		
		
		this.router.events.subscribe((event) => {
			
			if (event instanceof NavigationEnd) {
				
				let url:string = event.url;
				// console.log('url '+url);
				// "/board(modal:modal-result)"
				
				
				let outlets:string[] = this.outlets.slice(0);
				outlets.unshift(null);
				
				let currentRoutes:string[] = [];
				let currentOutlets:string[] = [];
				let len = outlets.length;
				for(let i=0;i<len;i++){
					
					let outlet:string = outlets[i];
					let route:string = this.urlParser.getRoute(url, outlet);
					if(route){
						currentRoutes.push(route);
						currentOutlets.push(outlet);
					}
				}
				
				//set active routes
				
				for(let k in this.routeActive) this.routeActive[k] = false;
				for(let k in currentRoutes){
					let route = currentRoutes[k];
					this.routeActive[route] = true;
				}
				
				//set active outlets
				for(let k in this.outletActive) this.outletActive[k] = false;
				for(let k in currentOutlets){
					let outlet = currentOutlets[k];
					this.outletActive[outlet] = true;
				}
				
				
				
				len = this.options ? this.options.length : 0;
				for(let i=0;i<len;i++){
					
					let option = this.options[i];
					let len2 = option.listeners.length;
					let hit:boolean = false;
					
					for(let j=0;j<len2;j++){
						let listener:RoutesListener = option.listeners[j];
						
						let intersect = this.getIntersection(listener.routes, currentRoutes);
						
						if(intersect.length > 0){
							hit = true;
							if(option.indexActive != j || option.dispatchEachRoute){
								option.indexActive = j;
								let route:string = intersect[0];
								listener.handlerEnter(route);
								break;
							}
						}
					}
					
					if(!hit){
						if(option.indexActive != -1 || option.dispatchEachRoute){
							option.indexActive = -1;
							if(option.handlerLeave) option.handlerLeave();
						}
					}
					
				}
				
			}
		});
		
	}
	
	
	
	
	private getIntersection<T>(array1:T[], array2:T[]):T[]
	{
		return array1.filter(value => -1 !== array2.indexOf(value));
	}
	
	
	public setRoutes(routes:Routes):void
	{
		this.routes = routes;
		
		this.outlets = [];
		for(let k in routes){
			let item = routes[k];
			this.routeActive[item.path] = false;
			
			if(item.outlet && this.outlets.indexOf(item.outlet) == -1){
				this.outlets.push(item.outlet);
				this.outletActive[item.outlet] = false;
			}
		}
		
	}
	
	
	
	addListener(routes:string[], handlerEnter:(route?:string)=>void, handlerLeave:()=>void = null, dispatchEachRoute:boolean = false):void
	{
		this.addListeners(
			[
				{
					routes,
					handlerEnter,
				}
			],
			handlerLeave,
			dispatchEachRoute,
		);
	}
	 
	 
	addListeners(listeners:RoutesListener[], handlerLeave:()=>void = null, dispatchEachRoute:boolean = false):void
	{
		if(!this.options) this.options = [];
		this.options.push({
			listeners,
			handlerLeave,
			dispatchEachRoute,
			indexActive: null,
		});
		
	}
	
	
	public isOutletActive(outlet:string):boolean
	{
		console.log('isOutletActive ' + outlet);
		if(!this.outletActive[outlet]) return false;
		return true;
	}
	
	public isRouteActive(route:string):boolean
	{
		// console.log('isRouteActive ' + route);
		if(!this.routeActive[route]) return false;
		return true;
	}
	
	
	
}


interface RouterListenerOptions{
	
	/* 
	routes:string[],
	handlerEnter:(route?:string) => void,
	*/
	listeners:RoutesListener[],
	handlerLeave:() => void,
	dispatchEachRoute:boolean;
	indexActive:number,
	
	
}

interface RoutesListener{
	
	routes:string[],
	handlerEnter:(route?:string) => void,
	
}

