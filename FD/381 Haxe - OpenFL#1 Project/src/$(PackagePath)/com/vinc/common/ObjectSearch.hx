package com.vinc.common;
import openfl.errors.Error;
import openfl.utils.Object;
import starling.display.Sprite;

/**
 * ...
 * @author Vincent Huss
 */
class ObjectSearch
{
	private static var _listInstances:Object;

	public function new() 
	{
		
	}
	
	static public function getID(_id:String) :Sprite
	{
		if (_listInstances == null) _listInstances = new Object();
		var _object:Object = _listInstances[_id];
		if (_object == null) throw new Error("id #" + _id + " is not defined");
		if (!Std.is(_object, Sprite)) throw new Error("id #" + _id + " must be a starling.display.Sprite");
		return cast(_object, Sprite);
	}
	
	
	
	public static function registerID(_object:Sprite, _id:String):Void
	{
		var _checkIDdoublons:Bool = false;	//todo if debug
		
		if (_listInstances == null) _listInstances = new Object();
		if (_checkIDdoublons && _listInstances[_id] != null) throw new Error("id #" + _id + " is allready defined for instance " + _listInstances[_id]);
		_listInstances[_id] = _object;
		
	}
	
	
}