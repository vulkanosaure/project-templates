package com.vinc.debug;
import haxe.Constraints.Function;
import openfl.display.Stage;
import openfl.events.KeyboardEvent;
import openfl.ui.Keyboard;
import openfl.utils.Object;

/**
 * ...
 * @author Vincent Huss
 */
class KeyboardDebug
{
	private static var _data:Array<Object>;

	public function new() 
	{
		
	}
	
	public static function init(_stage:Stage):Void
	{
		
		_stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeydown);
		
	}
	
	public static function test(_obj:Object):Void
	{
		for (i in _obj) 
		{
			trace("i : " + i + ", _obj[i] : ");
		}
	}
	
	
	static private function onKeydown(e:KeyboardEvent):Void 
	{
		var _obj:Object = getItemByKey(e.keyCode);
		if (_obj != null) {
			if (_obj.func != null) {
				_obj.func();
			}
		}
	}
	
	static public function addFunction(_key:Dynamic, _func:Function):Void
	{
		if (_data == null) _data = new Array();
		var _obj:Object = new Object();
		_obj.key = _key;
		_obj.func = _func;
		_data.push(_obj);
		
	}
	
	private static function getItemByKey(_key:Dynamic):Object
	{
		var _len:Int = _data.length;
		for (i in 0..._len) 
		{
			if (_data[i].key == _key) return _data[i];
		}
		return null;
	}
}