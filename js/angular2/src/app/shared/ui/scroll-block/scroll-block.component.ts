import { Component, OnInit, ViewChild, ElementRef, Renderer2, Input } from '@angular/core';
import { InfoScrollService } from '../info-scroll.service';
import { PlatformService } from '../../utils/platform.service';
import { TweenAnimateService } from '../../animation/tween.animate.service';

@Component({
  selector: 'vn-scroll-block',
  templateUrl: './scroll-block.component.html',
  styleUrls: ['./scroll-block.component.scss']
})
export class ScrollBlockComponent implements OnInit {
	
	
	@Input() grdTop:number;								//0.1
	@Input() grdBottom:number;						//0.9
	@Input() timeScroll:number = 0.45;		//seconds
	
	
	private infoScroll:InfoScrollService;
	private style:any;
	private stylesGradients:any;
	
	

  constructor(
		
		private platform:PlatformService,
		private animate:TweenAnimateService,
		private hostRef:ElementRef,
		private renderer:Renderer2,	
		
	) { }

  ngOnInit() {
		
		this.infoScroll = new InfoScrollService();
		
		this.infoScroll.updateHandler = this.updateHandler.bind(this);
		
		this.infoScroll.init(this.hostRef.nativeElement);
		
		setTimeout(() => {
			this.infoScroll.update();		
		}, 1);
		
		
		
		//todo : remove this dependency if possible
		if(this.platform.isFirefox()){
			this.renderer.setStyle(
				this.hostRef.nativeElement,
				'overflow-y',
				'hidden'
			);
		}
		
		this.stylesGradients = {
			top: '-webkit-gradient(linear, 0% 0%, 0% 100%, from(rgba(0, 0, 0, 0)), color-stop('+this.grdTop+', rgb(0, 0, 0)), color-stop(1.0, rgb(0, 0, 0)), to(rgba(0, 0, 0, 0)))', 
			bottom: '-webkit-gradient(linear, 0% 0%, 0% 100%, from(rgb(0, 0, 0)), color-stop('+this.grdBottom+', rgb(0, 0, 0)), to(rgba(0, 0, 0, 0)))',
			both: '-webkit-gradient(linear, 0% 0%, 0% 100%, from(rgba(0, 0, 0, 0)), color-stop('+this.grdTop+', rgb(0, 0, 0)), color-stop('+this.grdBottom+', rgb(0, 0, 0)), to(rgba(0, 0, 0, 0)))',
		};
		
	}
	
	
	
	private updateHandler():void
	{
		if(this.grdTop || this.grdBottom){
			let value:string = '';
			
			if(this.grdTop && this.grdBottom){
				if(this.infoScroll.up && this.infoScroll.down) value = this.stylesGradients['both'];
				else if(this.infoScroll.up) value = this.stylesGradients['top'];
				else if(this.infoScroll.down) value = this.stylesGradients['bottom'];
			}
			else if(this.grdTop){
				if(this.infoScroll.up) value = this.stylesGradients['top'];
			}
			else if(this.grdBottom){
				if(this.infoScroll.down) value = this.stylesGradients['bottom'];
			}
			
			this.renderer.setStyle(
				this.hostRef.nativeElement, '-webkit-mask-image', value
			);
		}
	}
	
	
	public hasScrollUp():boolean
	{
		if(!this.infoScroll) return;
		return this.infoScroll.hasScrollUp();
	}
	public hasScrollDown():boolean
	{
		if(!this.infoScroll) return;
		return this.infoScroll.hasScrollDown();
	}
	
	
	public scroll(delta:number, distance:number):void
	{
		let elmt = this.hostRef.nativeElement;
		this.animate.reset().tweenValue(
			elmt,
			0,
			{
				time: this.timeScroll,
				prop: 'scrollTop',
				endValue: elmt.scrollTop + delta * distance,
				round:false,
				
			}
		)
	}
	
	
	public setScrollTop(value:number):void
	{
		this.hostRef.nativeElement.scrollTop = value;
		this.infoScroll.update();
	}

}
