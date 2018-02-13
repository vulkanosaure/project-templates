package com.vinc.game;

/**
 * ...
 * @author Vincent Huss
 */
@:generic
class StoreItems<T>
{
	public var items:Array<T>;
	private var toremove:Array<T>;

	public function new() 
	{
		reset();
	}
		
	public function reset():Void
	{
		removeReal();
		items = [];
	}
	
	public function foreach(callback:T->Void):Void
	{
		removeReal();
		
		var len:Null<Int> = items.length;
		for (i in 0...len){
			
			callback(items[i]);
			
		}
		
		
	}
	
	private function removeReal() 
	{
		if (toremove != null){
			var len:Null<Int> = toremove.length;
			for (i in 0...len){
				
				var index:Null<Int> = items.indexOf(toremove[i]);
				trace("removeReal index : " + index);
				items.splice(index, 1);
			}
		}
		toremove = [];
	}
	
	public function add(item:T):Void
	{
		items.push(item);
	}
	
	public function remove(item:T):Void
	{
		if (toremove == null) toremove = [];
		toremove.push(item);
	}
	
	
	
}