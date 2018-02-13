package com.vinc.debug;
import com.vinc.patterns.ActionDispatcher;
import haxe.Constraints.Function;
import haxe.Json;
import js.Lib;
import js.html.Storage;
import openfl.display.Stage;
import openfl.events.KeyboardEvent;
import openfl.ui.Keyboard;

/**
 * ...
 * @author Vincent Huss
 */
class ActionRecorder 
{
	private static var _items:Array<Dynamic>;
	
	private static inline var NB_SLOT:Int = 5;
	private static inline var SLOT_BASE:Int = Keyboard.NUMBER_1;
	
	private static var _shift:Bool;
	private static var _storage:Storage;
	
	private static var _preloadSlot:Int = -1;
	private static var _started:Bool = false;
	private static var _resetFunction:Function;
	
	
	
	public function new() 
	{
		
	}
	
	public static function init(stage:Stage, storage:Storage):Void
	{
		_shift = false;
		_items = [];
		_storage = storage;
		
		stage.addEventListener(KeyboardEvent.KEY_UP, onKeyup);
		stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeydown);
		
		ActionDispatcher.listenGlobal(onActionDispatch);
		
		
		
	}
	
	public static function start(resetFunction:Function):Void
	{
		_resetFunction = resetFunction;
		_started = true;
		
		trace("AR.start, preloadSlot : " + _preloadSlot);
		if (_preloadSlot != -1){
			loadSlot(_preloadSlot);
		}
	}
	
	
	static private function onKeydown(e:KeyboardEvent):Void 
	{
		//trace("onkeydown");
		if (e.keyCode == Keyboard.SHIFT) _shift = true;
	}
	
	static private function onKeyup(e:KeyboardEvent):Void 
	{
		trace("onKeyup "+e.keyCode);
		if (e.keyCode == Keyboard.SHIFT) _shift = false;
		else if(e.keyCode >= SLOT_BASE && e.keyCode < Keyboard.NUMBER_1 + NB_SLOT){
			
			var _indexSlot:Int = e.keyCode - SLOT_BASE;
			//trace("_indexSlot : " + _indexSlot + ", shift : " + _shift);
			
			if (_shift) saveSlot(_indexSlot);
			else{
				if (!_started) _preloadSlot = _indexSlot;
				else loadSlot(_indexSlot);
			}
			
		}
		else if (e.keyCode == Keyboard.NUMBER_0){
			skipTime(50);
		}
		else if (e.keyCode == Keyboard.NUMBER_9){
			skipTime(25);
		}
	}
	
	static private function skipTime(len:Int) 
	{
		for (i in 0...len){
			ActionDispatcher.dispatch("enterframe", null, true);
		}
	}
	
	static private function loadSlot(_index:Int) 
	{
		trace("loadSlot(" + _index + ")");
		
		var key:String = getKeyStorage(_index);
		var str:String = _storage.getItem(key);
		//trace("str : " + str);
		
		if (str == null || str == "") return;
		
		var _list:Array<Dynamic> = Json.parse(str);
		//Lib.debug();
		_items = [];
		
		_resetFunction();
		
		var _len:Int = _list.length;
		for (i in 0..._len){
			var obj:Dynamic = _list[i];
			var obj2:Dynamic;
			var _isStr:Bool = true;	//todo, object
			if (_isStr) obj2 = {t:obj};
			else obj2 = obj;
			
			if (obj2.t == "e") obj2.t = "enterframe";
			
			ActionDispatcher.dispatch(obj2.t, obj2.p, true);
			
		}
		
		
		//si hit avant l'init, on save pour executer a l'init
		//sinn, on execute tout de suite, 
		//on reset avant?
		
	}
	
	static private function saveSlot(_index:Int) 
	{
		trace("saveSlot(" + _index + ")");
		
		var key:String = getKeyStorage(_index);
		var str:String = Json.stringify(_items);
		_storage.setItem(key, str);
		//Lib.debug();
		
		
	}
	
	static private function getKeyStorage(_index:Int) 
	{
		return "AR_" + _index;
	}
	
	
	static private function onActionDispatch(type:String, params:Dynamic = null) 
	{
		//trace("AR.onActionDispatch " + type+", " + params);
		
		//optimisation
		if (type == "enterframe") type = "e";
		
		var obj:Dynamic;
		if (params == null){
			obj = type;
		}
		else{
			obj = {t:type, p:params};
		}
		
		_items.push(obj);
		
	}
}