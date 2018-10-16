import {
  Directive,
  ElementRef,
  Host,
  Input,
  Optional,
  Renderer2,
  Self,
  SimpleChanges,
  ViewContainerRef,
} from '@angular/core';

@Directive({
  selector: '[vnClickEnabled]'
})
export class ClickEnabledDirective {
	
	@Input() vnClickEnabled:boolean;

  constructor(
		@Host() @Self() @Optional() public host : ElementRef,
		public renderer: Renderer2,
	) { 
		console.log('vnClickEnabled');
		this.host;
	}
	
	
	ngOnChanges(changes: SimpleChanges): void {
		if(changes.vnClickEnabled){
			this.vnClickEnabled;
			
			let value:string = this.vnClickEnabled ? 'auto' : 'none';
			this.renderer.setStyle(this.host.nativeElement, 'pointer-events', value);
		}
		
	}
	
	

}
