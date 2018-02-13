package com.vinc.patterns.redux;
import com.vinc.patterns.Action;

/**
 * ...
 * @author Vincent Huss
 */
class CombinedReducer extends Reducer
{
	private var reducers:Map<String, Reducer>;
	
	public function new() 
	{
		
	}
	public function init(_reducers:Map<String, Reducer>):Void
	{
		reducers = _reducers;
	}
	
	override public function reduce(state:Dynamic, action:Action):Dynamic 
	{
		var reducersKeys:Iterator<String> = reducers.keys();
		//trace("reducersKeys : " + reducersKeys);		
		
		var output:Dynamic = {};
		
		for (k in reducersKeys){
			//trace("k : " + k);
			var reducer:Reducer = reducers[k];
			var st:Dynamic = Reflect.getProperty(state, k);
			var result:Dynamic = reducer.reduce(st, action);
			Reflect.setProperty(output, k, result);
		}
		
		return output;
		
	}
	
	
	
	
	
}