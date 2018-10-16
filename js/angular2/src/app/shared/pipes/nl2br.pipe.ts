import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'nl2br'
})
export class Nl2brPipe implements PipeTransform {

  transform(_input: string): string {
		
		if(_input == null) return _input;
		_input = _input.replace(/\n/g, "<br />");
    return _input;
  }

}
