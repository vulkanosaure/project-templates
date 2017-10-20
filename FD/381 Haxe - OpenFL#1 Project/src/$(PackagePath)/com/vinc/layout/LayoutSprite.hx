package com.vinc.layout;
import openfl.geom.Point;
import starling.display.Sprite;

/**
 * ...
 * @author Vincent Huss
 */
class LayoutSprite extends Sprite
{
	
	public var debugLayout:Bool = false;
	public var idLayout:String;
	
	public var marginLeft:Int;
	public var marginTop:Int;
	public var marginRight:Int;
	public var marginBottom:Int;
	
	public var centerH:Float;
	public var centerV:Float;
	
	public var layoutWidth:Int;
	public var layoutHeight:Int;
	
	public var isRoot:Bool;
	
	public var containerWidth:Int;
	public var containerHeight:Int;
	
	public var rootContainer:Sprite;
	
	public var layoutPosition:Point;
	
	

	public function new() 
	{
		super();
		
	}
	
	
	
	public function getLayoutWidth() 
	{
		if (this.layoutWidth == null) {
			this.layoutWidth = Std.int(this.width);
		}
		return this.layoutWidth;
		
	}
	
	public function getLayoutHeight() 
	{
		if (this.layoutHeight == null) {
			this.layoutHeight = Std.int(this.height);
		}
		return this.layoutHeight;
	}
	
	
}