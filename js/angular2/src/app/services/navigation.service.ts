import { UserDataService } from 'src/app/services/user-data.service';
import { ModalsService } from 'src/app/shared/navigation/modals.service';
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class NavigationService {

	constructor(
		private modalService:ModalsService,
		private userData:UserDataService,
	) { }
	
	
	restart():void
	{
		//todo : if intro / outro, different...
		//mais pas sur qu'on laisse le btn menu accessible
		this.modalService.open('chapter-start');
		
		
	}
	
	
	startGame():void
	{
		let indexScenario:number = this.userData.data.indexScenario;
		
		if(indexScenario == 0){
			this.modalService.open('game');
		}
		else{
			this.modalService.open('chapter-start');
		}
	}
	
	
	
	endGame():void
	{
		let indexScenario:number = this.userData.data.indexScenario;
		
		//never equal 0 here, incremented before
		if(indexScenario == 1){
			this.modalService.open('chapter-start');
		}
		else if(indexScenario == 4){
			this.modalService.open('quizz');
		}
		else{
			this.modalService.open('chapter-end');
		}
		
	}
	
	
	
	afterChapterEnd():void
	{
		let indexScenario:number = this.userData.data.indexScenario;
		if(indexScenario == 4){
			this.modalService.open('game');
		}
		else{
			this.modalService.open('chapter-start');
		}
		
		
	}
	
	
}
