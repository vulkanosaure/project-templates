package;
import com.vinc.common.ObjectSearch;
import com.vinc.display.VImage;
import com.vinc.layout.LayoutManager;
import com.vinc.layout.LayoutSprite;
import com.vinc.mvc.MVCRoot;
import com.vinc.mvc.ViewBase;
import com.vinc.navigation.Navigation;
import com.vinc.navigation.NavigationDef;
import com.vinc.time.DelayManager;
import controllers.ControllerEnd;
import controllers.ControllerGame;
import controllers.ControllerHome;
import motion.easing.Back;
import openfl.display.Stage;
import openfl.geom.Point;
import openfl.ui.Keyboard;
import openfl.utils.Object;
import starling.core.Starling;
import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.KeyboardEvent;
import starling.utils.AssetManager;
import com.vinc.display.VButton;
import ui.VButton1;
import view.ViewEnd;
import view.ViewGame;
import view.ViewHome;
import view.ViewLoader;


/**
 * ...
 * @author Vincent Huss
 */
class StarlingRoot extends Sprite
{

	public function new() 
	{
		super();
	}
	
	
	public function start(_openflstage:Stage, __starling:Starling):Void
    {
        if (Constants.DEBUG_MODE) {
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKey);
		}
		
		Vars.starlingStage = __starling.stage;
		Vars.openflstage = _openflstage;
		
		Vars.containerBG = new Sprite();
		addChild(Vars.containerBG);
		
		Vars.containerFG = new Sprite();
		addChild(Vars.containerFG);
		
		
		
		LayoutManager.init(__starling, new Point(Constants.GAME_WIDTH, Constants.GAME_HEIGHT));
		
		LayoutManager.addContainer(Vars.containerBG, LayoutManager.NO_BORDER);
		LayoutManager.addContainer(Vars.containerFG, LayoutManager.SHOW_ALL);
		
		
		
		var _containerGame:LayoutSprite = new LayoutSprite();
		ObjectSearch.registerID(_containerGame, "containerGame");
		Vars.containerBG.addChild(_containerGame);
		LayoutManager.addItem(_containerGame, { "width" : Constants.GAME_WIDTH, "height" : Constants.GAME_HEIGHT, "center-v":0.7, "center-h":0.5 } );
		
		var _bg:VImage = new VImage("game/bg0");
		_bg.name = "bg0";
		_containerGame.addChild(_bg);
		
		//_bg.visible = false;
		
		
		
		
		//list all controllers
		
		
		var _viewLoader:ViewBase = new ViewLoader();
		_viewLoader.construct();
		
		var _viewHome:ViewBase = new ViewHome();
		var _viewGame:ViewBase = new ViewGame();
		var _viewEnd:ViewBase = new ViewEnd();
		
		MVCRoot.openflstage = _openflstage;
		MVCRoot.add(ControllerHome, _viewHome, "screen_home");
		MVCRoot.add(ControllerGame, _viewGame, "screen_game");
		MVCRoot.add(ControllerEnd, _viewEnd, "screen_end");
		
		
		
		
		LayoutManager.ready();
		
		//ScreenBlink.init(_openflstage, this);
		
		
		
		
		
		//____________________________________________________________________________
		//navigation
		
		//Navigation.DEFAULT_EASING_SHOW = Animation.easeOut;
		
		
		
		Navigation.addScreen("", "screen_loader", [
		],
		[
		], 0, ["screen_loader", "screen_loader_fg"]);
		
		Navigation.addScreen("", "screen_home", [
		],
		[
		], 0.35);
		
		
		Navigation.addScreen("", "screen_game", [
		],
		[
		], 0.35, ["screen_game"]);
		
		
		Navigation.addScreen("", "screen_end", [
			/*
			new NavigationDef("screen_end_title", NavigationDef.DOWN, 0.75, 80, true, 0.3, Back.easeOut),
			new NavigationDef("screen_end_table", NavigationDef.DOWN, 0.5, 600, true, 0.3),
			*/
		],
		[
		]);
		
		
		
		Navigation.addCallback("", "all", Navigation.CALLBACK_GOTO, onGotoAllScreen );
		Navigation.addCallback("", "all", Navigation.CALLBACK_GOTO_TRANSITION, onGotoAllScreenTransition );
		
		Navigation.DEBUG = Constants.DEBUG_MODE || Constants.DEBUG_NAVIGATION;
		
		
		
		//cheat, faire un vrai
		
		var _screeninit:String = "screen_loader";
		Navigation.init("", _screeninit, _openflstage, this);
		
		DelayManager.add("", 1300, function():Void
		{
			Navigation.gotoScreen("", "screen_home");
		});
		
		
		
	}
	
	
	
	
	
	function onGotoAllScreenTransition(_prevscreen:String, _curscreen:String) 
	{
		//trace("onGotoAllScreenTransition(" + _prevscreen + ", " + _curscreen + ")");
		if (MVCRoot.isController(_curscreen)) {
			//trace("getcontroller : " + _curscreen);
			MVCRoot.getController(_curscreen).update();
		}
		if (MVCRoot.isController(_prevscreen)) {
			//trace("getcontroller : " + _prevscreen);
			MVCRoot.getController(_prevscreen).leaveScreen();
		}
		
		
		
		//sounds navigation
		//...
		
		
	}
	
	
	private function onGotoAllScreen(_prevscreen:String, _curscreen:String) 
	{
		//trace("onGotoAllScreen(" + _prevscreen + ", " + _curscreen + ")");
		
		
		if (MVCRoot.isController(_prevscreen)) {
			//trace("getcontroller : " + _prevscreen);
			MVCRoot.getController(_prevscreen).preLeaveScreen();
		}
		
		//sounds navigation
		//screen blink...
		
	}
	
	
	
	
    private function onKey(event:KeyboardEvent):Void
    {
        if (event.keyCode == Keyboard.SPACE)
            Starling.current.showStats = !Starling.current.showStats;
        else if (event.keyCode == Keyboard.X)
            Starling.current.context.dispose();
    }
	
	
}