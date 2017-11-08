package com.vinc.navigation;

import com.vinc.common.ObjectSearch;
import com.vinc.time.DelayManager;
import motion.easing.IEasing;
import openfl.display.Stage;
import starling.display.DisplayObjectContainer;
import openfl.utils.Object;
import starling.display.Sprite;
import starling.events.Event;
/**
 * ...
 * @author Vinc
 */
class Navigation 
{
	
	static public inline var CALLBACK_GOTO:String = "callbackGoto";
	static public inline var CALLBACK_QUIT:String = "callbackQuit";
	static public inline var CALLBACK_GOTO_TRANSITION:String = "callbackGotoTransition";
	static public var DEBUG:Bool = false;
	
	static private inline var GROUP:String = "navigationGroup";
	static public inline var GROUP_NO_RESET:String = "navigationGroupNoReset";
	static public var DEFAULT_EASING_SHOW:IEasing = null;
	
	private static var _listClickableConflicts:Array<Dynamic>;
	
	private static inline var ROOT_NAME:String = "root_elmt";
	private static var _instances:Object;
	static private var _stage:Stage;
	static private var _itemroot:DisplayObjectContainer;
	
	
	
	
	
	public function new() 
	{
		
	} 
	
	
	public static function addScreen(_screenparent:String, _idscreen:String, _listDefIn:Array<NavigationDef>, _listDefOut:Array<NavigationDef>, _delay:Float = 0, _tabID:Array<String> = null):Void
	{
		
		var _instance:NavigationInstance = getInstance(_screenparent);
		_instance.addScreen(_idscreen, _listDefIn, _listDefOut, _delay, _tabID);
		
	}
	
	
	
	static public function addItem(_iditem:String, _tabInclude:Array<String>, _tabExclude:Array<String>, _defIn:NavigationDef, _defOut:NavigationDef):Void 
	{
		if (_defOut == null){
			_defOut = new NavigationDef("", _defIn.side, _defIn.delay, _defIn.dist, _defIn.fade, _defIn.time, _defIn.easing);
		}
		
		var _instanceMain:NavigationInstance = getInstance(ROOT_NAME);
		_instanceMain.addItem(_iditem, _tabInclude, _tabExclude, _defIn, _defOut);
		
	}
	
	
	static public function addCallback(_screenparent:String, _idscreen:String, _type:String, _func:String->String->Void):Void 
	{
		var _instance:NavigationInstance = getInstance(_screenparent);
		_instance.addCallback(_idscreen, _type, _func);
	}
	
	
	
	
	//______________________________________
	
	static public function addClickableConflict(_idbtn:String, _idgroup:String = "", _lockall:Bool = false):Void 
	{
		if (_listClickableConflicts == null) _listClickableConflicts = new Array();
		var _btn:Sprite = cast(ObjectSearch.getID(_idbtn), Sprite);
		var _group:Sprite = null;
		if (_idgroup != "") {
			_group = cast(ObjectSearch.getID(_idgroup), Sprite);
		}
		
		_listClickableConflicts.push([_btn, _group, _lockall]);
		_btn.addEventListener(Event.TRIGGERED, onClickBtnConflict);
		
	}
	
	static private function onClickBtnConflict(e:Event):Void 
	{
		var _sp:Sprite = cast(e.currentTarget, Sprite);
		
		var _tab:Array<Dynamic> = getTabConflict(_sp);
		
		if (_tab[1] != null) cast(_tab[1], Sprite).touchable = false;
		_sp.touchable = false;
		
		if (_tab[2]) {
			_itemroot.touchable = false;
			trace("lock stage");
		}
		
		
		
		DelayManager.add(GROUP_NO_RESET, 1500, function():Void {
			_sp.touchable = true;
			if (_tab[1] != null) cast(_tab[1], Sprite).touchable = true;
			if (_tab[2]) {
				_itemroot.touchable = true;
			}
		});
	}
	
	static private function getTabConflict(sp:Sprite):Array<Dynamic>
	{
		var _len:Int = _listClickableConflicts.length;
		
		for (i in 0..._len) 
		{
			var _tab:Array<Dynamic> = _listClickableConflicts[i];
			if (_tab[0] == sp) return _tab;
		}
		return null;
	}  
	//_________________________________________
	
	
	
	
	
	public static function init(_screenparent:String, _screeninit:String, __stage:Stage, __itemroot:DisplayObjectContainer):Void
	{
		_stage = __stage;
		_itemroot = __itemroot;
		var _instance:NavigationInstance = getInstance(_screenparent);
		var _isMain:Bool = (_screenparent == "");
		
		_instance.init(_screeninit, _stage, (_isMain && DEBUG));
		
	}
	
	private static function getInstance(_screenparent:String):NavigationInstance 
	{
		var _instance:NavigationInstance;
		
		if (_screenparent == "") _screenparent = ROOT_NAME;
		if (_instances == null) _instances = new Object();
		
		
		if (_instances[_screenparent] == null) {
			_instance = new NavigationInstance(_screenparent);
			_instances[_screenparent] = _instance;
		}
		else {
			_instance = cast(_instances[_screenparent], NavigationInstance);
		}
		
		
		return _instance;
	}
	
	
	public static function gotoPrevScreen():Void
	{
		var _instanceMain:NavigationInstance = getInstance(ROOT_NAME);
		_instanceMain.gotoPrevScreen();
		
	}
	
	
	
	public static function gotoScreen(_screenparent:String, _idscreen:String, _delayLock:Float = 1500, _noAnim:Bool = false):Void
	{
		trace("gotoScreen(" + _screenparent + ", " + _idscreen + ")");
		var _instance:NavigationInstance = getInstance(_screenparent);
		_instance.gotoScreen(_idscreen, _delayLock, _noAnim);
	}
	
	
	
	
	static public function getCurscreen(_screenparent:String):String 
	{
		var _instance:NavigationInstance = getInstance(_screenparent);
		return _instance.curscreen;
	}
	
	
	static public function getPrevscreen(_screenparent:String):String 
	{
		var _instance:NavigationInstance = getInstance(_screenparent);
		return _instance.prevscreen;
	}
	
	
	
}