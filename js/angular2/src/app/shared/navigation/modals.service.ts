import { ParamsService } from './../utils/params.service';
import { Router } from '@angular/router';
import { Injectable } from '@angular/core';
import { CallbackModal } from './modals.interface';

@Injectable()
export class ModalsService {

	
	private _onModalsComplete: any;
	private prevModal:string;
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
	
	
	


	public closeModal(outlet: string = ""): Promise<boolean> {
		
		if (outlet == "") outlet = "modal";
		this.prevModal = this.curModal;
		this.curModal = null;
		return this.router.navigate([{ outlets: { [outlet]: null } }], { skipLocationChange: true });
	}

	public openModal(_id: string, outlet: string = "", closeBefore:boolean = false): Promise<boolean> {
		if (outlet == "") outlet = "modal";
		
		this.prevModal = this.curModal;
		this.curModal = _id;
		
		if(closeBefore){
			return this.closeModal()
			.then(() => {
				return this.router.navigate([{ outlets: { [outlet]: _id } }], { skipLocationChange: true });
			});
		}
		else{
			return this.router.navigate([{ outlets: { [outlet]: _id } }], { skipLocationChange: true });
		}
	}
	
	public openPrevModal():void
	{
		if(this.prevModal) this.openModal(this.prevModal);
		else this.closeModal();
		
	}
	
	
	
	public gotoPage(_id: string, _params:any[] = null): Promise<boolean> {
		
		let tab:any[] = ["/"+_id];
		if(_params) tab = [...tab, ..._params];
		
		return this.router.navigate(tab, { skipLocationChange: true });
		
	}
	
	


	public getLength(): number {
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
				_this.openModal(obj.id);
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
		
		setTimeout(this.closeModal.bind(this), 10);
		setTimeout(this.openNewLinkedModal.bind(this), 700);
		
	}
	
	
}
