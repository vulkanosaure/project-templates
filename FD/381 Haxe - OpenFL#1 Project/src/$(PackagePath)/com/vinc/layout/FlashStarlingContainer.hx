package com.vinc.layout;
import openfl.display.Sprite;
import openfl.geom.Point;
import starling.display.DisplayObject;
import starling.display.Stage;

/**
 * ...
 * @author Vincent Huss
 */
class FlashStarlingContainer extends Sprite
{

	public function new() 
	{
		super();
		
	}
	
	public function sync(_starlingDobj:DisplayObject, _starlingStage:Stage):Void
	{
		var _countsecu:Int = 0;
		var _obj:DisplayObject = _starlingDobj;
		
		var _pos:Point = new Point();
		var _scaleX:Float = 1;
		var _scaleY:Float = 1;
		
		while (true) {
			
			
			_pos.x += _obj.x;
			_pos.y += _obj.y;
			_scaleX *= _obj.scaleX;
			_scaleY *= _obj.scaleY;
			if (_obj == _starlingStage) break;
		
			
			_obj = _obj.parent;
			_countsecu ++;
			if (_countsecu > 30) break;
		}
		trace("_countsecu : " + _countsecu);
		trace("pos: " + _pos + ", scale : " + _scaleX);
		
		this.x = _pos.x * __scaleX;
		this.y = _pos.y * _scaleY;
		this.scaleX = _scaleX;
		this.scaleY = _scaleY;
	}
	
}