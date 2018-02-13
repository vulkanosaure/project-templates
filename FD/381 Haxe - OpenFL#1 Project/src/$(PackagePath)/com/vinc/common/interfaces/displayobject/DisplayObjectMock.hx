package com.vinc.common.interfaces.displayobject;

/**
 * ...
 * @author Vincent Huss
 */
class DisplayObjectMock implements IDisplayObject
{
	private var width:Null<Float>;
	private var height:Null<Float>;
	private var x:Null<Float>;
	private var y:Null<Float>;
	

	public function new() 
	{
		x = 0;
		y = 0;
		width = null;
		height = null;
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