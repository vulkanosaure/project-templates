package com.vinc.navigation;

import com.vinc.common.ObjectSearch;
import com.vinc.layout.LayoutSprite;
import com.vinc.time.DelayManager;
import motion.Actuate;
import motion.easing.IEasing;
import motion.easing.Sine;
import openfl.errors.Error;
import starling.display.Sprite;
import openfl.display.Stage;
import openfl.events.KeyboardEvent;
import openfl.utils.Object;
//
class NavigationInstance {
	
	static private inline var GROUP:String = "navigationGroup";
	
	
	private var _locked:Bool = false;
	private var _data:Object;
	private var _dataItem:Object;
	
	public var curscreen(get,null):String = "";
	public var prevscreen(get,null):String = "";
	
	private var _delay:Float;
	private var _listid:Array<String>;
	
	private var _listCallbackGoto:Object;
	private var _listCallbackGotoTransition:Object;
	private var _listCallbackQuit:Object;
	private var _idgroup:String;
	private var _listItemOut:Array<Object>;
	private var _listItemIn:Array<Object>;
	
	
	
	
	public function new(__idgroup:String) 
	{
		_idgroup = __idgroup;
	}
	
	
	public function addScreen(_idscreen:String, _listDefIn:Array<NavigationDef>, _listDefOut:Array<NavigationDef>, _delay:Float, _tabID:Array<String>):Void
	{
		for (_item in _listDefIn) cast(_item, NavigationDef).value = true;
		for (_item in _listDefOut) cast(_item, NavigationDef).value = false;
		
		if (_data == null) _data = new Object();
		if (_listid == null) _listid = new Array();
		
		var _obj:Object = new Object();
		_obj.idscreen = _idscreen;
		_obj.listDefIn = _listDefIn;
		_obj.listDefOut = _listDefOut;
		_obj.delay = _delay;
		if (_tabID == null) _tabID = [_idscreen];
		_obj.tabID = _tabID;
		
		_data[_idscreen] = _obj;
		_listid.push(_idscreen);
		
	}
	
	
	public function addItem(_iditem:String, _tabInclude:Array<String>, _tabExclude:Array<String>, _defIn:NavigationDef, _defOut:NavigationDef):Void 
	{
		if (_dataItem == null) _dataItem = new Object();
		_defIn.value = true;
		_defOut.value = false;
		
		var _obj:Object = new Object();
		_obj.iditem = _iditem;
		_obj.defIn = _defIn;
		_obj.defOut = _defOut;
		_obj.tabInclude = _tabInclude;
		_obj.tabExclude = _tabExclude;
		_dataItem[_iditem] = _obj;
		
	}
	
	
	public function addCallback(_idscreen:String, _type:String, _func:String->String->Void):Void 
	{
		if (_listCallbackQuit == null) _listCallbackQuit = new Object();
		if (_listCallbackGoto == null) _listCallbackGoto = new Object();
		if (_listCallbackGotoTransition == null) _listCallbackGotoTransition = new Object();
		
		var _obj:Object;
		if (_type == Navigation.CALLBACK_GOTO) _obj = _listCallbackGoto;
		else if (_type == Navigation.CALLBACK_QUIT) _obj = _listCallbackQuit;
		else if (_type == Navigation.CALLBACK_GOTO_TRANSITION) _obj = _listCallbackGotoTransition;
		else throw new Error("wrong type of callback");
		
		if (_idscreen == "") _idscreen = "all";
		
		if (_obj[_idscreen] == null) _obj[_idscreen] = [];
		_obj[_idscreen].push(_func);
		
	}
	
	
	
	
	private function onKeydown(e:KeyboardEvent):Void 
	{
		//trace("NavigationInstance.onKeydown " + e.keyCode);
		if (e.keyCode >= 96 && e.keyCode <= 105) {
			var _index:Int = e.keyCode - 96;
			if (_index > _listid.length - 1) return;
			var _idscreen:String = _listid[_index];
			
			this.gotoScreen(_idscreen);
			
		}
		
	}
	
	
	public function init(_screeninit:String, _stage:Stage, _debug:Bool):Void
	{
		setAllScreenVisible(false);
		
		
		
		var _nbscreen:Int = _listid.length;
		
		for (_key in _dataItem) 
		{
			var _obj:Object = _dataItem[_key];
			
			if (_obj["tabInclude"] == null) {
				var _tabExclude:Array<String> = _obj["tabExclude"];
				var _tabInclude:Array<String> = [];
				for (i in 0..._nbscreen) 
				{
					var _sc:String = _listid[i];
					if (_tabExclude.indexOf(_sc) == -1) {
						_tabInclude.push(_sc);
					}
				}
				trace("_tabexclude : " + _tabExclude);
				trace("_tabinclude : " + _tabInclude);
				_obj["tabInclude"] = _tabInclude;
			}
		}
		
		/*
		curscreen = _screeninit;
		setAllScreenVisible(false);
		setItemVisible(curscreen, true);
		*/
		
		
		if (_debug) {
			trace("addKeyboardEvent");
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeydown);
			
		}
		
