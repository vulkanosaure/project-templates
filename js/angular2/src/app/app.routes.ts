import { RouterModule, Routes } from '@angular/router';



export const routes:Routes = [
    { path: '', redirectTo: 'test1', pathMatch: 'full' },
		
    { path: 'test1', component: TestComponent},
    { path: 'test2', component: Test2Component},
];
