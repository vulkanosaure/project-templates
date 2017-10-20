package com.vinc.common;
import haxe.Constraints.Function;
import starling.events.Event;
import starling.events.EventDispatcher;

/**
 * ...
 * @author Vincent Huss
 */
class BroadCaster
{
	private static var _evtDispatcher:EventDispatcher;

	public function new() 
	{
		
	}
	
	
	public static function dispatchEvent(_evt:Event):Void
	{
		if (_evtDispatcher == null) _evtDispatcher = new EventDispatcher();
		_evtDispatcher.dispatchEvent(_evt);
	}
	
	public static function addEventListener(_type:String, _handler:Function):Void
	{
		if (_evtDispatcher == null) _evtDispatcher = new EventDispatcher();
		_evtDispatcher.addEventListener(_type, _handler);
	}
	
}