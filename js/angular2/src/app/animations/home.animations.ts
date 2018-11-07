import { query, transition, trigger, group, useAnimation, animate, animation, animateChild, style, stagger, sequence } from '@angular/animations';
import { DslService, DslAnimType, DslAnimArgs, DSL_EASING } from '../shared/animation/dsl.service';
import { dsl } from './app.animations';


/*
decorator :
animations: [xAnimations],
declarations :
@HostBinding('@animations') private animations;
*/

dsl.reset();
export const homeAnimation = [
	
  trigger('animations', [
		
    transition(':enter', group([
			
			query('.dsl_zoom', dsl.combine([dsl.zoomIn, dsl.fadeIn], 1.0, {})),
			query('.dsl_zoomx', dsl.zoomIn(0.3, {zoomX:true})),
			query('.dsl_up1', dsl.slideIn(0.3, {distanceIn:50, timeIn: 0.4})),
			query('.dsl_up2', dsl.slideIn(0.2, {distanceIn:50})),
			
		])),
		
		transition(':leave', group([
			
			query('.dsl_fade', dsl.reset().fadeOut()),
		])),
		
		
  ])
];



export const gameoverAnimation = [
	
  trigger('animations', [
		
    transition(':enter', group([
			
			query('.dsl_fadeout', dsl.reset().fadeIn(0.7)),
			
		])),
		
		transition(':leave', group([
			
			query('.dsl_fadeout', dsl.reset().fadeOut()),
		])),
		
		
  ])
];




export const endAnimation = [
	
  trigger('animations', [
		
    transition(':enter', group([
			
			query('.dsl_zoomout', dsl.zoomIn(0.3, {scaleStart: 2.0})),
			query('.dsl_fade1', dsl.fadeIn(0.2)),
			query('.dsl_fade2', dsl.fadeIn(0.0)),
			query('.dsl_zoomx', dsl.zoomIn(0.3, {zoomX:true})),
			query('.dsl_up1', dsl.slideIn(0.3, {distanceIn:50})),
			query('.dsl_up2', dsl.slideIn(0.2, {distanceIn:50})),
			
		])),
		
		transition(':leave', group([
			
			query('.dsl_fadeout', dsl.reset().fadeOut()),
		])),
		
		
  ])
];
