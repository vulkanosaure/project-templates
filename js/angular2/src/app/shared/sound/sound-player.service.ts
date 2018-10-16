import { Injectable } from '@angular/core';

interface SoundPlayerItem{
	audio:any;
	loop:boolean;
	looptab?:number[];
	group?:string;
	duration?:number;

}



@Injectable()
export class SoundPlayerService {

	private data:any = {};
	
	private volume:number = 1;
	private saveVolume:number = 1;
	private volumeGroup:any = {};

	private folder:string = '';
	private folderGroup:any = {};
	
	private isLower:Boolean = false;
	private enabled:boolean = true;
	
	constructor() { }
	
	

	setFolder(folder:string, group:string = ""):void
	{
		if(group != "") this.folderGroup[group] = folder;
		else this.folder = folder;
	}
	
	
	setVolumeLower(value:Boolean):void
	{
		console.log('Spservice.setlower('+value+')');
		
		var group:string = "music";
		var volume:number = this.getVolume(group);
		
		if(value){
			if(!this.isLower) this.saveVolume = volume;
			this.setVolume(this.saveVolume * 0.01, group);
		}
		else{
			this.setVolume(this.saveVolume, group);
		}
		
		this.isLower = value;
	}
	
	
	
	setVolume(value:number, group:string = ""):void
	{
		
		console.log("setVolume("+value+", "+group+")");
		if(group != "") this.volumeGroup[group] = value;
		else this.volume = value;

		for (var i in this.data) {
			var item = this.data[i];
			if(item.group == group && item.loop && item.audio){
				console.log("set volume "+value);
				item.audio.volume = value;
			}
		}
	}
	
	isPlaying(filename:string):boolean
	{
		if(this.data[filename]){
			let item = this.data[filename];
			return !item.audio.paused;
		}
		else return false;
	}
	
	getVolume(group:string = ""):number
	{
		if(group == "") return this.volume;
		else return this.volumeGroup[group];
	}
	

	pause(filename:string):void
	{
		if(this.data[filename]){
			var item:SoundPlayerItem = this.data[filename];
			if(!item.audio.paused) item.audio.pause();
		}
	}
	
	

	play(filename:string, volume:number = 1, group:string = "", loop:boolean = false, looptab:number[] = null):void
	{
		if(!this.enabled) return;
		
		//console.log("play("+filename+")");
		var audio:any;
		var item:SoundPlayerItem;

		if(this.data[filename]){
			// console.log("re-use");
			item = this.data[filename];

			if(!item.audio.paused) item.audio.pause();
			item.audio.currentTime = 0;
		}
		else{
			//console.log("create");
			item = {
				audio : new Audio(),
				group : group,
				loop : loop,
				looptab : looptab,
				duration : NaN,
			}

			var folder:string;
			if(group != "" && this.folderGroup[group]) folder = this.folderGroup[group];
			else folder = this.folder;

			item.audio.src = folder + filename;
			item.audio.load();
			this.data[filename] = item;

				
			if(loop){
				if(looptab){
					item.audio.ontimeupdate = function() {
						var time:number = item.audio.currentTime;

						if(isNaN(item.duration)) item.duration = item.audio.duration;

						if(!isNaN(item.duration)){

							var timeend:number = item.duration - looptab[1];
							if(time >= timeend) item.audio.currentTime = looptab[0];

						}

						//console.log("ontimeupdate "+time+" // "+looptab);
					};
				}
				else{
					item.audio.loop = true;
				}
			}
		}

		if(group != "" && this.volumeGroup[group]) item.audio.volume = this.volumeGroup[group];
		else item.audio.volume = this.volume;
		
		item.audio.volume *= volume;

		//item.audio.currentTime = 118;	//tests
		item.audio.play();

	}
	
	
	
	
	
	enable():void
	{
		this.enabled = true;
		
		for(let k in this.data){;
			let item = this.data[k];
			if(item.audio.paused) item.audio.play();
		}
	}
	
	
	disable():void
	{
		this.enabled = false;
		
		for(let k in this.data){;
			let item = this.data[k];
			if(!item.audio.paused) item.audio.pause();
		}
		
		
	}
	
	
	
	
	

}
