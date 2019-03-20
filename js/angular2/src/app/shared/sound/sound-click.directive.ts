import { Directive, HostListener, Input } from '@angular/core';
import { SoundPlayerService } from './sound-player.service';

@Directive({
  selector: '[soundClick]'
})
export class SoundClickDirective {
	
	
	@Input('soundClick') filename:string;
	
	
	@HostListener('mousedown') onmousedown():void{
		
		this.soundPlayer.play(this.filename);
		
	};

  constructor(private soundPlayer:SoundPlayerService) { }

}
