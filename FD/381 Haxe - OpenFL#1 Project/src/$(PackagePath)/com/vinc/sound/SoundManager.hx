package com.vinc.sound;
import haxe.io.Error;
#if html5
import js.Lib;
#end
import openfl.events.Event;
import openfl.media.Sound;
import openfl.media.SoundChannel;
import openfl.media.SoundTransform;
import openfl.net.URLRequest;

/**
 * ...
 * @author Vincent Huss
 */
class SoundManager 
{
	static var data:Dynamic = {};
	public static var SOUND_ENABLED:Bool = true;

	public function new() 
	{
		throw "is static";
	}
	
	
	public static function addSound(_id:String, _url:String, _preload:Bool):Void
	{
		var _sound:Sound = null;
		if (_preload){
			_sound = new Sound(new URLRequest(_url));
		}
		
		Reflect.setField(data, _id, {url:_url, sound:_sound});
		
	}
	
	public static function play(_id:String, _loop:Bool = false, _reportErrors:Bool = true, _vol:Float = 1):Void
	{
		if (!SOUND_ENABLED) return;
		
		var obj = Reflect.getProperty(data, _id);
		
		if (obj == null){
			if (_reportErrors) throw "sound #" + _id + " doesn't exist";
			else return;
		}
		
		if (obj.sound == null){
			obj.sound = new Sound(new URLRequest(obj.url));
			
		}
		var sound:Sound = cast(obj.sound, Sound);
		
		var nbloop:Null<Int> = (_loop) ? 9999 : 0;
		
		//Lib.debug();
		
		var sndTransform:SoundTransform = new SoundTransform(_vol);
		var sc:SoundChannel = sound.play(0, nbloop, sndTransform);
		obj.soundChannel = sc;
		
		
		/*
		if (sound.bytesLoaded > 0 && sound.bytesLoaded >= sound.bytesTotal){
			
			trace("sound already loaded");
			
		}
		else{
			trace("sound not loaded");
			sound.addEventListener(Event.COMPLETE, onSoundLoaded);
		}
		*/
		
	}
	
	static public function stop(_id:String) 
	{
		var obj = Reflect.getProperty(data, _id);
		if (obj != null){
			var sound:Sound = cast(obj.sound, Sound);
			if (obj.soundChannel == null) return;
			var sc:SoundChannel = cast(obj.soundChannel, SoundChannel);
			sc.stop();
		}
	}
	
	static private function onSoundLoaded(e:Event):Void 
	{
		/*
		var sound:Sound = cast(e.currentTarget, Sound);
		trace("onSoundLoaded " + sound.url);
		
		*/
	}
	
}