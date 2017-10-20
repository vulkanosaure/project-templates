package com.vinc.net;




import com.vinc.time.Delay;
import haxe.crypto.Sha256;
import haxe.web.Dispatch.Lock;
import openfl.errors.Error;
import openfl.net.URLRequestHeader;
import openfl.net.URLVariables;
import openfl.net.URLLoader;
import openfl.net.URLRequest;
import openfl.net.URLRequestMethod;
import openfl.net.URLLoaderDataFormat;
import openfl.utils.Object;

import openfl.events.Event;
import openfl.events.ProgressEvent;
import openfl.events.IOErrorEvent; 
import openfl.events.EventDispatcher;


class Ajax extends EventDispatcher{
	
	
	public static inline var OUTPUT_VARIABLES:String = "outputVariables";
	public static inline var OUTPUT_DATA:String = "outputData";
	private static inline var ENCRYPTION_KEY:String = "kd3js9zK2pchW5kQ";
	
	//variables publiques d'entrée et sortie
	public var varsIn:URLVariables;
	public var varsOut:URLVariables;
	
	public var outputData(get, null):String;
	public var outputMode(default, set):String = OUTPUT_VARIABLES;
	
	public var id:String;
	
	public var delayTimeout(default, set):Int = 5000;
	private var _completed:Bool;
	private var _d:Delay;
	public var debug(default, set):Bool = true;
	
	public static var connexionActiveSimulation(get, set):Bool;
	private static var _connexionActiveSimulation:Bool = true;
	
	
	public static inline var POST:String = "POST";
	public static inline var GET:String = "GET";
	
	
	public function new() 
	{ 
		super();
		reset();
		
	}
	
	public function reset():Void
	{
		varsIn = new URLVariables();
	}
	
	public function call(_serverFile:String, _open:Bool=false, _target:String=null, _method:String="POST"):Void
	{
		varsOut = new URLVariables();
		_completed = false;
		
		if (debug) {
			trace("Ajax.call(" + _serverFile + ")");
			for (name in Reflect.fields(varsIn)) trace(" - " + name + " : " + Reflect.field(varsIn, name));
		}
		
		
		if (!_connexionActiveSimulation) _serverFile = _serverFile + "_";
		
		
		
		var req:URLRequest = new URLRequest(_serverFile);
		if(!_open) req.method = _method;
		else req.method = _method;
		req.data = varsIn;
		var varLoader:URLLoader = new URLLoader();
		varLoader.dataFormat = URLLoaderDataFormat.TEXT;
		
		//necessary au moins pour post
		var headers:Array<URLRequestHeader> = [];
		headers.push(new URLRequestHeader("Content-type", "application/x-www-form-urlencoded"));
		req.requestHeaders = headers;
		
		
		//redirection des evenements... (en rajouter si nécéssaire...)
		varLoader.addEventListener(Event.COMPLETE, onComplete);
		varLoader.addEventListener(ProgressEvent.PROGRESS, dispatchEvent);
		varLoader.addEventListener(IOErrorEvent.IO_ERROR , onIOErrorEvent);
		//varLoader.addEventListener(IOErrorEvent.IO_ERROR , dispatchEvent);
		
		/*
		if (_open) navigateToURL(req, _target);
		else varLoader.load(req);
		*/
		if (_open) throw new Error("open not implemented yet");
		else varLoader.load(req);
		
		
		
		if (delayTimeout != null) {
			if (_d != null && _d.waiting) _d.stop();
			
			_d = new Delay(delayTimeout, function():Void {
				if (!_completed) {
					trace("timeout by delay");
					varLoader.removeEventListener(IOErrorEvent.IO_ERROR , onIOErrorEvent);
					varLoader.removeEventListener(Event.COMPLETE, onComplete);
					onIOErrorEvent(null);
				}
			});
		}
		
		
	}
	
	
	
	
	
	
	public function encrypt(_tabkey:Array<String>):Void
	{
		var _tabvalues:Array<String> = new Array();
		var _len:Int = _tabkey.length;
		for (i in 0..._len) {
			var _val:String = Reflect.field(varsIn, _tabkey[i]);
			_tabvalues.push(_val);
			//_tabvalues.push(varsIn[_tabkey[i]]);
		}
		
		var _hash:String = Sha256.encode(_tabvalues.join(":") + ":" + ENCRYPTION_KEY);
		//varsIn["verifier"] = _hash;
		Reflect.setField(varsIn, "verifier", _hash);
		
		//trace("encrypt, _tabvalues : " + _tabvalues + ", _hash : " + _hash);
	}
	
	public function isEncryptionValid(_obj:Object, _tabkey:Array<String>):Bool
	{
		var _keyencrypt:String = "verifier";
		if (_obj[_keyencrypt] == null) {
			//trace("not defined");
			return false;
		}
		else {
			var _tabvalues:Array<String> = new Array();
			var _len:Int = _tabkey.length;
			for (i in 0..._len) _tabvalues.push(_obj[_tabkey[i]]);
			
			var _hash:String = Sha256.encode(_tabvalues.join(":") + ":" + ENCRYPTION_KEY);
			if(_obj[_keyencrypt] == _hash) return true;
			else return false;
		}
	}
	
	
	
	
	
	//____________________________________________________________________________________________
	// Events
	
	
	private function onComplete(e:Event):Void
	{
		if (_completed) return;	//secu
		_completed = true;
		
		var l:URLLoader = cast(e.currentTarget, URLLoader);
		
		if(outputMode==OUTPUT_VARIABLES){
			//stocke les variables de retour ds un objet varsOut pour un acces plus intuitif
			try {
				varsOut.decode(l.data);
			} catch(e:Error){
				trace('Error URLVariable.decode() : wrong format : ', l.data);
			}
		}
		//trace("Ajax ::varsOut : " + varsOut);
		else {
			outputData = l.data;
		}
		
		this.dispatchEvent(e);
	}
	
	
	private function onIOErrorEvent(e:IOErrorEvent):Void
	{
		trace("Ajax.onIOErrorEvent");
	}
	
	
	
	
	//________________________________________________________________
	//getter / setter
	
	
	function get_outputData():String 
	{
		return outputData;
	}
	
	function set_outputMode(value:String):String 
	{
		if (value != OUTPUT_DATA && value != OUTPUT_VARIABLES) throw new Error("wrong value for property outputMode");
		return outputMode = value;
	}
	
	
	function set_delayTimeout(value:Int):Int 
	{
		return delayTimeout = value;
	}
	
	function set_debug(value:Bool):Bool 
	{
		return debug = value;
	}
	
	static function get_connexionActiveSimulation():Bool 
	{
		return _connexionActiveSimulation;
	}
	
	static function set_connexionActiveSimulation(value:Bool):Bool 
	{
		return _connexionActiveSimulation = value;
	}
	
	
}