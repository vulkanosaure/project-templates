import { Component, OnInit, Input, TemplateRef, ViewChildren, ElementRef, Renderer2, SimpleChanges } from '@angular/core';

@Component({
  selector: 'vn-pagination-li',
  templateUrl: './pagination-li.component.html',
  styleUrls: ['./pagination-li.component.scss']
})
export class PaginationLiComponent implements OnInit {
	
	@Input('off') templateOff:TemplateRef<any>;
	@Input('on') templateOn:TemplateRef<any>;
	@Input() index:number = 0;
	@Input() length:number;
	@Input() margin:number = 10;
	

  constructor(
		private hostRef:ElementRef,
		private renderer:Renderer2,
	) { }

  ngOnInit() {
		
		this.hostRef;
		
	}
	
	//ng container ready inside
	
	ngAfterViewInit(){
		
	}
	
	
	
	
	private arrayOne(n: number): any[] {
		let output:number[] = [];
		for(let i=0;i<n;i++) output.push(0);
		return output;
  }

}
