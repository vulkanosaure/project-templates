import { trigger, style, state, transition, useAnimation, group, animate } from "@angular/animations";
import { dsl } from './app.animations';
import { Easing } from "../shared/animation/animation.interface";


dsl.reset();

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
		
		state('true', style({ opacity:1})),
		state('false', style({ opacity:0})),
		
    transition('* => true', dsl.zoomIn(0.0, {scaleStart: 0.9, timeIn:0.3})),
    transition('* => false', dsl.zoomOut(0.0, {scaleEnd: 0.8, timeOut:0.17, easeOut:Easing.EASE_OUT})),
		
		transition(':enter', dsl.zoomIn(0.0, {scaleStart: 0.9, timeIn:0.3})),
    transition(':leave', dsl.zoomOut(0.0, {scaleEnd: 0.8, timeOut:0.17, easeOut:Easing.EASE_OUT})),
		
	]),
	
	
	
	
];
