import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'numberFormat'
})
export class NumberPipe implements PipeTransform {

	transform(_input: number, length:number = 2): string {
    
    if(_input == null) return "";
    var _output:string = _input.toString();
    while(_output.length < length) _output = "0" + _output;
    return _output;
  }

}
