import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class FullscreenService {

	elem:any;
	
	constructor() { 
		
	}
	
	
	/* View in fullscreen */
	openFullscreen() {
		
		var elem:any = document.documentElement;
		if (elem.requestFullscreen) {
			elem.requestFullscreen();
		} else if (elem.mozRequestFullScreen) { /* Firefox */
			elem.mozRequestFullScreen();
		} else if (elem.webkitRequestFullscreen) { /* Chrome, Safari and Opera */
			elem.webkitRequestFullscreen();
		} else if (elem.msRequestFullscreen) { /* IE/Edge */
			elem.msRequestFullscreen();
		}
	}

	/* Close fullscreen */
	closeFullscreen() {
		
		var doc:any = document;
		
		if (doc.exitFullscreen) {
			doc.exitFullscreen();
		} else if (doc.mozCancelFullScreen) { /* Firefox */
			doc.mozCancelFullScreen();
		} else if (doc.webkitExitFullscreen) { /* Chrome, Safari and Opera */
			doc.webkitExitFullscreen();
		} else if (doc.msExitFullscreen) { /* IE/Edge */
			doc.msExitFullscreen();
		}
	}
}
