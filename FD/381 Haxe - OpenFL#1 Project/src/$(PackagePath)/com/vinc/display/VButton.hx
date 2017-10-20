package com.vinc.display;

import com.vinc.layout.LayoutSprite;
import com.vinc.xtends.Button2;
import haxe.Constraints.Function;
import js.html.Document;
import js.html.svg.Number;
import js.html.Window;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import openfl.system.Capabilities;
import openfl.system.System;
import openfl.ui.Mouse;
import starling.display.ButtonState;
import starling.display.DisplayObject;
import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.filters.ColorMatrixFilter;
import starling.textures.Texture;
import starling.utils.AssetManager;

/**
 * ...
 * @author Vincent Huss
 */	
class VButton extends LayoutSprite
{
	public static var assets:AssetManager;
	
	private var _btn:Button2;
	public var clickHandler(default, set):Function;
	
	public var cm(default, set):Int;
	public var cm_left(default, set):Int;
	public var cm_right(default, set):Int;
	public var cm_top(default, set):Int;
	public var cm_bottom(default, set):Int;
	
	public var br_downState(default, set):Float;
	public var br_disableState(default, set):Float;
	public var br_overState(default, set):Float;
	
	public var y_downState(default, set):Int;
	
	
	private var _filter:ColorMatrixFilter;
	private var _filter2:ColorMatrixFilter;
	

	public function new(_upstate:String, _downstate:String = "", _disablestate:String = "") 
	{
		super();
		
		var _textUpState:Texture = (_upstate == "") ? null : VButton.assets.getTexture(_upstate);
		var _textDownState:Texture = (_downstate == "") ? null : VButton.assets.getTexture(_downstate);
		var _textDisableState:Texture = (_disablestate == "") ? null : VButton.assets.getTexture(_disablestate);
		
		_btn = new Button2(_textUpState, "", _textDownState, null, _textDisableState);
		this.addChild(_btn);
		
		_btn.addEventListener(Event.TRIGGERED, onClick);
		
		_btn.addEventListener("Button2_TOUCH", onStateChange);
		
		_btn.alphaWhenDisabled = 1.0;
		_btn.scaleWhenDown = 1.0;
		
		
		
	}
	
	
	
	
	private function onStateChange(e:Event, _state:String):Void 
	{
		//trace("VButton.onStateChange " + _state);
		
		updateState(_state);
		
	}
	
	
	private function updateState(_state:String):Void
	{
		//brightness
		
		if (_filter != null) {
			/*
			#if mobile
			trace("mobile");
			#else
			trace("not mobile");
			#end
			*/
			
			
			var _br:Float = 0;
			if (_state  == ButtonState.DOWN && br_downState != null) _br = br_downState;
			else if (_state == ButtonState.DISABLED && br_disableState != null) _br = br_disableState;
			else if (_state == ButtonState.OVER && br_overState != null) _br = br_overState;
			
			_filter.reset();
			_filter2 = _filter.adjustBrightness(_br);
			this.filter = _filter2;
		}
		
		
		if (y_downState != null) {
			var _y:Int = 0;
			if (_state == ButtonState.DOWN) _y = y_downState;
			_btn.y = _y;
		}
	}
	
	
	
	
	
	private function onClick(e:Event):Void 
	{
		if (clickHandler != null) {
			clickHandler(this.idLayout);
		}
	}
	
	
	
	
	function set_br_downState(value:Float):Float 
	{
		if (_filter == null) _filter = new ColorMatrixFilter();
		return br_downState = value;
	}
	
	function set_br_disableState(value:Float):Float 
	{
		if (_filter == null) _filter = new ColorMatrixFilter();
		return br_disableState = value;
	}
	function set_br_overState(value:Float):Float 
	{
		
		if (_filter == null) _filter = new ColorMatrixFilter();
		return br_overState = value;
	}
	
	
	//________________________________________________
	
	
	
	
	
	
	public function enable(_value:Bool):Void
	{
		var _state:String = (_value) ? ButtonState.UP : ButtonState.DISABLED;
		_btn.state = _state;
		
		_btn.touchable = _value;
		
		updateState(_state);
	}
	
	private function set_clickHandler(value:Function):Function 
	{
		return clickHandler = value;
	}
	
	
	
	function set_cm(value:Int):Int 
	{
		_btn._clickableMargin = value;
		return cm = value;
	}
	function set_cm_left(value:Int):Int 
	{
		_btn._clickableMarginLeft = value;
		return cm_left = value;
	}
	function set_cm_right(value:Int):Int 
	{
		_btn._clickableMarginRight = value;
		return cm_right = value;
	}
	function set_cm_top(value:Int):Int 
	{
		_btn._clickableMarginTop = value;
		return cm_top = value;
	}
	function set_cm_bottom(value:Int):Int 
	{
		_btn._clickableMarginBottom = value;
		return cm_bottom = value;
	}
	
	function set_y_downState(value:Int):Int 
	{
		return y_downState = value;
	}
	
	
	
	
	
	
	
}



/*
TODO :

gestion de text
event pour positionnement y (flappy) => extends
clickableMargin																	OK
instead of giving texture for state, can play on luminosity


*/