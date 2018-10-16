import { FullscreenService } from './utils/fullscreen.service';
import { LocalStorageService } from './storage/local-storage.service';
import { PreloadImgService } from './sound/preload-img.service';
import { ClickEnabledDirective } from './directives/click-enabled.directive';
import { TimeoutService } from './time/timeout.service';
import { ParamsService } from './utils/params.service';
import { BroadcasterService } from './events/broadcaster.service';
import { ModalsService } from './navigation/modals.service';
import { MathService } from './math/math.service';
import { ModuleWithProviders, NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterMenuComponent } from './navigation/router-menu/router-menu.component';
import { Nl2brPipe } from './pipes/nl2br.pipe';
import { SoundPlayerService } from './sound/sound-player.service';
import { WINDOW_PROVIDERS } from './utils/window.service';

@NgModule({
  imports: [
    CommonModule
  ],
	declarations: [
		RouterMenuComponent,
		Nl2brPipe,
		ClickEnabledDirective,
	],
	exports: [
		RouterMenuComponent,
		Nl2brPipe,
		ClickEnabledDirective,
	],
})
export class SharedModule {
	
	static forRoot(): ModuleWithProviders {
		return {
			ngModule: SharedModule,
			providers: [
				 MathService,
				 ModalsService,
				 BroadcasterService,
				 ParamsService,
				 TimeoutService,
				 SoundPlayerService,
				 PreloadImgService,
				 LocalStorageService,
				 WINDOW_PROVIDERS,
				 FullscreenService,
			 ]
		};
	}
}

