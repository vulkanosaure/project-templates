import { ParamsService } from './../utils/params.service';
import { Router } from '@angular/router';
import { Injectable } from '@angular/core';
import { CallbackModal } from './modals.interface';

//idée : ModalService : filer Routes en config d'entrée
//apres, plus besoin de préciser la modal, il la détermine
//trouver un moyen pour pouvoir le forcer qd mm (pas par défaut, cas ou conflit)


@Injectable()
export class ModalsService {
	
	private instances:ModalsServiceGroup;
	private handlersOutlet:any;
	
	constructor(
		private router: Router,
		private paramsService: ParamsService,
	) {
		this.instances = {};
	}
	
	
	private getInstance(outlet:string):ModalsServiceSub
	{
		if(!outlet) outlet = 'main';
		if(!this.instances[outlet]){
			this.instances[outlet] = new ModalsServiceSub(
				this.router,
				this.paramsService,
			);
		}
		return this.instances[outlet];
	}
	
	
	public open(route:string, outlet:string = null, params:any[] = null, closeBefore:boolean = false): Promise<boolean>
	{
		let outletName:string = outlet || 'root';
		if(this.handlersOutlet && this.handlersOutlet[outletName]){
			this.handlersOutlet[outletName].forEach((handler:any) => {
				handler();
			});
		}
		
		let inst = this.getInstance(outlet);
		return inst.open(route, outlet, params, closeBefore);
	}
	
	public close(outlet:string = null): Promise<boolean>
	{
		let inst = this.getInstance(outlet);
		return inst.close(outlet);
	}
	
	
	
	public addOutletListener(outlet:string, handler:()=>void):void
	{
		let outletName:string = outlet || 'root';
		if(!this.handlersOutlet) this.handlersOutlet = {};
		if(!this.handlersOutlet[outletName]) this.handlersOutlet[outletName] = [];
		this.handlersOutlet[outletName].push(handler);
		
	}
	
	
	
}

export interface ModalsServiceGroup {
	[name: string]: ModalsServiceSub;
}






class ModalsServiceSub {

	private _onModalsComplete: any;
	private prevModal:string;	//todo remove, replace with history
	private history:string[];
	private curModal:string;
	
	

	private linkedModals: {
		id: string,
		data: any,
		callback: any,
	}[] = [];

	private modalLinkOpen: boolean = false;

	constructor(
		private router: Router,
		private paramsService: ParamsService,
	) { }
	
	
	


	public close(outlet: string = null): Promise<boolean>
	{
		this.prevModal = this.curModal;
		this.curModal = null;
		
		let tab:any[];
		if(!outlet) tab = [null];	//todo tocheck ?
		else tab = [{ outlets: { [outlet]: null } }];
		
		return this.router.navigate(tab, { skipLocationChange: true });
	}
	
	
	
	public open(_id: string, outlet: string = null, _params:any[] = null, closeBefore:boolean = false): Promise<boolean> {
		
		this.prevModal = this.curModal;
		this.curModal = _id;
		
		let tab:any[];
		if(!outlet) tab = ["/"+_id];
		else tab = [{ outlets: { [outlet]: _id } }];
		
		if(_params) tab = [...tab, ..._params];
		
		
		if(closeBefore){
			return this.close()
			.then(() => {
				return this.router.navigate(tab, { skipLocationChange: true });
			});
		}
		else{
			return this.router.navigate(tab, { skipLocationChange: true });
		}
	}
	
	
	
	
	public openPrevModal():void
	{
		if(this.prevModal) this.open(this.prevModal);
		else this.close();
		
	}
	
	
	
	
	
	//__________________________________________________________
	//linked modals
	
	
	
	public getNumberLinkedModal(): number {
		return (this.linkedModals) ? this.linkedModals.length : 0;
	}

	public onModalsComplete(callback: any): void {
		this._onModalsComplete = callback;
	}
	
	public addLinkedModal(id: string, data: any, callback: any = null, delay: number = 0, priority: number = -1): void {
		
		console.log("addLinkedModal(" + id + ")");
		
		if(data == null) data = {};

		var obj: any = {
			id: id, data: data, callback: callback
		};
		// debugger;

		if (priority == -1) this.linkedModals.push(obj);
		else this.linkedModals.splice(priority, 0, obj);

		if (priority == 0) this.modalLinkOpen = false;

		this.openNewLinkedModal(delay);
		
	}
	
	
	private openNewLinkedModal(delay: number): void {

		if (!this.modalLinkOpen && this.linkedModals.length > 0) {

			var obj = this.linkedModals[0];
			console.log("open modal " + obj.id);

			//ptet ajouter callbackCloseLinkedModal ici dans data... => 
			//obj.callback sera lancé depuis callbackCloseLinkedModal
			
			obj.data.callback = this.callbackCloseLinkedModal.bind(this);
			this.paramsService.setData(obj.id, obj.data);

			var _this = this;
			setTimeout(function () {
				_this.open(obj.id);
			}, delay);


			this.modalLinkOpen = true;

		}
	}
	
	
	private callbackCloseLinkedModal(data: any = null): void {
		
		console.log("callbackCloseLinkedModal");

		var obj = this.linkedModals[0];
		// debugger;
		if (obj.callback != null) obj.callback(data);

		this.linkedModals.shift();
		this.modalLinkOpen = false;

		console.log("linkedModals.length : " + this.linkedModals.length);
		
		if (this.linkedModals.length == 0) {
			console.log("this._onModalsComplete : " + this._onModalsComplete);
			if (this._onModalsComplete) this._onModalsComplete();
		}
		
		setTimeout(this.close.bind(this), 10);
		setTimeout(this.openNewLinkedModal.bind(this), 700);
		
	}
	
	
}
