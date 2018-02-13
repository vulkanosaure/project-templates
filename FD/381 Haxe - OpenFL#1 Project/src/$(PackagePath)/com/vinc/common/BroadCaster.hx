package com.vinc.common;

/**
 * ...
 * @author Vincent Huss
 */
class BroadCaster 
{
	private static var data:Map<String, Array<Dynamic->Void>>;

	public static function dispatch(type:String, params:Dynamic = null):Void
	{
		if (data == null) data = new Map();
		if (data[type] != null){
			var tab:Array<Dynamic->Void> = data[type];
			var len = tab.length;
			for (i in 0...len) tab[i](params);
		}
	}
	
	public static function addEventListener(type:String, handler:Dynamic->Void):Void
	{
		if (data == null) data = new Map();
		if (data[type] == null) data[type] = [];
		var tab:Array<Dynamic->Void> = data[type];
		tab.push(handler);
		
	}
	
	
	
}