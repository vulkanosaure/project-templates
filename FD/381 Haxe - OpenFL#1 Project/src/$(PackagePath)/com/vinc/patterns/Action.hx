package com.vinc.patterns;

/**
 * ...
 * @author Vincent Huss
 */
class Action 
{
	@:isVar public var type(get, null):String;
	@:isVar public var params(get, null):Dynamic;
	
	public function new(_type:String, _params:Dynamic = null) 
	{
		type = _type;
		params = _params;
	}
	
	function get_type():String 
	{
		return type;
	}
	
	function get_params():Dynamic 
	{
		return params;
	}
	
}