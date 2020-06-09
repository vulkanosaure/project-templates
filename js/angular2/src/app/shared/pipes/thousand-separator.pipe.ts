import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'thousandSeparator'
})
export class ThousandSeparatorPipe implements PipeTransform {

	transform(_input: number, _separator:string = "."): string {

    if(_input == null) return "";
    var _output:string = _input.toString();
    let len = _output.length;
    let count = 0;
    let output2:string = "";
    for(let i=len - 1;i>=0;i--){
      if(count == 3){
        output2 = _separator + output2;
        count = 0;
      }
      output2 = _output[i] + output2;
      count++;
    }

    return output2;
  }

}
