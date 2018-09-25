import { query, transition, trigger, group, useAnimation, animate, animation, animateChild, style, stagger, sequence } from '@angular/animations';

/*
README : 

add in decorator :
animations: animations

add in component declarations :
@HostBinding('@animations') private animations;
*/



const slideIn = animation([
		style({ opacity: 0, marginTop:'-600px' }),
		animate('{{duration}} {{delay}} ease-out', style({ 
			opacity: 1, 
			marginTop:'*',
		}))
	], { params: { duration: '600ms', delay:'0ms'}
);


const slideOut = animation([
	animate('{{duration}} {{delay}} ease-out', style({ 
		opacity: 0, 
		marginTop:'600px',
	}))
], { params: { duration: '350ms', delay:'0ms'}
);


const fadeIn = animation([
	style({opacity:0}),
	animate('300ms {{delay}}', style('*'))
], { params: { delay: '0ms'}
);
const fadeOut = animation([
	animate('300ms {{delay}}', style({opacity:0}))
], { params: { delay: '0ms'}
);




export const animations = [
	
  trigger('animations', [
		
    transition(':enter', group([
			query('.center_container', group([
        useAnimation(slideIn, {params: {delay:'200ms'}}),
			])),
		])),
		
		transition(':leave', group([
			query('.center_container', group([
				useAnimation(slideOut),
			])),
		])),
		
  ])
];



export const modalAnimations = [
	
  trigger('animations', [
		
    transition(':enter', group([
			query('.center_container', group([
        useAnimation(slideIn, {params: {duration: '370ms', delay:'200ms'}}),
			])),
			query('.bg_modal', group([
        useAnimation(fadeIn),
			]), {optional: true}),
			
		])),
		
		transition(':leave', group([
			query('.center_container', group([
				useAnimation(slideOut, {params:{duration: '200ms'}}),
			])),
			query('.bg_modal', group([
        useAnimation(fadeOut, {params: {delay:'200ms'}}),
			]), {optional: true}),
			
		])),
		
  ])
];




