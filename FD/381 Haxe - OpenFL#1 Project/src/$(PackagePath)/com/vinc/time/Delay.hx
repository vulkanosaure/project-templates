package com.vinc.time;
import com.vinc.patterns.ActionDispatcher;
import haxe.Constraints.Function;
import haxe.Timer;

/**
 * ...
 * @author Vincent Huss
 */
class Delay
{
	
	private var timer:Timer;
	private var time:Null<Int>;
	
	public var func(get,null):Function;
	public var waiting(get,null):Bool;
	@:isVar public var params(get,set):Array<Dynamic>;
	@:isVar public var group(get, set):String;
	
	private var counter:Int;
	
	//_______________________________________________________________
	//public functions
	
	public function new(t:Null<Float>, f:Function, args:Array<Dynamic> = null) 
	{ 
		if (t < 0) throw ("arg t must be > than 0");
		params = args;
		if(args!= null && args.length>10) throw ("Class Delay doesn't accept more than 10 parameters, you need to edit the class");
		
		/*
		timer = new Timer(t, 1);
		func = f;
		timer.addEventListener(TimerEvent.TIMER, onTimer);
		*/
		
		func = f;
		time = Std.int(t);
		
		//trace("new Delay " + t);
		
		if (t > 0) {
			
			waiting = true;
			if (!ActionDispatcher.hasEvent("enterframe")){
				
				//trace("Delay no AD");
				timer = new Timer(time);
				timer.run = onTimer;
			}
			else{
				ActionDispatcher.listen("enterframe", onEnterframe);
				counter = Math.round(time * (30 / 1000));
				//trace("Delay counter : "+counter);
				
			}
			
			
		}
		else {
			execFunction();
		}
		
	}
	
	
	
	private function removeActionDispatcher():Void
	{
		ActionDispatcher.removeListener("enterframe", onEnterframe);
	}
	
	
	
	public function stop():Void
	{
		if (timer != null) timer.stop();
		else removeActionDispatcher();
		
	}
	public function pause():Void
	{
		if (timer != null) timer.stop();
		else removeActionDispatcher();
	}
	
	public function resume():Void
	{
		if (timer != null){
			timer = new Timer(time);
			timer.run = onTimer;			
		}
		else{
			ActionDispatcher.listen("enterframe", onEnterframe);
		}
	}
	
	public function start():Void
	{
		
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
	
	private function onTimer():Void
	{
		execFunction();
		timer.stop();
	}
	
	
	private function onEnterframe() 
	{
		//trace("Delay.onEnterframe");
		if (counter < 0){
			removeActionDispatcher();
			execFunction();
		}
		counter--;
	}
	
	
	
	
	private function execFunction():Void
	{
		waiting = false;
		var len:Null<Int> = (params == null) ? 0 : params.length;
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