import { Injectable } from '@angular/core';

@Injectable()
export class LocalStorageService {

	constructor() { }
	
	
	
	public getBoolean(key:string):boolean
	{
		if(localStorage.getItem(key) === null) return true;
		return (localStorage.getItem(key) == '1');
	}
	
	public setBoolean(key:string, value:boolean):void
	{
		localStorage.setItem(key, value ? '1' : '0');
	}
	
	
	
}
