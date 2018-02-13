package com.vinc.game.dataprogress;

/**
 * ...
 * @author Vincent Huss
 */
class DataProgressItem 
{

	public function new(_progress:Null<Int>, _data:Dynamic) 
	{
		progress = _progress;
		data = _data;
	}
	
	
	public var progress:Null<Int>;
	public var data:Dynamic;
	
}