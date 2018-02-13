package com.vinc.common;
import haxe.macro.Type.ClassType;

/**
 * ...
 * @author Vincent Huss
 */
class Pool 
{
	private static var _data:Dynamic;
	private static var _counterInstance:Dynamic;
	
	public static function createInstance(_key:String, _class:Class<Dynamic>, args:Array<Dynamic>, nb:Null<Int> = 1):Dynamic
	{
		if (_data == null) _data = {};
		if (_counterInstance == null) _counterInstance = {};
		
		var tab:Array<Dynamic> = Reflect.getProperty(_data, _key);
		
		if (tab != null){
			
			if (tab.length >= nb){
				
				var _counter:Null<Int> = Reflect.getProperty(_counterInstance, _key);
				
				var _output:Dynamic = tab[_counter];
				//trace("Pool::get tab[" + _counter + "]");
				
				_counter++;
				if (_counter >= nb) _counter = 0;
				Reflect.setProperty(_counterInstance, _key, _counter);
				
				return _output;
				
			}
		}
		else{
			tab = [];
			Reflect.setProperty(_data, _key, tab);
			Reflect.setProperty(_counterInstance, _key, 0);
			
		}
		
		var inst:Dynamic = Type.createInstance(_class, args);
		tab.push(inst);
		
		
		return inst;
		
	}
	
	
	
}