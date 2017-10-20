package com.vinc.time;
import haxe.Constraints.Function;
import openfl.errors.Error;
import openfl.events.TimerEvent;
import openfl.utils.Timer;

/**
 * ...
 * @author Vincent Huss
 */
class Delay
{
	
	private var timer:Timer;
	
	public var func(get,null):Function;
	public var waiting(get,null):Bool;
	@:isVar public var params(get,set):Array<Dynamic>;
	@:isVar public var group(get,set):String;
	
	//_______________________________________________________________
	//public functions
	
	public function new(t:Float, f:Function, args:Array<Dynamic> = null) 
	{ 
		if (t < 0) throw new Error("arg t must be > than 0");
		params = args;
		if(args!= null && args.length>10) throw new Error("Class Delay doesn't accept more than 10 parameters, you need to edit the class");
		timer = new Timer(t, 1);
		func = f;
		timer.addEventListener(TimerEvent.TIMER, onTimer);
		
		if (t > 0) {
			timer.start();
			waiting = true;
		}
		else {
			execFunction();
		}
		
	}
	
	
	
	
	public function stop():Void
	{
		timer.stop();
		timer.reset();
	}
	public function pause():Void
	{
		timer.stop();
	}
	
	public function resume():Void
	{
		timer.start();
	}
	
	public function start():Void
	{
		timer.start();
	}
	
	//__________________________________________
	
	public function get_waiting():Bool
	{
		return waiting;
	}
	
	
	public function get_func():Function { return func; }
	
	
	public function set_params(value:Array<Dynamic>):Array<Dynamic> 
	{
		return params = value;
	}
	
	public function get_params():Array<Dynamic> { return params; }
	
	public function get_group():String {return group;}
	
	public function set_group(value:String):String 
	{
		return group = value;
	}
	
	//_______________________________________________________________
	//private functions
	
	
	
	
	
	//_______________________________________________________________
	//events handlers
	private function onTimer(e:TimerEvent):Void
	{
		execFunction();
	}
	
	private function execFunction():Void
	{
		waiting = false;
		var len:Int = (params == null) ? 0 : params.length;
		if(len==0) func();
		else if(len==1) func(params[0]);
		else if(len==2) func(params[0], params[1]);
		else if(len==3) func(params[0], params[1], params[2]);
		else if(len==4) func(params[0], params[1], params[2], params[3]);
		else if(len==5) func(params[0], params[1], params[2], params[3], params[4]);
		else if(len==6) func(params[0], params[1], params[2], params[3], params[4], params[5]);
		else if(len==7) func(params[0], params[1], params[2], params[3], params[4], params[5], params[6]);
		else if(len==8) func(params[0], params[1], params[2], params[3], params[4], params[5], params[6], params[7]);
		else if(len==9) func(params[0], params[1], params[2], params[3], params[4], params[5], params[6], params[7], params[8]);
		else if(len==10) func(params[0], params[1], params[2], params[3], params[4], params[5], params[6], params[7], params[8], params[9]);
	}
	
}