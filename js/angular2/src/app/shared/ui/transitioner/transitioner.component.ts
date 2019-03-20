import { Component, OnInit, Input, TemplateRef, SimpleChanges } from '@angular/core';
import { TweenAnimateService } from '../../animation/tween.animate.service';
import { Easing } from '../../animation/animation.interface';

@Component({
  selector: 'vn-transitioner',
  templateUrl: './transitioner.component.html',
  styleUrls: ['./transitioner.component.scss']
})
export class TransitionerComponent implements OnInit {
	
	
	@Input('items') items:TemplateRef<any>[];
	@Input() index:number;
	@Input() isNext:boolean;
	
	private itemIn:TemplateRef<any>;
	private itemOut:TemplateRef<any>;

  constructor(
		private animate:TweenAnimateService,
	) { }

  ngOnInit() {
		
		this.itemIn = this.items[0];
		
	}
	
	
	ngOnChanges(changes:SimpleChanges){
		
		if(changes.index){
			
			this.itemOut = this.itemIn;
			this.itemIn = this.items[this.index];
			
			this.animate.reset();
			
			let dir:string = this.isNext ? 'left' : 'right';
			/* 
			this.animate.slideOut('.out_anim', 0, {
				timeOut: 0.4,
				distanceOut: 600,
				useMargin:false,
				dir: dir,
				easeOut: Easing.EASE_OUT,
				// fade:true,
			});
			 */
			this.animate.reset().slideIn('.in_anim', 0.0, {
				timeIn: 0.4,
				distanceIn: 600,
				useMargin:false,
				dir: dir,
				easeIn: Easing.EASE_OUT,
				// fade:true,
			});
			
		}
	}

}
