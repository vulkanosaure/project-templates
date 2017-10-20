package com.vinc.time;
import haxe.Constraints.Function;

/**
 * ...
 * @author Vincent Huss
 */
class DelayManager
{

	public function new() 
	{
		
	}
	private static var _items:Array<Delay>;
	
	
	public static function add(_group:String, t:Float, f:Function, args:Array<Dynamic> = null):Void
	{
		if (_items == null) _items = new Array();
		var _d:Delay = new Delay(t, f, args);
		_d.group = _group;
		_items.push(_d);
	}
	
	public static function reset():Void
	{
		if (_items == null) _items = new Array();
		var _len:Int = _items.length;
		for (i in 0..._len) 
		{
			var _d:Delay = cast(_items[i], Delay);
			if (_d != null && _d.waiting) _d.stop();
		}
		_items = new Array();
	}
	
	
	public static function resetGroup(_group:String):Void
	{
		if (_items == null) _items = new Array();
		var _len:Int = _items.length;
		for (i in 0..._len) 
		{
			var _d:Delay = cast(_items[i], Delay);
			if (_d != null && _d.group == _group && _d.waiting) {
				_d.stop();
			}
		}
		//_items = new Array();
	}
	
}