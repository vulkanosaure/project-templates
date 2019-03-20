import { Injectable } from '@angular/core';

@Injectable()
export class StorageService {

	constructor() { }
	
	
	
	public isset(key:string):boolean
	{
		return (localStorage.getItem(key) !== null);
	}
	
	
	public getBoolean(key:string, _default:boolean = false):boolean
	{
		if(localStorage.getItem(key) === null) return null;
		return (localStorage.getItem(key) == '1');
	}
	
	public setBoolean(key:string, value:boolean):void
	{
		localStorage.setItem(key, value ? '1' : '0');
	}
	
	
	public getObject(key:string):any
	{
		if(localStorage.getItem(key) === null) return null;
		return JSON.parse(localStorage.getItem(key));
	}
	
	public setObject(key:string, value:any):void
	{
		localStorage.setItem(key, JSON.stringify(value));
	}
	
	
	
}
