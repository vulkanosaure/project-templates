import { Component, OnInit, TemplateRef, Input, ElementRef, Output, EventEmitter } from '@angular/core';

@Component({
  selector: 'vn-pagination',
  templateUrl: './pagination.component.html',
  styleUrls: ['./pagination.component.scss']
})
export class PaginationComponent implements OnInit {
	
	@Input('next') templateNext:TemplateRef<any>;
	@Input('prev') templatePrev:TemplateRef<any>;
	@Output('prev') clickPrevEmitter:EventEmitter<void> = new EventEmitter();
	@Output('next') clickNextEmitter:EventEmitter<void> = new EventEmitter();
	
	
	public index:number = 0;
	public isNext:boolean;
	
	private elmtBtnNext:any;
	private elmtBtnPrev:any;
	private length:number;
	
	private enableNext:boolean = true;
	private enablePrev:boolean = true;
	

  constructor(
		private hostRef:ElementRef,
	) { }	

  ngOnInit() {
		
	}
	
	ngAfterViewInit(){
		
		this.elmtBtnPrev = this.hostRef.nativeElement.querySelector('.btn_prev');
		this.elmtBtnNext = this.hostRef.nativeElement.querySelector('.btn_next');
		
		this.elmtBtnPrev.onclick = this.clickPrev.bind(this);
		this.elmtBtnNext.onclick = this.clickNext.bind(this);
		
		this.length = 3;
		this.handleDisable();
	}
	
	private clickPrev():void
	{
		this.index--;
		this.handleDisable();
		this.isNext = false;
		this.clickPrevEmitter.emit();
	}
	private clickNext():void
	{
		this.index++;
		this.handleDisable();
		this.isNext = true;
		this.clickPrevEmitter.emit();
	}
	
	
	
	
	private addClass(elmt:any, classname:string):void
	{
		(elmt.className) ? elmt.className += " "+classname : elmt.className = classname;
	}
	private removeClass(elmt:any, classname:string):void
	{
		elmt.className = elmt.className.replace(classname, "");
	}
	
	private handleDisable():void
	{
		let enablePrev:boolean = this.index > 0;
		let enableNext:boolean = this.index < this.length - 1;
		if(enablePrev != this.enablePrev) this.setElement(this.elmtBtnPrev, enablePrev);
		if(enableNext != this.enableNext) this.setElement(this.elmtBtnNext, enableNext);
		this.enablePrev = enablePrev;
		this.enableNext = enableNext;
	}
	
	private setElement(elmt:any, value:boolean):void
	{
		if(value) this.removeClass(elmt, 'disabled');
		else this.addClass(elmt, 'disabled');
	}

}
