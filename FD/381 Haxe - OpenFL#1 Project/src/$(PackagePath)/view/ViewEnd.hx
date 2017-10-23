package view;
import com.vinc.common.ObjectSearch;
import com.vinc.display.VImage;
import com.vinc.layout.LayoutManager;
import com.vinc.layout.LayoutSprite;
import com.vinc.mvc.MVCRoot;
import com.vinc.mvc.ViewBase;
import controllers.ControllerEnd;
import haxe.Timer;
import motion.Actuate;
import motion.easing.Linear;
import openfl.system.System;
import starling.display.Sprite;
import starling.text.TextField;
import ui.VButton1;

/**
 * ...
 * @author Vincent Huss
 */
class ViewEnd extends ViewBase
{

	public function new() 
	{
		super();
	}
	
	override public function construct():Void 
	{
		_container = new LayoutSprite();
		Vars.containerFG.addChild(_container);
		ObjectSearch.registerID(_container, "screen_end");
		
		
		var _zonecenter:LayoutSprite = new LayoutSprite();
		_container.addChild(_zonecenter);
		_container = _zonecenter;
		LayoutManager.addItem(_zonecenter, {"width": 376, "height" : 445, "center-h" : 0.5, "center-v" : 0.54 } );
		
		
		
	}
	
	
	
	
	
	
}