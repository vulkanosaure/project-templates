import { Injectable } from '@angular/core';

@Injectable()
export class ParamsService {
	
	private data = {};

  constructor() { }

  public setData(_id:string, _data:any):void
  {
    this.data[_id] = _data;
  }

  public getData(_id:string):any
  {
    return this.data[_id];
  }
}
