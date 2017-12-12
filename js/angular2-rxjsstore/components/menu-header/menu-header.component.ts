import { Component, EventEmitter, Input, OnInit } from '@angular/core';
import { Store } from '@ngrx/store';
import * as actions from './../../actions/default.actions';

@Component({
  selector: 'app-menu-header',
  templateUrl: './menu-header.component.html',
  styleUrls: ['./menu-header.component.css']
})
export class MenuHeaderComponent implements OnInit {

	@Input() onNavigate:(route:string)=>{};
	
  constructor(private store:Store<any>) { }

  ngOnInit() {
	}
	
	onclick(route:string){
		
		//this.store.dispatch(actions.navigate(route));
		this.onNavigate(route);
		
	}

}
