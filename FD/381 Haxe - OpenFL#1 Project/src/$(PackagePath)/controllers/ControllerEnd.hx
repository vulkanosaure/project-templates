package controllers;
import com.vinc.display.VButton;
import com.vinc.mvc.ControllerBase;
import com.vinc.mvc.MVCRoot;
import com.vinc.navigation.Navigation;

/**
 * ...
 * @author Vincent Huss
 */
class ControllerEnd extends ControllerBase
{

	public function new() 
	{
		super();
	}
	
	
	override public function onclick(_id:String):Void 
	{
		trace("ControllerEnd.onClick(" + _id + ")");
		
		if (_id == "btnplay_end") {
			Navigation.gotoScreen("", "screen_game");
			
		}
		
		
	}
	
}