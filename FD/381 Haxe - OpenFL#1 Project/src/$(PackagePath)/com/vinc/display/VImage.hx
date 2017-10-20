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
	public static var assets:AssetManager;

	public function new(_key:String) 
	{
		super();
		
		var _img:Image = new Image(assets.getTexture(_key));
		addChild(_img);
	}
	
}