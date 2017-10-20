package com.vinc.fx;
import motion.Actuate;
import motion.easing.Linear;
import openfl.display.Stage;
import starling.display.Quad;
import starling.display.Sprite;
import starling.events.Event;
import starling.utils.Max;

/**
 * ...
 * @author Vincent Huss
 */
class ScreenBlink
{
	static private var _quad:Quad;
	static private var _openflstage:Stage;

	public function new() 
	{
		
	}
	
	public static function init(__openflstage:Stage, _container:Sprite):Void
	{
		_quad = new Quad(1, 1);
		_container.addChild(_quad);
		_quad.touchable = false;
		
		_openflstage = __openflstage;
		
		updateSize();
		
		_quad.visible = false;
		
		_openflstage.addEventListener(Event.RESIZE, onResize, false, Max.INT_MAX_VALUE, true);
	}
	
	
	static private function onResize(e:Event):Void 
	{
		updateSize();
	}
	
	
	
	
	
	static private function updateSize() 
	{
		_quad.width = _openflstage.stageWidth;
		_quad.height = _openflstage.stageHeight;
		
	}
	
	
	public static function blink(_color:UInt, _timein:Float, _time:Float, _timeout:Float):Void
	{
		_quad.color = _color;
		
		_quad.visible = true;
		_quad.alpha = 0;
		Actuate.tween(_quad, _timein, { alpha : 1 } ).ease(Linear.easeNone);
		
		var _time2:Float = _timein + _time;
		Actuate.tween(_quad, _timeout, { alpha : 0 }, false ).delay(_time2).ease(Linear.easeNone);
		
	}
	
	
}