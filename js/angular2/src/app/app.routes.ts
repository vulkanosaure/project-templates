import { RouterModule, Routes } from '@angular/router';
import { TestComponent } from './test/test.component';
import { Test2Component } from 'src/app/test2/test2.component';



export const routes:Routes = [
    { path: '', redirectTo: 'test1', pathMatch: 'full' },
		
    { path: 'test1', component: TestComponent},
    { path: 'test2', component: Test2Component},
];

export const routing = RouterModule.forRoot(routes, {
		useHash: false,
		// initialNavigation: false,
    /*enableTracing: true,*/
});


