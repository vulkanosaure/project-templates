package com.vinc.common;

/**
 * ...
 * @author Vincent Huss
 */
class ObjectSearch
{
	private static var _listInstances:Dynamic;

	public function new() 
	{
		
	}
	
	static public function getID(_id:String) :Dynamic
	{
		if (_listInstances == null) _listInstances = {};
		var _object:Dynamic = Reflect.getProperty(_listInstances, _id);
		if (_object == null) throw ("id #" + _id + " is not defined");
		return _object;
	}
	
	
	
	public static function registerID(_object:Dynamic, _id:String):Void
	{
		var _checkIDdoublons:Bool = false;	//todo if debug
		
		if (_listInstances == null) _listInstances = {};
		if (_checkIDdoublons && Reflect.getProperty(_listInstances, _id) != null) throw ("id #" + _id + " is allready defined for instance " + Reflect.getProperty(_listInstances, _id));
		Reflect.setProperty(_listInstances, _id, _object);
		
	}
	
	
}