import { Pipe, PipeTransform, Inject } from '@angular/core';

@Pipe({
  name: 'bbcode'
})
export class BbcodePipe implements PipeTransform {
	
	constructor(
		@Inject('BbcodeConfig') private config:BbcodeConfig[],
		
	)
	{
		
	}

  transform(value: any, args?: any): any {
		
		if(!value) return value;
		
		for(let k in this.config){
			
			let item = this.config[k];
			let regexp = new RegExp(item.target, "g");
			value = value.replace(regexp, item.replace);
		}
		return value;
  }

}


export interface BbcodeConfig{
	
	target:string,
	replace:string,
	
}