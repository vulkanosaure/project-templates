import { query, transition, trigger, group, useAnimation, animate, animation, animateChild, style, stagger, sequence } from '@angular/animations';
import { DslService, DslAnimType, DSL_EASING } from '../shared/animation/dsl.service';

/*
decorator :
animations: [xAnimations],
declarations :
@HostBinding('@animations') private animations;
*/


export var dsl:DslService = new DslService();

dsl.setParams(DslAnimType.GLOBAL, {
	easeIn: DSL_EASING.BACK_OUT,
});

dsl.setParams(DslAnimType.SLIDE, {
	dir:'top',
	distanceIn:300,
	easeIn: DSL_EASING.BACK_OUT,
	timeIn:0.4,
});

dsl.setParams(DslAnimType.ZOOM, {
	easeIn: DSL_EASING.BACK_OUT,
	timeIn:0.4,
	scaleStart: 0.2,
	scaleEnd: 0,
});



