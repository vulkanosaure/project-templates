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
	
	public var marginLeft:Null<Int>;
	public var marginTop:Null<Int>;
	public var marginRight:Null<Int>;
	public var marginBottom:Null<Int>;
	
	public var centerH:Null<Float>;
	public var centerV:Null<Float>;
	
	public var layoutWidth:Null<Int>;
	public var layoutWidthPercent:Null<Int>;
	public var layoutHeight:Null<Int>;
	public var layoutHeightPercent:Null<Int>;
	
	public var isRoot:Bool;
	
	public var containerWidth:Null<Int>;
	public var containerHeight:Null<Int>;
	
	public var rootContainer:Sprite;
	
	public var layoutPosition:Point;
	
	

	public function new() 
	{
		super();
		
	}
	
	
	
	public function getLayoutWidth(debug:Bool = false) 
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