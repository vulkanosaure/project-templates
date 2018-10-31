import { DataService } from './services/data.service';
import { ApiService } from './services/api.service';
import { Routes } from '@angular/router';
import { routes } from './app.routes';
import { environment } from '../environments/environment';
import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent {
	
	routes:Routes = routes;
	env = environment;
	loaded:boolean;
	
	
	constructor(
		private api:ApiService,
		private ds:DataService,
	)
	{
		/* 
		let tab = location.href.match(new RegExp("uid=(.+)$"));
		this.ds.uid = tab && tab.length  >= 1 && tab[1];
		*/
		
		/* 
		this.api.getData()
		.subscribe(resp => {
			
			
		});
		*/
		
		
	}
	
	ngOnInit():void
	{
		
	}
	
	
	
}
