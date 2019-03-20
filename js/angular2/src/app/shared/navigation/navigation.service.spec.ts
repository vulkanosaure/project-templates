import { TestBed, inject, fakeAsync, tick } from '@angular/core/testing';

import { NavigationService, NavigationParamMethod } from './navigation.service';
import { RouterModule, Routes, Router } from '@angular/router';
import { RouterTestingModule } from '@angular/router/testing';
import { Component } from '@angular/core';
import { ParamsService } from '../utils/params.service';
import {Location} from "@angular/common";


@Component({
  template: `Search`
})
export class SearchComponent {}

@Component({
  template: `Search2`
})
export class Search2Component {}

@Component({
  template: `Search3`
})
export class Search3Component {}

@Component({
  template: `Home`
})
export class HomeComponent {}

@Component({
  template: `<router-outlet></router-outlet>`
})
export class AppComponent {}


export const routes:Routes = [
	{ path: '', redirectTo: 'home', pathMatch: 'full' },
	{ path: 'home/:var', component: HomeComponent},
	{ path: 'search', component: SearchComponent },
	{ path: 'search2', component: SearchComponent },
	{ path: 'search3', component: SearchComponent },
	
	{ path: 'search', outlet: 'myoutlet', component: SearchComponent },
	{ path: 'search2', outlet: 'myoutlet', component: SearchComponent },
	{ path: 'search3', outlet: 'myoutlet', component: SearchComponent },
	
];


fdescribe('NavigationService', () => {
	
	let location:Location;
	let service:NavigationService;
	let path:string;
	
  beforeEach(() => {
		
    TestBed.configureTestingModule({
			declarations: [AppComponent, HomeComponent, SearchComponent, Search2Component, Search3Component],
			providers: [
				NavigationService,
				ParamsService,
			],
			imports: [
				RouterTestingModule.withRoutes(routes),
				
			]
		});
		
		location = TestBed.get(Location);
		service = TestBed.get(NavigationService);
		service.options.skipLocationChange = false;
		service.options.delayAfterClose = 0;
		
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
	});
	
	
	it('open should change location', fakeAsync(() => {
		
		service.options.skipLocationChange = false;
		
		service.open('search', null, {position: 'before'});
		tick();
		path = location.path();
		expect(path).toBe('/search');
		
		
		service.open('home', null, {
			paramsMethod: NavigationParamMethod.URL,
			params: { test:'ok'},
			position:'before',
		});
		tick();
		path = location.path();
		expect(path).toBe('/home/ok');
		
	}));
	
	
	it('should transmit memory params', fakeAsync(() => {
		
		service.options.skipLocationChange = false;
		service.open('search', null, {
			paramsMethod: NavigationParamMethod.MEMORY,
			params: { test2:'ok2'},
			position:'before',
		});
		tick();
		
		path = location.path();
		expect(path).toBe('/search');
		expect(service.getParams('search')).toEqual({ test2:'ok2'});
		
	}));
	
	
	
	it('should add link modal at end', fakeAsync(() => {
		
		service.options.skipLocationChange = false;
		service.open('search', 'myoutlet', { position: 'after' });
		service.open('search2', 'myoutlet', { position: 'after' });
		
		tick();
		
		expect(location.path()).toBe('/(myoutlet:search)');
		service.close('myoutlet');
		tick();
		// expect(location.path()).toBe('/(');
		expect(location.path()).toBe('/(myoutlet:search2)');
		service.close('myoutlet');
		tick();
		expect(location.path()).toBe('/');
		
		
	}));
	
	
	it('should add link modal at start', fakeAsync(() => {
		
		service.options.skipLocationChange = false;
		service.open('search', 'myoutlet', { position: 'after' });
		service.open('search2', 'myoutlet', { position: 'before' });
		
		tick();
		
		expect(location.path()).toBe('/(myoutlet:search2)');
		service.close('myoutlet');
		tick();
		// expect(location.path()).toBe('/(');
		expect(location.path()).toBe('/(myoutlet:search)');
		service.close('myoutlet');
		tick();
		expect(location.path()).toBe('/');
		
		
	}));
	
	
	
	it('should call close handler', fakeAsync(() => {
		
		
		let called:boolean = false;
		let indexComplete:number = 0;
		
		service.open('search2', 'myoutlet', { position: 'before', closeListener: () => {
			called = true;
		}});
		
		tick(500);
		
		service.open('search3', 'myoutlet', { position: 'after'});
		
		tick();
		
		expect(called).toBe(false);
		service.close('myoutlet');
		tick();
		
		expect(called).toBe(true);
		service.close('myoutlet');
		tick();
		
		
		
	}));
	
	
	
	
	
	it('should removeItem', fakeAsync(() => {
		
		service.options.skipLocationChange = false;
		
		service.open('search2', 'myoutlet', {position: 'before'});
		service.open('search3', 'myoutlet', {position: 'before'});
		
		tick();
		service.removeItem('search3', 'myoutlet');
		
	}));
	
	
	
	
});
