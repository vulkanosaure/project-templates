package view;
import com.vinc.common.ObjectSearch;
import com.vinc.display.VImage;
import com.vinc.layout.LayoutManager;
import com.vinc.layout.LayoutSprite;
import com.vinc.mvc.MVCRoot;
import com.vinc.mvc.ViewBase;
import controllers.ControllerHome;
import starling.display.Sprite;
import ui.VButton1;

/**
 * ...
 * @author Vincent Huss
 */
class ViewHome extends ViewBase
{

	public function new() 
	{
		super();
	}
	
	
	override public function construct():Void 
	{
		_container = new LayoutSprite();
		Vars.containerFG.addChild(_container);
		ObjectSearch.registerID(_container, "screen_home");
		
		
		var _zonecenter:LayoutSprite = new LayoutSprite();
		_container.addChild(_zonecenter);
		_zonecenter.idLayout = "zonecenter";
		LayoutManager.addItem(_zonecenter, { "width" : 400, "height" : 420, "center-v" : 0.5, "center-h" : 0.5 } );
		
		
		var _title:VImage = new VImage("interface/game-title");
		_zonecenter.addChild(_title);
		_title.idLayout = "title";
		LayoutManager.addItem(_title, { "center-h" : 0.5 } );
		trace("test");
		
		
		var _btnrate:VButton1 = new VButton1("interface/buttons/btn-rate");
		_zonecenter.addChild(_btnrate);
		LayoutManager.addItem(_btnrate, { "center-h" : 0.5, "margin-top" : 200, "id" : "btnrate" } );
		_btnrate.clickHandler = MVCRoot.getController("screen_home").onclick;
		
		
		var _btnplay:VButton1 = new VButton1("interface/buttons/btn-play");
		_zonecenter.addChild(_btnplay);
		LayoutManager.addItem(_btnplay, { "margin-left" : 0, "margin-bottom" : 0 , "id" : "btnplay"} );
		_btnplay.clickHandler = MVCRoot.getController("screen_home").onclick;
		
		
	}
	
	
	
	
}