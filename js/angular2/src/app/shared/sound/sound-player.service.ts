import { Injectable, Renderer2, RendererFactory2 } from '@angular/core';

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
	
	private renderer: Renderer2;
	private listDisabled:string[] = [];
	
	
	options: SoundPlayerOptions = {
		volume:1, 
		group:"", 
		loop: false, 
		looptab: null,
		forceStart :true,
	};
	
	constructor(
		rendererFactory: RendererFactory2
	) { 
		this.renderer = rendererFactory.createRenderer(null, null);
		
		
		
	}
	
	

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
	
	

	play(filename:string, options:SoundPlayerOptions = null):void
	{
		if(!this.enabled) return;
		
		options = {...this.options, ...options, };
		if(!options.forceStart && this.isPlaying(filename)) return;
		
		
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
				group : options.group,
				loop : options.loop,
				looptab : options.looptab,
				duration : NaN,
			}

			var folder:string;
			if(options.group != "" && this.folderGroup[options.group]) folder = this.folderGroup[options.group];
			else folder = this.folder;

			item.audio.src = folder + filename;
			item.audio.load();
			this.data[filename] = item;

				
			if(options.loop){
				if(options.looptab){
					item.audio.ontimeupdate = function() {
						var time:number = item.audio.currentTime;

						if(isNaN(item.duration)) item.duration = item.audio.duration;

						if(!isNaN(item.duration)){

							var timeend:number = item.duration - options.looptab[1];
							if(time >= timeend) item.audio.currentTime = options.looptab[0];

						}

						//console.log("ontimeupdate "+time+" // "+looptab);
					};
				}
				else{
					item.audio.loop = true;
				}
			}
		}
		
		
		
		
		
		if(options.duration){
			
			var timeend:number = -1;
			item.audio.ontimeupdate = function() {
				var time:number = item.audio.currentTime;
				if(isNaN(item.duration)) item.duration = item.audio.duration;
				
				if(timeend == -1 && !isNaN(item.duration)){
					
					let str:string = options.duration.toString();
					if(str.charAt(str.length - 1) == '%'){
						let percent:number = parseInt(str.substr(0, str.length - 1));
						timeend = item.duration * percent / 100;
					}
					else timeend = <number>options.duration;
				}
				
				if(timeend != -1 && time >= timeend) item.audio.pause();
				
			};
		}
		
		
		//todo timestart
		
		

		if(options.group != "" && this.volumeGroup[options.group]) item.audio.volume = this.volumeGroup[options.group];
		else item.audio.volume = this.volume;
		
		item.audio.volume *= options.volume;

		item.audio.currentTime = 0;
		item.audio.play();
		
	}
	
	
	
	isEnabled():boolean
	{
		return this.enabled;
	}
	
	enable(replayPendingSounds:boolean = true):void
	{
		this.enabled = true;
		
		if(replayPendingSounds){
			this.listDisabled.forEach((k:string) => {
				this.data[k].audio.play();
			});
		}
		
		this.listDisabled = [];
	}
	
	
	disable():void
	{
		this.enabled = false;
		
		for(let k in this.data){
			let item = this.data[k];
			if(!item.audio.paused){
				item.audio.pause();
				this.listDisabled.push(k);
			}
		}
		
		
	}
	
	
	
	
	
	public addSelectorEvent(classname:string, evt:string, filename:string, options:SoundPlayerOptions = null):void
	{
		this.renderer.listen('document', evt, (event) => {
			let classes:string[] = event.target.className.split(' ');
			if(classes.indexOf(classname) > -1){
				this.play(filename, options);
			}
		});
	}
	
	
	
	

}


export interface SoundPlayerOptions{
	volume?:number, 
	group?:string, 
	loop?:boolean, 
	looptab?:number[],
	forceStart?:boolean,
	
	duration?:number | string,		//sec or %
	timestart?:number | string,		//sec or %
}
