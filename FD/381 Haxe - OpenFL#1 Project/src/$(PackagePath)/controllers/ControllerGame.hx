package controllers;
import com.vinc.mvc.ControllerBase;
import com.vinc.mvc.MVCRoot;
import com.vinc.navigation.Navigation;
import com.vinc.sound.SoundManager;
import com.vinc.time.DelayManager;
import openfl.events.TimerEvent;
import openfl.utils.Timer;
import starling.display.Sprite;
import view.ViewEnd;
import view.ViewGame;

/**
 * ...
 * @author Vincent Huss
 */
class ControllerGame extends ControllerBase
{
	var _view:ViewGame;
	

	public function new() 
	{
		super();
		
	}
	
	override public function init():Void 
	{
		super.init();
		
		
	}
	
	
	override public function update():Void 
	{
		trace("ctrlGame.update");
		
		initGame();
		
	}
	
	
	private function initGame():Void
	{
		trace("ctrlGame.initGame");
		
		
	}
	
	
	private function startGame():Void
	{
		trace("ctrlGame.startGame");
		
	}
	
	
	
	
	
	
	
	
	//______________________________________________________________________
	//events
	
	
	
	
	
	
	
}