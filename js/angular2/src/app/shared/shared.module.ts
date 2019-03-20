import { TraceService } from './debug/trace.service';
import { FullscreenService } from './utils/fullscreen.service';
import { StorageService } from './storage/storage.service';
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
import { ScaledDirective } from './directives/scaled.directive';
import { RouterEventService } from './navigation/router-event.service';
import { UrlParserService } from './navigation/url-parser.service';
import { TweenAnimateService } from './animation/tween.animate.service';
import { DslAnimateService } from './animation/dsl.service';
import { InfoScrollService } from './ui/info-scroll.service';
import { BbcodePipe, BbcodeConfig } from './pipes/bbcode.pipe';
import { GoogleAnalyticsService } from './api/google-analytics.service';
import { PlatformService } from './utils/platform.service';
import { NavigationService } from './navigation/navigation.service';
import { ScrollBlockComponent } from './ui/scroll-block/scroll-block.component';
import { PaginationLiComponent } from './ui/pagination-li/pagination-li.component';
import { PaginationComponent } from './ui/pagination/pagination.component';
import { TransitionerComponent } from './ui/transitioner/transitioner.component';
import { NumberPipe } from './pipes/number.pipe';
import { TurnBasedService } from './pattern/turn-based.service';
import { DragndropService } from './ui/dragndrop.service';

@NgModule({
  imports: [
		CommonModule,
  ],
	declarations: [
		RouterMenuComponent,
		Nl2brPipe,
		ClickEnabledDirective,
		ScaledDirective,
		BbcodePipe,
		NumberPipe,
		ScrollBlockComponent,
		PaginationLiComponent,
		PaginationComponent,
		TransitionerComponent,
	],
	exports: [
		RouterMenuComponent,
		Nl2brPipe,
		ClickEnabledDirective,
		ScaledDirective,
		BbcodePipe,
		NumberPipe,
		ScrollBlockComponent,
		PaginationLiComponent,
		PaginationComponent,
		TransitionerComponent,
	],
})
export class SharedModule {
	
	static forRoot(
		_bbcodeConfigs:BbcodeConfig[] = null,
		
	): ModuleWithProviders {
		
		return {
			ngModule: SharedModule,
			providers: [
				 MathService,
				 ModalsService,
				 NavigationService,
				 BroadcasterService,
				 ParamsService,
				 TimeoutService,
				 SoundPlayerService,
				 PreloadImgService,
				 StorageService,
				 WINDOW_PROVIDERS,
				 FullscreenService,
				 TraceService,
				 RouterEventService,
				 UrlParserService,
				 TweenAnimateService,
				 DslAnimateService,
				 InfoScrollService,
				 { provide:'BbcodeConfig', useValue: _bbcodeConfigs },
				 GoogleAnalyticsService,
				 PlatformService,
				 TurnBasedService,
				 DragndropService,
				
			 ]
		};
	}
}

