package controllers;
import com.vinc.common.ObjectSearch;
import com.vinc.display.VButton;
import com.vinc.mvc.ControllerBase;
import com.vinc.mvc.MVCRoot;
import com.vinc.navigation.Navigation;
import com.vinc.sound.SoundManager;
import com.vinc.time.DelayManager;
import openfl.external.ExternalInterface;
import openfl.media.Sound;
import starling.display.Sprite;
import view.ViewGlobal;

/**
 * ...
 * @author Vincent Huss
 */
class ControllerGlobal extends ControllerBase
{

	public function new() 
	{
		super();
	}
	
	
	override public function init():Void 
	{
		super.init();
		VButton.globalClickHandler = function():Void
		{
			//SoundManager.play("click");
			
		}
	}
	
	
	
	override public function onclick(_id:String):Void 
	{
		trace("CtrlGlobal.onclick(" + _id + ")");
		
		
		
		
	}
	
	
	
	public function startApp() 
	{
		trace("CtrlGlobal.startApp");
		
		
	}
	
	
	public function closeApp():Void
	{
		trace("CtrlGlobal.closeApp");
		
		//Navigation.gotoScreen("", "", 0, true);
		
		
		#if html5
		@:keep
		trace("ExternalInterface.available ! " + ExternalInterface.available);
		if (ExternalInterface.available){
			//ExternalInterface.call("closeGame");
			DelayManager.add("", 1, function(){
				untyped __js__("closeGame()");		//externalinterface.call saute
				
			});
		}
		#end
	}
}