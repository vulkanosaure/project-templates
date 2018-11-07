import { trigger, style, state, transition, useAnimation, group, animate } from "@angular/animations";
import { DslService, DslAnimType, DSL_EASING } from '../shared/animation/dsl.service';
import { dsl } from './app.animations';




//________________________________________________________
//animation (simple)

export const fxAnimations = [
	
  trigger('fade', [
		
		state('true', style({ opacity:1})),
		state('false', style({ opacity:0})),
		
    transition('* => true', dsl.fadeIn()),
    transition('* => false', dsl.fadeOut()),
		
		transition(':enter', dsl.fadeIn()),
    transition(':leave', dsl.fadeOut()),
		
	]),
	
	
	
	
	trigger('zoom', [
		
		state('true', style({transform:'scale(1.0) rotate(0deg)'})),
		state('false', style({transform:'scale(0.73) rotate(-9deg)'})),
		
    transition('* => true', group([
			animate('0.35s ease-out', style({transform:'scale(1.0) rotate(0deg)'}))
		])),
    transition('* => false', group([
			animate('0.35s ease-out', style({transform:'scale(0.73) rotate(-9deg)'}))
		])),
	]),
	
	
];
