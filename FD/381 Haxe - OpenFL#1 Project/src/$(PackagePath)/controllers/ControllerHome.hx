package controllers;
import com.vinc.display.VButton;
import com.vinc.mvc.ControllerBase;
import com.vinc.mvc.MVCRoot;
import com.vinc.navigation.Navigation;

/**
 * ...
 * @author Vincent Huss
 */
class ControllerHome extends ControllerBase
{

	public function new() 
	{
		super();
	}
	
	
	
	override public function onclick(_id:String):Void 
	{
		trace("ControllerHome.onclick(" + _id + ")");
		
		
		if (_id == "btnplay") {
			
			Navigation.gotoScreen("", "screen_game");
			//Vars.assets.getSound("navigate").play();
		}
		
		
	}
	
	
	
	
	
	
	
}