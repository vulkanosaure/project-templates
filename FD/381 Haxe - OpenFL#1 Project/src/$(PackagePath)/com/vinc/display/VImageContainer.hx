package com.vinc.display;
import openfl.geom.Point;
import starling.display.Image;
import starling.display.Sprite;
import starling.utils.AssetManager;

/**
 * ...
 * @author ...
 */
class VImageContainer extends Sprite	
{

	public static var assets:AssetManager;
	private var _nbchildren:Int;
	private var _curindex:Int;
	
	public function new(_list:Array<String>, _prefix:String = "", _offset:Point = null) 
	{
		super();
		
		var len:Int = _list.length;
		for (i in 0...len){
			
			var _key:String = _prefix + _list[i];
			trace("_key : " + _key);
			var _img:Image = new Image(assets.getTexture(_key));
			if (_offset != null){
				_img.x = _offset.x;
				_img.y = _offset.y;
			}
			addChild(_img);
			
			
		}
		
		_nbchildren = _list.length;
		
		this.setIndex(0);
	}
	
	
	public function setIndex(_index:Int):Void
	{
		if (_index == _curindex) return;
		
		_curindex = _index;
		for (i in 0..._nbchildren){
			this.getChildAt(i).visible = (i == _index);
		}
	}
	
}