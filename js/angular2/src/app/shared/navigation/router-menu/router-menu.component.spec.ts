import { async, ComponentFixture, TestBed, fakeAsync, tick } from '@angular/core/testing';

import { RouterMenuComponent } from './router-menu.component';
import { Router, RouterModule, Routes } from '@angular/router';
import { Component, ElementRef, DebugElement } from '@angular/core';
import {RouterTestingModule} from '@angular/router/testing';
import { By } from '@angular/platform-browser';
import {Location} from "@angular/common";


@Component({
  template: `Search`
})
export class SearchComponent {
}

@Component({
  template: `Home`
})
export class HomeComponent {
}

@Component({
  template: `<router-outlet></router-outlet>`
})
export class AppComponent {
}

export const routes:Routes = [
	{ path: '', redirectTo: 'home', pathMatch: 'full' },
	{ path: 'home', component: HomeComponent},
	{ path: 'search', component: SearchComponent },
	
];




describe('RouterMenuComponent', () => {
  let component: RouterMenuComponent;
	let fixture: ComponentFixture<RouterMenuComponent>;
	let router:Router;
	let location:Location;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
			declarations: [ RouterMenuComponent, AppComponent, HomeComponent, SearchComponent ],
			imports: [RouterTestingModule.withRoutes(routes)],
		});
		
		
    fixture = TestBed.createComponent(RouterMenuComponent);
		component = fixture.componentInstance;
		component.routes = routes;
		
		router = TestBed.get(Router);
		location = TestBed.get(Location);
		console.log('router : '+router);
		
		
    fixture.detectChanges();
	}));
	
	

  it('should create', fakeAsync(() => {
		
		let link:DebugElement = fixture.debugElement.query(By.css('nav>div:nth-child(5n) > a'));
		link.triggerEventHandler('click', null);
		// router.navigate(['/search']);
		tick();
		
		console.log('inner html : '+link.nativeElement.innerHTML);
		debugger;
		let path:string = location.path();
		
		expect(path).toBe('/search');
		
		
		expect(component).toBeTruthy();
		
  }));
});
