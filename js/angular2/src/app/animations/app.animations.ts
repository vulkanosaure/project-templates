import { query, transition, trigger, group, useAnimation, animate, animation, animateChild, style, stagger, sequence } from '@angular/animations';
import { DslAnimateService } from '../shared/animation/dsl.service';
import { Easing, AnimType } from '../shared/animation/animation.interface';
import { AnimateBase } from '../shared/animation/animate.base.service';
import { environment } from 'src/environments/environment';

/*
decorator :
animations: [xAnimations],
declarations :
@HostBinding('@animations') private animations;
*/


export var dsl:DslAnimateService = new DslAnimateService();

AnimateBase.addTypeOptions(AnimType.GLOBAL, {
	easeIn: Easing.EASE_OUT,
	easeOut: Easing.EASE_OUT,
});

AnimateBase.addTypeOptions(AnimType.SLIDE, {
	dir:'top',
	distanceIn:300,
	easeIn: Easing.EASE_OUT,
	timeIn:0.4,
});

AnimateBase.addTypeOptions(AnimType.ZOOM, {
	easeIn: Easing.BACK_OUT,
	timeIn:0.4,
	scaleStart: 0.2,
	scaleEnd: 0,
});

// AnimateBase.enableTime = !environment.skipTimeout;

