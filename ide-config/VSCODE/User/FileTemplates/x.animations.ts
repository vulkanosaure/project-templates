import { query, transition, trigger, group, useAnimation, animate, animation, animateChild, style, stagger, sequence } from '@angular/animations';
import { DslService, DslAnimType, DslAnimArgs, DSL_EASING } from '../shared/animation/dsl.service';
import { dsl } from './app.animations';



/*
decorator :
animations: [xAnimations],
declarations :
@HostBinding('@animations') private animations;

composition :
query('.dsl_x', group([
	dsl.zoomIn(0, {scaleStart: 2}),
])),
*/

export const Animation = [
	
  trigger('animations', [
		
    transition(':enter', group([
			 
			query('.dsl_fade1', dsl.reset().fadeIn(0)),
			query('.dsl_fade2', dsl.fadeIn(1.0)),
			query('.dsl_fade3', dsl.fadeIn(1.0)),
			
			// ...dsl.sequence(['.dsl_fade1', '.dsl_fade2', '.dsl_fade3'], dsl.reset().fadeIn, 0.5)
			
		])),
		
		transition(':leave', group([
			
			query('.dsl_fade3', dsl.reset().fadeOut()),
			query('.dsl_fade2', dsl.fadeOut(1.0)),
			query('.dsl_fade1', dsl.fadeOut(1.0)),
			
		])),
		
  ])
];

