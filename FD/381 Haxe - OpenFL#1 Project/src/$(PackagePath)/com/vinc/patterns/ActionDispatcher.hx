package com.vinc.patterns;
import haxe.Constraints.Function;
import starling.events.EventDispatcher;

/**
 * ...
 * @author Vincent Huss
 */
class ActionDispatcher 
{
	private static var evtDispatcher:EventDispatcher;
	private static var listenerGlobals:Array<Function>;
	
	public static function dispatch(type:String, params:Dynamic = null, dispatchGlobal:Bool = true):Void
	{
		if (evtDispatcher == null) evtDispatcher = new EventDispatcher();
		evtDispatcher.dispatchEventWith(type, false, params);
		
		if(dispatchGlobal){
			if (listenerGlobals == null) listenerGlobals = [];
			var len:Int = listenerGlobals.length;
			for (i in 0...len){
				var f:Function = listenerGlobals[i];
				f(type, params);
			}
		}
		
	}
	
	public static function hasEvent(type:String):Bool
	{
		if (evtDispatcher == null) evtDispatcher = new EventDispatcher();
		return evtDispatcher.hasEventListener(type);
	}
	
	public static function listen(type:String, handler:Function):Void
	{
		if (evtDispatcher == null) evtDispatcher = new EventDispatcher();
		
		evtDispatcher.addEventListener(type, handler);
	}
	
	static public function removeListener(type:String, handler:Function) 
	{
		if (evtDispatcher == null) evtDispatcher = new EventDispatcher();
		
		evtDispatcher.removeEventListener(type, handler);
	}
	
	static public function listenGlobal(handler:Function) 
	{
		if (listenerGlobals == null) listenerGlobals = [];
		listenerGlobals.push(handler);
	}
	
	
	
}