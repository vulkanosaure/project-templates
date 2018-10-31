import { routes } from './app.routes';
import { RouterModule } from '@angular/router';
import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppComponent } from './app.component';
import { SharedModule } from './shared/shared.module';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { HttpClient, HttpClientModule } from '@angular/common/http';
import { HttpModule } from '@angular/http';
import { FormsModule } from '@angular/forms';
import { PageGameComponent } from './pages/page-game/page-game.component';

@NgModule({
  declarations: [
    AppComponent,
    PageGameComponent,
  ],
  imports: [
		BrowserModule,
		SharedModule.forRoot(),
		RouterModule.forRoot(routes, {
			useHash: true,
			// initialNavigation: false,
			// enableTracing: true,
		}),
		BrowserAnimationsModule,
		HttpClientModule,
		FormsModule,
		HttpModule,
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
