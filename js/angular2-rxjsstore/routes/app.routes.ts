import { PageStatsComponent } from '../containers/page-stats/page-stats.component';
import { PageInsertComponent } from '../containers/page-insert/page-insert.component';
import { PageQuizComponent } from '../containers/page-quiz/page-quiz.component';
import {RouterModule, Routes} from '@angular/router';
 

export const routes:Routes = [
    { path: '', redirectTo: 'index', pathMatch: 'full' },
		
    { path: 'index', component: PageQuizComponent},
		{ path: 'quiz', component: PageQuizComponent},
		{ path: 'insert', component: PageInsertComponent},
		{ path: 'stats', component: PageStatsComponent},
		

];

export const routing = RouterModule.forRoot(routes, {
		useHash: true,
		// initialNavigation: false,
    /*enableTracing: true,*/
});


