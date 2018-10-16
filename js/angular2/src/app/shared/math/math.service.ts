import { Injectable } from '@angular/core';

@Injectable()
export class MathService {

	constructor() { }
	
	
	
  public random(min: number, max: number, inc: number = 1): number {
    var retour: number = this.floor(Math.random() * (max - min + inc) + min, inc);
    return retour;
  }

  public floor(nb: number, inc: number): number {
    var retour: number = Math.floor(nb / inc) * inc;
    return retour;
	}
	
	public getProgressionValue(_input:number, _minsrc:number, _maxsrc:number, _mindst:number, _maxdst:number):number
	{
		let _percentinput:number = (_input - _minsrc) / (_maxsrc - _minsrc);
		if (_percentinput < 0) _percentinput = 0;
		if (_percentinput > 1) _percentinput = 1;
		let _output:number = _mindst + (_maxdst - _mindst) * _percentinput;
		return _output;
	}
	
	
}


export class MathServiceMock extends MathService{
  public random(min: number, max: number, inc: number = 1): number {
    return min;
  }
	
}