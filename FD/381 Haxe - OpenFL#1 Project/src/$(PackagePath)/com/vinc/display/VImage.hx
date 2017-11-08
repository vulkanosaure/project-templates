package com.vinc.display;
import com.vinc.layout.LayoutSprite;
import starling.display.Image;
import starling.display.Sprite;
import starling.utils.AssetManager;

/**
 * ...
 * @author Vincent Huss
 */
class VImage extends LayoutSprite
{
	var _img:Image;
	public static var assets:AssetManager;

	public function new(_key:String) 
	{
		super();
		
		_img = new Image(assets.getTexture(_key));
		addChild(_img);
	}
	
	
	public function getImage():Image
	{
		return _img;
	}
	
}