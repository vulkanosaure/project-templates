package com.vinc.common.interfaces.displayobject;
import starling.display.Sprite;

/**
 * ...
 * @author Vincent Huss
 */
class DisplayObjectStarling extends Sprite implements IDisplayObject
{

	public function new() 
	{
		super();
	}
	
	
	
	
	public function getPosition(prop:String):Null<Float>
	{
		return (prop == "x") ? this.x : this.y;
	}
	
	public function setPosition(prop:String, value:Null<Float>):Void
	{
		(prop == "x") ? this.x = value : this.y = value;
	}
	public function getDimension(prop:String):Null<Float>
	{
		return (prop == "width") ? this.width : this.height;
	}
	
	public function setDimension(prop:String, value:Null<Float>):Void
	{
		(prop == "width") ? this.width = value : this.height = value;
	}
	
	
}