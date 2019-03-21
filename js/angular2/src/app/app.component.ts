import { DataService } from './services/data.service';
import { ApiService } from './services/api.service';
import { Routes } from '@angular/router';
import { routes } from './app.routes';
import { environment } from '../environments/environment';
import { Component } from '@angular/core';
import { RouterEventService } from './shared/navigation/router-event.service';
import { TimeoutService } from './shared/time/timeout.service';
import { ModalsService } from './shared/navigation/modals.service';

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
		private routerEvent:RouterEventService,
		private modalService:ModalsService,
		private timeout:TimeoutService,
	)
	{
		console.log('app.component const()');
		this.timeout.enabled = !this.env.skipTimeout;
		
		/* 
		let tab = location.href.match(new RegExp("uid=(.+)$"));
		this.ds.uid = tab && tab.length  >= 1 && tab[1];
		*/
		
		/* 
		this.api.getData()
		.subscribe(resp => {
			
			
		});
		*/
		
		routerEvent.setRoutes(routes);
		
		/* 
		routerEvent.setListOutlets(['modal_game', 'modal_menu', 'modal']);
		routerEvent.addListener(
					['create-account', 'credits'], 
				()=> {
					//enter
				},
				() => {
					//leave
				}
		);
		 */
		
	}
	
	ngOnInit():void
	{
		
	}
	
	
	
}
