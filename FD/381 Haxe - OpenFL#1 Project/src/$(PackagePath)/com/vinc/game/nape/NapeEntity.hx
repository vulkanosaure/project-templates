package com.vinc.game.nape;
import nape.phys.Body;
import nape.space.Space;
import openfl.errors.Error;
import openfl.geom.Point;
import starling.display.DisplayObject;

/**
 * ...
 * @author Vincent Huss
 */
class NapeEntity
{
	
	public var listBody:Array<Body>;
	public var listGraphics:Array<DisplayObject>;
	public var space(default, set):Space;
	
	
	
	

	public function new() 
	{
		listBody = new Array();
		listGraphics = new Array();
		
	}
	
	
	
	
	function set_space(value:Space):Space { 
		var _len:Null<Int> = listBody.length;
		if (_len == 0) throw new Error("no body defined");
		
		for (i in 0..._len) 
		{
			listBody[i].space = value;
		}
		return space = value; 
	}
	
	
	
	public function updateGraphic() :Void
	{
		var _nbgraphic:Null<Int> = listGraphics.length;
		var _nbbody:Null<Int> = listBody.length;
		
		for (i in 0..._nbbody) 
		{
			var _body:Body = listBody[i];
			var _graphic:DisplayObject = listGraphics[i];
			_graphic.x = _body.position.x;
			_graphic.y = _body.position.y;
			
		}
		
		
		
	}
	
	
	
}