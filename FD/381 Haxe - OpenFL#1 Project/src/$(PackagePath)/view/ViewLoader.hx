package view;
import com.vinc.common.ObjectSearch;
import com.vinc.display.VImage;
import com.vinc.layout.LayoutManager;
import com.vinc.layout.LayoutSprite;
import com.vinc.mvc.ViewBase;
import starling.display.Quad;

/**
 * ...
 * @author Vincent Huss
 */
class ViewLoader extends ViewBase
{

	public function new() 
	{
		super();
	}
	
	override public function construct():Void 
	{
		_container = new LayoutSprite();
		Vars.containerBG.addChild(_container);
		ObjectSearch.registerID(_container, "screen_loader");
		
		var _bgcontainer:LayoutSprite = new LayoutSprite();
		_container.addChild(_bgcontainer);
		LayoutManager.addItem(_bgcontainer, { "center-h" : 0.5, "center-v" : 0.5 } );
		ObjectSearch.registerID(_bgcontainer, "screen_loader_bg");
		
		var _bg:Quad = new Quad(Constants.GAME_WIDTH, Constants.GAME_HEIGHT, 0x000000);
		_bgcontainer.addChild(_bg);
		
		
		var _loader:VImage = new VImage("interface/gears-logo");
		Vars.containerFG.addChild(_loader);
		LayoutManager.addItem(_loader, { "center-h" : 0.5, "center-v" : 0.5 } );
		ObjectSearch.registerID(_loader, "screen_loader_fg");
		
		
	}
	
}