import { routing } from './app.routes';
import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppComponent } from './app.component';
import { TestComponent } from './test/test.component';
import { Test2Component } from './test2/test2.component';
import { HeaderComponent } from 'src/app/component/header/header.component';

@NgModule({
  declarations: [
    AppComponent,
    TestComponent,
    Test2Component,
    HeaderComponent,
  ],
  imports: [
		BrowserModule,
		routing,
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
