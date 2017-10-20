package com.vinc.mvc;
import openfl.display.Stage;
import openfl.errors.Error;
import openfl.utils.Object;

/**
 * ...
 * @author Vincent Huss
 */
class MVCRoot
{
	private static var _data:Object;
	public static var openflstage(default, set):Stage;

	public function new() 
	{
		
	}
	
	public static function add(_controllerClass:Class<Dynamic>, _view:ViewBase, _idscreen:String):Void
	{
		if (_data == null) _data = new Array();
		
		var _inst:Dynamic = Type.createEmptyInstance(_controllerClass);
		var _controller:ControllerBase = cast(_inst, ControllerBase);
		
		var _obj:Object = new Object();
		_obj.controller = _controller;
		_obj.view = _view;
		_obj.idscreen = _idscreen;
		
		_controller.idscreen = _idscreen;
		_controller.openflstage = openflstage;
		
		_data[_idscreen] = _obj;
		
		
		_view.construct();
		_controller.init();
		
	}
	
	static public function isController(_idscreen:String):Bool
	{
		return (_data[_idscreen] != null);
	}
	
	static public function getController(_idscreen:String) :ControllerBase
	{
		if (_data[_idscreen] == null) throw new Error("controller #"+_idscreen+" wasn't found");
		return cast(_data[_idscreen].controller, ControllerBase);
	}
	
	static public function getView(_idscreen:String):ViewBase
	{
		if (_data[_idscreen] == null) throw new Error("view #"+_idscreen+" wasn't found");
		return cast(_data[_idscreen].view, ViewBase);
	}
	
	private static function set_openflstage(value:Stage):Stage 
	{
		return openflstage = value;
	}
	
}