package;
import com.vinc.layout.LayoutManager;
import com.vinc.mvc.ControllerBase;
import com.vinc.mvc.MVCRoot;
import com.vinc.mvc.ViewBase;
import com.vinc.navigation.Navigation;
import com.vinc.navigation.NavigationDef;
import com.vinc.patterns.ActionDispatcher;
import com.vinc.sound.SoundManager;
import controllers.ControllerEnd;
import controllers.ControllerGame;
import controllers.ControllerGlobal;
import controllers.ControllerHome;
import motion.easing.Back;
import motion.easing.Sine;
import openfl.display.Stage;
import openfl.external.ExternalInterface;
import openfl.geom.Point;
import starling.core.Starling;
import starling.display.Sprite;
import starling.events.Event;
import view.ViewEnd;
import view.ViewGame;
import view.ViewGlobal;
import view.ViewHome;
import view.ViewLoader;

/**
 * ...
 * @author Vincent Huss
 */
@:keep class StarlingRoot extends Sprite
{
	var _viewLoader:ViewLoader;

	public function new()
	{
		super();
		ExternalInterface.addCallback("start", onExternalStart);
	}
	

	public function preload(_openflstage:Stage, __starling:Starling):Void
	{
		trace("StarlingRoot.preload");
		
		
		
		Vars.starlingStage = __starling.stage;
		Vars.openflstage = _openflstage;
		Vars.starlingRoot = this;
		
		LayoutManager.init(__starling, new Point(Constants.GAME_WIDTH, Constants.GAME_HEIGHT));
		
		//set containers
		
		Vars.containerBG = new Sprite();
		Vars.starlingRoot.addChild(Vars.containerBG);
		
		Vars.containerFG = new Sprite();
		Vars.starlingRoot.addChild(Vars.containerFG);
		
		//LayoutManager.addContainer(Vars.containerFG, 0, {"min-scale":1, "max-scale":1});
		LayoutManager.addContainer(Vars.containerFG, 0);
		LayoutManager.addContainer(Vars.containerBG, 1);
		
		_viewLoader = new ViewLoader();  _viewLoader.construct();
		
		LayoutManager.update();
		
		
		//register here 
		stage.addEventListener(Event.ENTER_FRAME, onEnterframe);
		
	}
	
	
	
	
	
	

	public function loadProgress(ratio:Float):Void
	{
		_viewLoader.updateProgress(ratio);
	}

	public function loadComplete()
	{
		_viewLoader.loadComplete();
	}

	public function start(_openflstage:Stage, __starling:Starling):Void
	{
		trace("strlingRoot.start");
		
		//list all controllers
		
		var _viewGlobal:ViewBase = new ViewGlobal();
		var _viewHome:ViewBase = new ViewHome();
		var _viewGame:ViewBase = new ViewGame();
		var _viewEnd:ViewBase = new ViewEnd();
		
		MVCRoot.openflstage = _openflstage;
		
		MVCRoot.add(ControllerGlobal, _viewGlobal, "screen_global");
		MVCRoot.add(ControllerHome, _viewHome, "screen_home");
		MVCRoot.add(ControllerGame, _viewGame, "screen_game");
		MVCRoot.add(ControllerEnd, _viewEnd, "screen_end");
		
		LayoutManager.update();
		
		//ScreenBlink.init(_openflstage, this);
		
		//____________________________________________________________________________
		//navigation
		
		Navigation.DEFAULT_EASING_SHOW = Back.easeOut;
		
		Navigation.addScreen("", "screen_home", [
			new NavigationDef("zone_top", NavigationDef.DOWN, 0.3, 400, true, 0.5),
			new NavigationDef("footer", NavigationDef.DOWN, 0, 550, false, 0.5),
		],
		[
			new NavigationDef("footer", NavigationDef.DOWN, 0.25, 550, false, 0.25),
			new NavigationDef("zone_top", NavigationDef.DOWN, 0.15, 300, true, 0.25),
		]);
		
		//Navigation.addScreen("", "screen_game", null, null);
		//Navigation.addScreen("", "screen_end", null, null);
		
		//Navigation.addItem("header_title1", null, [], new NavigationDef("", NavigationDef.TOP, 0.0, 300, false, 0.25), null);
		
		
		
		Navigation.addCallback("", "all", Navigation.CALLBACK_GOTO, onGotoAllScreen);
		Navigation.addCallback("", "all", Navigation.CALLBACK_GOTO_TRANSITION, onGotoAllScreenTransition);
		Navigation.DEBUG = Constants.DEBUG_MODE || Constants.DEBUG_NAVIGATION || Constants.LOCALHOST;
		
		Navigation.init("", "screen_home", _openflstage, this);
		
		
		SoundManager.SOUND_ENABLED = true;
		cast(_viewGlobal, ViewGlobal).updateBtnSound(SoundManager.SOUND_ENABLED);
		
	}
	
	
	
	
	
	private function onEnterframe(e:Event):Void 
	{
		ActionDispatcher.dispatch("enterframe");
	}
	
	
	
	

	function onGotoAllScreenTransition(_prevscreen:String, _curscreen:String)
	{
		//trace("onGotoAllScreenTransition(" + _prevscreen + ", " + _curscreen + ")");
		if (MVCRoot.isController(_curscreen))
		{
			MVCRoot.getController(_curscreen).update();
		}
		if (MVCRoot.isController(_prevscreen))
		{
			MVCRoot.getController(_prevscreen).leaveScreen();
		}
		
		//sounds navigation
		//...
		
	}

	private function onGotoAllScreen(_prevscreen:String, _curscreen:String)
	{
		//trace("onGotoAllScreen(" + _prevscreen + ", " + _curscreen + ")");
		
		
		if (MVCRoot.isController(_curscreen))
		{
			//trace("getcontroller : " + _curscreen);
			MVCRoot.getController(_curscreen).preupdate();
		}
		
		if (MVCRoot.isController(_prevscreen))
		{
			//trace("getcontroller : " + _prevscreen);
			MVCRoot.getController(_prevscreen).preLeaveScreen();
		}
		
		//sounds navigation
		//screen blink...
		
	}
	
	
	function onExternalStart() 
	{
		trace("StarlingRoot.onExternalStart");
		
		var ctrl:ControllerBase = MVCRoot.getController("screen_global", false);
		//trace("ctrl : " + ctrl);
		if (ctrl != null){
			cast(ctrl, ControllerGlobal).startApp();
		}
		
	}

}