import { Injectable, Renderer2, RendererFactory2 } from '@angular/core';

@Injectable()
export class BroadcasterService {

	private listeners:any[];
	private renderer: Renderer2;
	
	constructor(
		rendererFactory: RendererFactory2
	) { 
		this.renderer = rendererFactory.createRenderer(null, null);
		
	}
	
	
	
	
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
	
	
	public removeListener(type:string, handler:any = null):void
	{
		if(this.listeners == null) this.listeners = [];
		
		for (var i in this.listeners) {
			var obj = this.listeners[i];
			if(obj.type == type && (!handler || handler === obj.handler)){
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
	
	
	
	
	//______________________________________________________
	
	public addSelectorEvent(classname:string, evt:string, handler:any):void
	{
		this.renderer.listen('document', evt, (event) => {
			let classes:string[] = event.target.className.split(' ');
			if(classes.indexOf(classname) > -1){
				handler(event);
			}
		});
	}
	
	
}
