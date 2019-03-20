import { ParamsService } from './../utils/params.service';
import { Router } from '@angular/router';
import { Injectable } from '@angular/core';
import { CallbackModal } from './modals.interface';
import {Location} from "@angular/common";

/*
	
	openPrev()
		inter outlet ?
	timings								TODO
	
*/




interface NavigationGroup {
	[name: string]: NavigationServiceSub;
}


interface QueueItem{
	
	route:string,
	outlet:string,
	options:NavigationOptions,
	
}

export interface NavigationOptions{
	
	params?:any, 
	paramsMethod?:NavigationParamMethod,
	position?:NavigationQueuePosition | string | number,
	
	listeners?:any,		//[route] : ()=>void
	closeListener?:()=>void,
	skipLocationChange?:boolean,
	delayAfterClose?:number,		//seconds
}

export enum NavigationQueuePosition{
	REPLACE_FIRST = 'replaceFirst',
	BEFORE = 'before',
	AFTER = 'after',
}

export enum NavigationParamMethod{
	URL,
	MEMORY,
}





@Injectable()
export class NavigationService {
	
	public options:NavigationOptions = {
		
		paramsMethod: NavigationParamMethod.MEMORY,
		position: NavigationQueuePosition.REPLACE_FIRST,
		skipLocationChange: true,
		delayAfterClose: 0.4,
		
	};
	
	
	private instances:NavigationGroup;
	private handlersOutlet:any;
	private params:any = {};
	
	constructor(
		private router: Router,
		private paramsService: ParamsService,
		private location:Location,
	) {
		this.instances = {};
	}
	
	
	private getInstance(outlet:string):NavigationServiceSub
	{
		if(!outlet) outlet = 'main';
		if(!this.instances[outlet]){
			this.instances[outlet] = new NavigationServiceSub(
				this.router,
				this.paramsService,
				this.location,
				this,
			);
		}
		return this.instances[outlet];
	}
	
	
	public open(route:string, outlet:string = null, options:NavigationOptions = null): void
	{
		//outlet listener
		
		let outletName:string = outlet || 'root';
		if(this.handlersOutlet && this.handlersOutlet[outletName]){
			this.handlersOutlet[outletName].forEach((handler:any) => {
				handler();
			});
		}
		
		let inst = this.getInstance(outlet);
		inst.open(route, outlet, options);
	}
	
	
	
	public close(outlet:string = null): void
	{
		let inst = this.getInstance(outlet);
		inst.close(outlet);
	}
	
	
	public removeItem(route:string, outlet:string = null):void
	{
		let inst = this.getInstance(outlet);
		inst.removeItem(route);
	}
	
	
	
	
	
	
	
	
	
	
	public addOutletListener(outlet:string, handler:()=>void):void
	{
		let outletName:string = outlet || 'root';
		if(!this.handlersOutlet) this.handlersOutlet = {};
		if(!this.handlersOutlet[outletName]) this.handlersOutlet[outletName] = [];
		this.handlersOutlet[outletName].push(handler);
		
	}
	
	
	
	//see if problems of encapsulation (2 same route in 2 different outlets)
	//peut etre cette methode peut gérer le cas url
	public getParams(route:string):any
	{
		return this.params[route];
	}
	public setParams(route:string, data:any):void
  {
    this.params[route] = data;
  }
	
	
}






class NavigationServiceSub {
	
	queue:QueueItem[] = [];
	history:QueueItem[] = [];
	
	
	
	constructor(
		private router: Router,
		private paramsService: ParamsService,
		private location:Location,
		private navService:NavigationService,
	) { }
	
	
	
	
	public open(route: string, outlet: string, options:NavigationOptions): void
	{
		//default options
		options = {...this.navService.options, ...options, };
		
		let item:QueueItem = { route, outlet, options };
		
		
		//replace first
		if(options.position == NavigationQueuePosition.REPLACE_FIRST){
			if(this.queue.length == 0) this.queue.push(item);
			else this.queue[0] = item;
		}
		//before
		else if(options.position == NavigationQueuePosition.BEFORE){
			this.queue.unshift(item);
		}
		//after
		else if(options.position == NavigationQueuePosition.AFTER){
			this.queue.push(item);
		}
		//index
		else{
			let index:number = <number>options.position;
			this.queue.splice(index, 0, item);
		}
		
		//if first of the queue
		let open:boolean = this.queue[0].route == route;
		// debugger;
		if(open){
			this.openExec(route, outlet, options);
			this.history.push(item);
		}
		
	}
	
	public close(outlet: string = null): void
	{
		this.closeExec(outlet);
		this.closeHandler();
	}
	
	public removeItem(route:string):void
	{
		this.queue = this.queue.filter(item => item.route != route);
	}
	
	
	
	
	//____________________________________________________________
	//handlers
	
	private closeHandler():void
	{
		let item:QueueItem = this.queue[0];
		
		//close handler
		if(item && item.options.closeListener) item.options.closeListener();
		
		//remove first elmt
		this.queue.shift();
		
		/* 
		//complete handler
		if(this.queue.length == 0 && item.options.completeListener) item.options.completeListener();
		*/
		
		//if other item in the queue
		if(this.queue.length > 0){
			
			let item:QueueItem = this.queue[0];
			this.openExec(item.route, item.outlet, item.options);
			this.history.push(item);
			
		}
	}
	
	
	
	
	
	
	
	
	//____________________________________________________________
	//private
	
	private openExec(route: string, outlet: string, options:NavigationOptions):void
	{
		//id + outlet
		let tab:any[];
		if(!outlet) tab = ["/"+route];
		else tab = [{ outlets: { [outlet]: route } }];
		
		//params
		if(options.params){
			
			//url
			if(options.paramsMethod == NavigationParamMethod.URL){
				let tabparams:any[] = [];
				for(let k in options.params) tabparams.push(options.params[k]);
				tab = [...tab, ...tabparams];
			}
			//memory
			else if(options.paramsMethod == NavigationParamMethod.MEMORY){
				
				this.navService.setParams(route, options.params);
			}
		}
		
		//exec
		
		if(outlet && this.isOutletOpen(outlet)){
			
			this.closeExec(outlet)
			.then(() => {
				
				setTimeout(() => {
					this.router.navigate(tab, { skipLocationChange: options.skipLocationChange });
				}, options.delayAfterClose * 1000);
				
			});
		}
		else{
			this.router.navigate(tab, { skipLocationChange: options.skipLocationChange });
		}
		
	}
	
	
	
	
	private closeExec(outlet:string):Promise<boolean>
	{
		let tab:any[];
		if(!outlet) tab = [null];
		else tab = [{ outlets: { [outlet]: null } }];
		
		return this.router.navigate(tab, { skipLocationChange: this.navService.options.skipLocationChange });
	}
	
	
	private isOutletOpen(outlet:string):boolean
	{
		let path:string = this.location.path();
		let index:number = path.indexOf(outlet);
		return index > -1;
	}
	
	
}
