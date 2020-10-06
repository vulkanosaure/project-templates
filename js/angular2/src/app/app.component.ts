import { DataService } from './services/data.service';
import { ApiService } from './services/api.service';
import { Routes } from '@angular/router';
import { routes } from './app.routes';
import { environment } from '../environments/environment';
import { RouterEventService } from './shared/navigation/router-event.service';
import { TimeoutService } from './shared/time/timeout.service';
import { ModalsService } from './shared/navigation/modals.service';
import { StorageService } from './shared/storage/storage.service';
import { Component, Renderer2, ViewChild, ElementRef } from '@angular/core';
import { ScaledDirective } from './shared/directives/scaled.directive';
import { DragndropService } from './shared/ui/dragndrop.service';


@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent {

	routes:Routes = routes;
	env = environment;
  loaded:boolean;



  @ViewChild('container') containerRef:ElementRef;
  @ViewChild(ScaledDirective) scaled:ScaledDirective;


  handlerResize()
  {
    this.dragndrop.scalingRatio = this.scaled.scale;
  }

  ngAfterViewInit():void
	{
    this.handlerResize();
    this.scaled.handlerResize = this.handlerResize.bind(this);
	}


	constructor(
		private api:ApiService,
		private ds:DataService,
		private routerEvent:RouterEventService,
		private modalService:ModalsService,
		private timeout:TimeoutService,
    private storage:StorageService,
    private dragndrop:DragndropService,
	)
	{
		console.log('app.component const()');

		this.storage.init(1);

		this.timeout.enabled = !this.env.skipTimeout;
		this.loaded = true;


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
