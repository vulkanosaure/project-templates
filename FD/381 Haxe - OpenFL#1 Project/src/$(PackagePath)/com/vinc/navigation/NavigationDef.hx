package com.vinc.navigation;
import motion.easing.IEasing;

/**
 * ...
 * @author Vinc
 */
class NavigationDef 
{
	public static inline var DOWN:String = "down";
	public static inline var TOP:String = "top";
	public static inline var LEFT:String = "left";
	public static inline var RIGHT:String = "right";
	public static inline var NONE:String = "none";
	public static inline var ZOOM:String = "zoom";
	
	public var id(get, null):String;
	@:isVar public var value(get, set):Bool;
	public var side(get, null):String;
	public var delay(get, null):Float;
	public var dist(get, null):Float;
	public var fade(get, null):Bool;
	public var time(get, null):Float;
	public var easing(get, null):IEasing;
	public var callback(get, null):String->Void;
	
	
	public function new(__id:String, __side:String, __delay:Float, __dist:Float = 1100, __fade:Bool = false, __time:Float = 0.6, __easing:IEasing = null, __callback:String->Void = null) 
	{
		id = __id;
		side = __side;
		delay = __delay;
		dist = __dist;
		fade = __fade;
		time = __time;
		easing = __easing;
		callback = __callback;
	}
	
	
	public function setid(value:String):Void
	{
		id = value;
	}
	
	
	public function get_id():String 
	{
		return id;
	}
	
	public function get_value():Bool 
	{
		return value;
	}
	
	public function set_value(_v:Bool):Bool 
	{
		return value = _v;
	}
	
	public function get_side():String 
	{
		return side;
	}
	
	public function get_delay():Float 
	{
		return delay;
	}
	
	public function get_dist():Float 
	{
		return dist;
	}
	
	
	public function get_fade():Bool 
	{
		return fade;
	}
	
	public function get_time():Float 
	{
		return time;
	}
	
	public function get_easing():IEasing 
	{
		return easing;
	}
	
	public function get_callback():String->Void 
	{
		return callback;
	}
	
}