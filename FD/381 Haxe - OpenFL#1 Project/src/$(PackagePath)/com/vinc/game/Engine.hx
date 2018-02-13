package com.vinc.game;
import haxe.Constraints.Function;
import haxe.Timer;

/**
 * ...
 * @author Vincent Huss
 */
class Engine 
{
	private static var _enterframes:Array<Dynamic>;
	private static var _params:Dynamic;
	private static var _len:Null<Int>;
	private static var _paused:Bool;
	
	
	
	public static function update() 
	{
		if (_paused) return;
		
		for (i in 0..._len){
			var obj:Dynamic = _enterframes[i];
			var _params:Dynamic = Reflect.getProperty(obj, "paramobj");
			var _func:Function = Reflect.getProperty(obj, "func");
			_func(_params);
		}
	}
	
	private static function init():Void
	{
		_enterframes = [];
		_params = {};
		_len = 0;
		_paused = true;
		
	}
	
	
	public static function addEnterframe(_id:String, _func:Function, _paramobj:Dynamic):Void
	{
		if (_enterframes == null) init();
		
		_enterframes.push({id : _id, func : _func, paramobj : _paramobj});
		_len++;
		/*
		for (key in _paramobj){
			trace("- _key : " + key);
			if (!Reflect.hasField(_params, key)){
				Reflect.setProperty(_params, _key, null);
			}
		}*/
		
		
	}
	
	
	public static function setParam(_key:String, _value:Dynamic):Void
	{
		if (_enterframes == null) init();
		
		for (i in 0..._len){
			var obj:Dynamic = _enterframes[i];
			var params:Dynamic = Reflect.getProperty(obj, "paramobj");
			if (params != null && Reflect.hasField(params, _key)){	
				Reflect.setProperty(params, _key, _value);
			}
		}
	}
	
	static public function pause() :Void
	{
		_paused = true;
	}
	static public function play():Void
	{
		_paused = false;
	}
	
	
	
	
	
	
}