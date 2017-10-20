package;
import com.vinc.common.ObjectSearch;
import com.vinc.display.VImage;
import com.vinc.fx.ScreenBlink;
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
import controllers.ControllerInput;
import controllers.ControllerRanking;
import motion.easing.Back;
import openfl.display.Stage;
import openfl.geom.Point;
import openfl.ui.Keyboard;
import openfl.utils.Object;
import ru.stablex.ui.UIBuilder;
import starling.core.Starling;
import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.KeyboardEvent;
import starling.utils.AssetManager;
import com.vinc.display.VButton;
import ui.GameButton;
import view.ViewEnd;
import view.ViewGame;
import view.ViewHome;
import view.ViewInput;
import view.ViewLoader;
import view.ViewRanking;


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
		/*
		Toolkit.init();
		Toolkit.openFullscreen(function(root:Root):Void {
			Vars.haxeuiRoot = root;
		});
		*/
		
		UIBuilder.init();
        
        //addEventListener(Event.TRIGGERED, onButtonTriggered);
        this.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKey);
		
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
		LayoutManager.addItem(_containerGame, { "width" : 480, "height" : 800, "center-v":0.7, "center-h":0.5 } );
		
		var _bg:VImage = new VImage("game/bg0");
		_bg.name = "bg0";
		_containerGame.addChild(_bg);
		
		_bg = new VImage("game/bg1");
		_bg.name = "bg1";
		_containerGame.addChild(_bg);
		//_bg.visible = false;
		
		
		
		
		var _viewLoader:ViewBase = new ViewLoader();
		_viewLoader.construct();
		
		var _viewHome:ViewBase = new ViewHome();
		var _viewGame:ViewBase = new ViewGame();
		var _viewEnd:ViewBase = new ViewEnd();
		var _viewInput:ViewBase = new ViewInput();
		var _viewRanking:ViewBase = new ViewRanking();
		
		
		//automaticaly call controller / reset page
		//bind controller view a view ? or access all views globally
		//bind a controller with a screen name (navigation)
		
		MVCRoot.openflstage = _openflstage;
		MVCRoot.add(ControllerHome, _viewHome, "screen_home");
		MVCRoot.add(ControllerGame, _viewGame, "screen_game");
		MVCRoot.add(ControllerEnd, _viewEnd, "screen_end");
		MVCRoot.add(ControllerRanking, _viewRanking, "screen_ranking");
		MVCRoot.add(ControllerInput, _viewInput, "screen_input");
		
		
		LayoutManager.ready();
		
		
		
		
		ScreenBlink.init(_openflstage, this);
		
		
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
			new NavigationDef("screen_end_title", NavigationDef.DOWN, 0.75, 80, true, 0.3, Back.easeOut),
			new NavigationDef("screen_end_table", NavigationDef.DOWN, 0.5, 600, true, 0.3),
			new NavigationDef("screen_end_btn_replay", NavigationDef.NONE, 0.0, 0, true, 0.1),
			new NavigationDef("screen_end_btn_rank", NavigationDef.NONE, 0.0, 0, true, 0.1),
		],
		[
		]);
		
		Navigation.addScreen("", "screen_input", [
			
			new NavigationDef("input_bloctop", NavigationDef.DOWN, 0.4, 600, true, 0.4),
			new NavigationDef("input_buttons", NavigationDef.DOWN, 0.4, 600, true, 0.4),
		],
		[
			new NavigationDef("input_buttons", NavigationDef.DOWN, 0.2, 600, true, 0.6),
			new NavigationDef("input_bloctop", NavigationDef.DOWN, 0.0, 600, true, 0.6),
		]);
		
		Navigation.addScreen("", "screen_ranking", [
			new NavigationDef("ranking-top", NavigationDef.DOWN, 0.4, 600, true, 0.4),
			new NavigationDef("ranking-bottom", NavigationDef.DOWN, 0.4, 600, true, 0.4),
		],
		[
			new NavigationDef("ranking-bottom", NavigationDef.DOWN, 0.2, 600, true, 0.6),
			new NavigationDef("ranking-top", NavigationDef.DOWN, 0.0, 600, true, 0.6),
		]);
		
		
		Navigation.addCallback("", "all", Navigation.CALLBACK_GOTO, onGotoAllScreen );
		Navigation.addCallback("", "all", Navigation.CALLBACK_GOTO_TRANSITION, onGotoAllScreenTransition );
		
		
		/*
		Navigation.addItem("zone_help_corner", ["screen_game"], null, 
			new NavigationDef("zone_help_corner", NavigationDef.LEFT, 0.35),
			new NavigationDef("zone_help_corner", NavigationDef.LEFT, 0.1)
		);
		*/
		
		
		
		Navigation.DEBUG = Constants.DEBUG_MODE || Constants.DEBUG_NAVIGATION;
		
		//var _screeninit:String = (Constants.DEBUG_MODE) ? "screen_game" : "screen_loader";
		var _screeninit:String = "screen_loader";
		Navigation.init("", _screeninit, _openflstage, this);
		
		DelayManager.add("", 1300, function():Void
		{
			Navigation.gotoScreen("", "screen_home");
		});
		
		
		
		
		
		/*
		DelayManager.add("", 3000, function():Void {
			ScreenBlink.blink(0xffffff, 0.01, 0.0, 0.12);
		});
		*/
		
		
		
		
	}
	
	function onGotoAllScreenTransition(_prevscreen:String, _curscreen:String) 
	{
		trace("onGotoAllScreenTransition(" + _prevscreen + ", " + _curscreen + ")");
		if (MVCRoot.isController(_curscreen)) {
			//trace("getcontroller : " + _curscreen);
			MVCRoot.getController(_curscreen).update();
		}
		if (MVCRoot.isController(_prevscreen)) {
			//trace("getcontroller : " + _prevscreen);
			MVCRoot.getController(_prevscreen).leaveScreen();
		}
		
		
		
		//sounds navigation
		
		if (_curscreen == "screen_end") {
			Vars.assets.getSound("navigate").play();
			DelayManager.add("", 700, Vars.assets.getSound("navigate").play);
		}
		else if (_curscreen == "screen_ranking") {
			Vars.assets.getSound("navigate").play();
		}
		else if (_curscreen == "screen_input") {
			DelayManager.add("", 50, Vars.assets.getSound("navigate").play);
		}
		
	}
	
	private function onGotoAllScreen(_prevscreen:String, _curscreen:String) 
	{
		trace("onGotoAllScreen(" + _prevscreen + ", " + _curscreen + ")");
		
		
		if (MVCRoot.isController(_prevscreen)) {
			//trace("getcontroller : " + _prevscreen);
			MVCRoot.getController(_prevscreen).preLeaveScreen();
		}
		
		if (_curscreen == "screen_game" || _curscreen == "screen_home") {
			trace("blink");
			ScreenBlink.blink(0x000000, 0.35, 0.1, 0.25);
		}
		
		//sounds navigation
		if (_curscreen == "screen_game") {
			Vars.assets.getSound("navigate").play();
		}
		if (_curscreen == "screen_home" && _prevscreen == "screen_ranking") {
			Vars.assets.getSound("navigate").play();
		}
		if (_prevscreen == "screen_ranking" && _curscreen != "screen_home") {
			DelayManager.add("", 100, Vars.assets.getSound("navigate").play);
		}
		if (_prevscreen == "screen_input") {
			DelayManager.add("", 50, Vars.assets.getSound("navigate").play);
		}
	}
	
	
	
	
	
	
	
    private function onKey(event:KeyboardEvent):Void
    {
        if (event.keyCode == Keyboard.SPACE)
            Starling.current.showStats = !Starling.current.showStats;
        else if (event.keyCode == Keyboard.X)
            Starling.current.context.dispose();
    }
	
}