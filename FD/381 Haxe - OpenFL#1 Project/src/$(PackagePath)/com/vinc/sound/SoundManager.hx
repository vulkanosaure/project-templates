package com.vinc.sound;
import haxe.io.Error;
import openfl.media.Sound;
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
	
	public static function play(_id:String):Void
	{
		if (!SOUND_ENABLED) return;
		
		var obj = Reflect.getProperty(data, _id);
		if (obj == null) throw "sound #" + _id + " doesn't exist";
		
		if (obj.sound == null){
			//todo
			obj.sound = new Sound(new URLRequest(obj.url));
			
		}
		var sound:Sound = cast(obj.sound, Sound);
		sound.play();
		
		
	}
	
}