		for (_key in _dataItem) 
		{
			var _item:Object = _dataItem[_key];
			var _id:String = _item.iditem;
			setItemVisible(_id, false);
			
		}
		
		gotoScreen(_screeninit);
	}
	
	
	
	public function gotoPrevScreen():Void
	{
		if (prevscreen != "") {
			gotoScreen(prevscreen);
		}
	}
	
	
	
	public function gotoScreen(_idscreen:String, _delayLock:Float = 1500):Void
	{
		/*
		if (_locked) {
			//trace("return _locked");
			return;
		}
		*/
		
		trace("NavigationInstance.gotoScreen(" + _idscreen + ", currscreen : " + curscreen);
		
		if (curscreen == _idscreen) {
			//trace("return ==");
			return;
		}
		
		//todo : il faudrait reset uniquement pour le _idscreen en question
		DelayManager.resetGroup(GROUP + _idgroup);
		
		
		_delay = 0;
		
		_locked = true;
		DelayManager.add(GROUP + _idgroup, _delayLock, function():Void {
			_locked = false;
		});
		
		
		if (_listItemOut == null) _listItemOut = new Array();
		if (_listItemIn == null) _listItemIn = new Array();
		_listItemOut.splice(0, 1);
		_listItemIn.splice(0, 1);
		
		var _list:Array<Object>;
		
		_list = getItemByScreen(curscreen);
		for (i in 0..._list.length) 
		{
			var _obj:Object = _list[i];
			if (!isItemOnScreen(_obj, _idscreen)) {
				trace("- out " + _obj.iditem);
				_listItemOut.push(_obj);
			}
		}
		
		var _list:Array<Object> = getItemByScreen(_idscreen);
		for (i in 0..._list.length) 
		{
			var _obj:Object = _list[i];
			if (!isItemOnScreen(_obj, curscreen)) {
				trace("- in " + _obj.iditem);
				_listItemIn.push(_obj);
			}
		}
		
		
		
		//_____________________________________________
		
		trace("curscreen : " + curscreen);
		if (curscreen != "") {
			showScreen(curscreen, false);
			
			showItems(_listItemOut, false);
			
			_delay += getLastTimeAnim(curscreen, _listItemOut);
			
			var _obj:Object = _data[_idscreen];
			_delay += _obj.delay;
			
		}
		
		
		DelayManager.add(GROUP + _idgroup, _delay * 1000, function(_prevscreen:String):Void {
			
			setAllScreenVisible(false);
			if (_idscreen != "") {
				setScreenVisible(_idscreen, true);
			}
			
			if (_listCallbackGotoTransition != null && (_listCallbackGotoTransition[_idscreen] != null || _listCallbackGotoTransition["all"] != null)) {
				
				var _tab:Array<String->String->Void> = _listCallbackGotoTransition[_idscreen];
				if (_tab == null) _tab = _listCallbackGotoTransition["all"];
				for (j in 0..._tab.length) _tab[j](_prevscreen, _idscreen);
			}
			
		}, [curscreen]);
		
		showItems(_listItemIn, true);
		
		if (_idscreen != "") showScreen(_idscreen, true);
		
		
		
		//callback
		
		
		if (_listCallbackQuit != null && (_listCallbackQuit[curscreen] != null || _listCallbackQuit["all"] != null)) {
			var _tab:Array<String->String->Void> = _listCallbackQuit[curscreen];
			if (_tab == null) _tab = _listCallbackQuit["all"];
			for (j in 0..._tab.length) _tab[j](prevscreen, _idscreen);
		}
		
		
		prevscreen = curscreen;
		curscreen = _idscreen;
		
		if (_listCallbackGoto != null && (_listCallbackGoto[_idscreen] != null || _listCallbackGoto["all"] != null)) {
			var _tab:Array<String->String->Void> = _listCallbackGoto[_idscreen];
			if (_tab == null) _tab = _listCallbackGoto["all"];
			for (j in 0..._tab.length) _tab[j](prevscreen, _idscreen);
		}
		
	}
	
	
	
	
	private function isItemOnScreen(_objitem:Object, _idscreen:String):Bool
	{
		var _listInclude:Array<String> = _objitem["tabInclude"];
		return _listInclude.indexOf(_idscreen) != -1;
	}
		
		
	
	private function getItemByScreen(_idscreen:String):Array<Object>
	{
		var _output:Array<Object> = [];
		for (_key in _dataItem) 
		{
			var _obj:Object = _dataItem[_key];
			var _tabInclude:Array<String> = _obj["tabInclude"];
			if (_tabInclude.indexOf(_idscreen) != -1) {
				_output.push(_obj);
			}
		}
		return _output;
	}
	
	
	
	
	private function getLastTimeAnim(_id:String, _listitem:Array<Object>):Float
	{
		var _value:Bool = false;
		if (_listitem.length > 0) {
			var _lastindex:Int = _listitem.length - 1;
			var _obj:Object = _listitem[_lastindex];
			var _def:NavigationDef = (_value) ? cast(_obj["defIn"], NavigationDef) : cast(_obj["defOut"], NavigationDef);
			return _def.time;
		}
		else {
			var _obj:Object = _data[_id];
			var _list:Array<NavigationDef> = (_value) ? _obj["listDefIn"] : _obj["listDefOut"];
			var _lastindex:Int = _list.length - 1;
			if (_lastindex >= 0) {
				var _def:NavigationDef = cast(_list[_lastindex], NavigationDef);
				return _def.time;
			}
			else return 0;
			
		}
	}
	
	
	
	private function showScreen(_id:String, _value:Bool):Void
	{
		var _obj:Object = _data[_id];
		if (_obj == null) throw new Error("screen id '" + _id + "' doesn't exist");
		var _list:Array<NavigationDef> = (_value) ? _obj["listDefIn"] : _obj["listDefOut"];
		
		var _len:Int = _list.length;
		for (i in 0..._len) 
		{
			var _def:NavigationDef = cast(_list[i], NavigationDef);
			var _time:Float = (_def.time == null) ? 0.6 : _def.time;
			animate(_def.id, _def.value, _def.side, _delay, _def.dist, _def.fade, _time, _def.easing);
			_delay += _def.delay;
		}
		
	}
	
	private function showItems(_listitem:Array<Object>, _value:Bool):Void 
	{
		var _len:Int = _listitem.length;
		for (i in 0..._len) 
		{
			var _obj:Object = _listitem[i];
			var _def:NavigationDef = (_value) ? cast(_obj["defIn"], NavigationDef) : cast(_obj["defOut"], NavigationDef);
			//trace("animate(" + _def.id + ", " + _def.value + ", " + _def.side + ", " + _delay + ")");
			animate(_def.id, _def.value, _def.side, _delay, _def.dist, _def.fade, _def.time, _def.easing);
			_delay += _def.delay;
			
		}
	}
	
	
	
	
	private function setAllScreenVisible(_value:Bool):Void
	{
		var _len:Int = _listid.length;
		for (i in 0..._len)
		{
			var _id:String = _listid[i];
			setScreenVisible(_id, _value);
		}
	}
	
	private function setScreenVisible(_id:String, _value:Bool) :Void
	{
		var _obj:Object = _data[_id];
		var _tabID:Array<String> = _obj.tabID;
		var _len:Int = _tabID.length;
		for (i in 0..._len) 
		{
			setItemVisible(_tabID[i], _value);
		}
	}
	
	
	private function setItemVisible(_id:String, _value:Bool):Void
	{
		var _obj:Sprite = cast(ObjectSearch.getID(_id), Sprite);
		_obj.visible = _value;
	}
	
	
	private function setItemTouchable(_id:String, _value:Bool):Void
	{
		var _obj:Sprite = cast(ObjectSearch.getID(_id), Sprite);
		_obj.touchable = _value;
	}
	
	
	public function animateNoAnim(__obj:Dynamic, _value:Bool):Void
	{
		
		var _obj:Sprite;
		if (Std.is(__obj, Sprite)) _obj = __obj;
		else _obj = cast(ObjectSearch.getID(__obj), Sprite);
		
		_obj.visible = _value;
		_obj = cast(_obj.getChildAt(0), Sprite);
		_obj.visible = _value;
		if (_value) _obj.alpha = 1.0;
		
	}
	
	
	
	
	public function animate(__obj:Dynamic, _value:Bool, _side:String, _d:Float, __distslide:Float = 700, _fade:Bool = false, __timeAnim:Float = 0.6, __easing:IEasing = null):Void 
	{
		trace("animate(" + __obj + ", " + _value+", " + _side+", " + _d + ", " + __distslide+", " + _fade+", " + __timeAnim + ")");
		var _obj:Sprite;
		if (Std.is(__obj, Sprite)) {
			_obj = __obj;
		}
		else {
			//_obj = cast(ObjectSearch.getID(__obj), Sprite);
			_obj = ObjectSearch.getID(__obj);
		}
		
		if (_value && !_obj.visible) _obj.visible = true;
		//_obj = cast(_obj.getChildAt(0), Sprite);
		
		var _timeanim:Float = __timeAnim;
		//trace("_timeanim : " + _timeanim);
		
		if (_fade) {
			var _alphasrc:Float = (_value) ? 0 : 1;
			var _alphadest:Float = (_value) ? 1 : 0;
			_obj.alpha = _alphasrc;
			//_twm.tween(_obj, "alpha", NaN, _alphadest, _timeanim, _d);
			Actuate.tween(_obj, _timeanim, { alpha : _alphadest } ).delay(_d);
		}
		
		
		var _easing:IEasing = null;
		if (__easing != null) _easing = __easing;
		else if (_value && Navigation.DEFAULT_EASING_SHOW != null) _easing = Navigation.DEFAULT_EASING_SHOW;
		else _easing = Sine.easeOut;
		
		
		if (_side == NavigationDef.ZOOM) {
			
			var _src:Float;
			var _dst:Float;
			
			if (_value) {
				_src = 0;
				_dst = 1;
			}
			else {
				_src = 1;
				_dst = 0;
			}
			
			_obj.scaleX = _src;
			_obj.scaleY = _src;
			/*
			_twm.tween(_obj, "scaleX", _src, _dst, _timeanim, _d, _easing);
			_twm.tween(_obj, "scaleY", _src, _dst, _timeanim, _d, _easing);
			*/
			Actuate.tween(_obj, _timeanim, { scaleX : _dst, scaleY : _dst } ).ease(_easing).delay(_d);
		}
		
		else if (_side != NavigationDef.NONE) {
			var _distslide:Float = __distslide;
			var _prop:String = (_side == NavigationDef.LEFT || _side == NavigationDef.RIGHT) ? "x" : "y";
			var _src:Float;
			var _dst:Float;
			
			if (_value) {
				_src = (_side == NavigationDef.LEFT || _side == NavigationDef.TOP) ? -_distslide : _distslide;
				_dst = 0;
			}
			else {
				_src = 0;
				_dst = (_side == NavigationDef.LEFT || _side == NavigationDef.TOP) ? -_distslide : _distslide; 
			}
			
			if (Std.is(_obj, LayoutSprite)) {
				var _ls:LayoutSprite = cast(_obj, LayoutSprite);
				if (_ls.layoutPosition != null) {
					_src += Reflect.getProperty(_ls.layoutPosition, _prop);
					_dst += Reflect.getProperty(_ls.layoutPosition, _prop);
				}
			}
			
			
			Reflect.setProperty(_obj, _prop, _src);
			
			var _properties:Object = new Object();
			_properties[_prop] = _dst;
			Actuate.tween(_obj, _timeanim, _properties).delay(_d).ease(_easing);
			
		}
	}
	
	
	
	
	public function get_curscreen():String 
	{
		return curscreen;
	}
	
	public function get_prevscreen():String 
	{
		return prevscreen;
	}
	
	
	
	
	
}