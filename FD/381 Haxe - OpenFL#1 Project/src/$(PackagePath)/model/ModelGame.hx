package model;
import com.vinc.net.Ajax;
import haxe.Json;
import openfl.events.Event;
import openfl.utils.Object;

/**
 * ...
 * @author Vincent Huss
 */
class ModelGame
{
	static private var _ajax:Ajax;
	static public var data:Object;
	static private var _handler:Void->Void;

	public function new() 
	{
		
	}
	
	
	
	public static function queryRanking(_data:Object, __handler:Void->Void):Void
	{
		
		trace("ModelGame.queryRanking()");
		trace("_data : " + _data);
		_handler = __handler;
		
		_ajax = new Ajax();
		_ajax.addEventListener(Event.COMPLETE, onRankingComplete);
		for (_key in _data) Reflect.setField(_ajax.varsIn, _key, Reflect.field(_data, _key));
		
		_ajax.outputMode = Ajax.OUTPUT_DATA;
		_ajax.encrypt(["id", "nickname", "score"]);
		_ajax.call("php/ranking.php");
		
		
	}
	
	static private function onRankingComplete(e:Event):Void 
	{
		trace("ModelGame.onRankingComplete");
		trace(_ajax.outputData);
		
		data = Json.parse(_ajax.outputData);
		_handler();
	}
	
}