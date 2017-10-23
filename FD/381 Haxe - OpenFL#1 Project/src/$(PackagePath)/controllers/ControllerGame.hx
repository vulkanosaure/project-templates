package controllers;
import com.vinc.common.BroadCaster;
import com.vinc.common.ObjectSearch;
import com.vinc.debug.KeyboardDebug;
import com.vinc.fx.ScreenBlink;
import com.vinc.mvc.ControllerBase;
import com.vinc.mvc.MVCRoot;
import com.vinc.navigation.Navigation;
import com.vinc.time.DelayManager;
import game.GameEngine;
import js.Cookie;
import openfl.ui.Keyboard;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import view.ViewEnd;
import view.ViewGame;

/**
 * ...
 * @author Vincent Huss
 */
class ControllerGame extends ControllerBase
{
	var _gameEngine:GameEngine;
	var _container:Sprite;
	

	public function new() 
	{
		super();
	}
	
	
	
	override public function init():Void 
	{
		trace("ControllerGame.init");
		
		_container = cast(ObjectSearch.getID("containerGame"), Sprite);
		_gameEngine = new GameEngine(openflstage, _container);
		
		BroadCaster.addEventListener("GAMEOVER", onGameOver);
		BroadCaster.addEventListener("COUNTER", onCounterChange);
		
		if (Constants.DEBUG_MODE) {
			KeyboardDebug.init(openflstage);
			//KeyboardDebug.addFunction(Keyboard.SPACE, onAction);
			
		}
		
		//Vars.starlingStage.addEventListener(TouchEvent.TOUCH, onTouch);
		
		
		
	}
	
	
	
	//touch global
	private function onTouch(e:TouchEvent):Void 
	{
		var _touch:Touch = e.getTouch(Vars.starlingStage);
		//trace("_touch.phase:" + _touch.phase);
		
		//trace("_touch : " + _touch);
		if (_touch == null) return;
		if (_touch.phase == TouchPhase.BEGAN) {
			//action
		}
	}
	
	
	
	private function onCounterChange(e:Event):Void 
	{
		trace("onCounterChange " + e.data);
		//cast(MVCRoot.getView("screen_game"), ViewGame).setCounterGame(Std.int(e.data));
	}
	
	
	
	private function onGameOver(e:Event):Void 
	{
		trace("ControllerGame.onGameOver");
		_gameEngine.stop();
		
		var _viewEnd:ViewEnd = cast(MVCRoot.getView("screen_end"), ViewEnd);
		var _score:Int = _gameEngine.getScore();
		
		
		
		
	}
	
	
	
	override public function update():Void 
	{
		var _view:ViewGame = cast(MVCRoot.getView(idscreen), ViewGame);
		_gameEngine.reset();
		
		
		
		
		
	}
	
	
	
	
}