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
  selector: '[vnVisible]'
})
export class VisibleDirective {
	
	@Input() vnVisible:boolean;

  constructor(
		@Host() @Self() @Optional() public host : ElementRef,
		public renderer: Renderer2,
	) { }
	
	
	ngOnChanges(changes: SimpleChanges): void {
		if(changes.vnVisible){
			let value:string = this.vnVisible ? 'visible' : 'hidden';
			this.renderer.setStyle(this.host.nativeElement, 'visibility', value);
		}
		
	}

}
