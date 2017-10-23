package view;
import com.vinc.common.ObjectSearch;
import com.vinc.display.VImage;
import com.vinc.layout.LayoutManager;
import com.vinc.layout.LayoutSprite;
import com.vinc.math.Math2;
import com.vinc.mvc.ViewBase;
import com.vinc.time.DelayManager;
import display.Counter;
import haxe.Constraints.Function;
import motion.Actuate;
import starling.display.Sprite;

/**
 * ...
 * @author Vincent Huss
 */
class ViewGame extends ViewBase
{
	var _counter:Counter;

	public function new() 
	{
		super();
	}
	
	override public function construct():Void 
	{
		_container = new LayoutSprite();
		Vars.containerFG.addChild(_container);
		LayoutManager.addItem(_container, { "center-v" : 0.2, "center-h" : 0.5, "width" : 309, "height" : 420 } );
		ObjectSearch.registerID(_container, "screen_game");
		
		
		_counter = new Counter();
		_container.addChild(_counter);
		LayoutManager.addItem(_counter, { "center-h" : 0.5 } );
		_counter.setValue(0);
		
		
		var _containerGame:Sprite = cast(ObjectSearch.getID("containerGame"), Sprite);
		
		
		
		
	}
	
	
	
	
	public function setCounterGame(_score:Int) 
	{
		_counter.setValue(_score);
	}
	
	
	
	
}