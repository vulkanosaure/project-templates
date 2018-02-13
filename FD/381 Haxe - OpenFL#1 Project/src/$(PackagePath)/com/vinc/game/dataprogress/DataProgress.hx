package com.vinc.game.dataprogress;

/**
 * ...
 * @author Vincent Huss
 */
class DataProgress 
{
	@:isVar public var progress(get, set):Null<Float>;
	public var feedFunction:Null<Int>->Array<DataProgressItem>;
	public var feedLength:Null<Int>;
	
	public var data:Array<DataProgressItem>;
	private var feedIndex:Null<Int>;

	public function new() 
	{
		reset();
	}
	
	public function reset():Void
	{
		progress = 0;
		feedIndex = 0;
		data = [];
	}
	
	
	public function getData():Array<DataProgressItem>
	{
		var output:Array<DataProgressItem> = [];
		
		//on veut lire tout ce qui est inférieur à progress
		var len:Null<Int> = data.length;
		
		if (len == 0){
			
			data = feedFunction(feedIndex);
			//update progress
			
			len = data.length;
			for (i in 0...len){
				data[i].progress += feedLength * feedIndex;
			}
			
			feedIndex++;
		}
		
		
		for (i in 0...len){
			
			var item:DataProgressItem = data[i];
			if (item.progress < progress){
				output.push(item);
			}
			
		}
		
		//splice tous les items qui ont été add a output
		len = output.length;
		for (i in 0...len){
			var indremove:Null<Int> = output[i].progress;
			deleteItem(indremove);
		}
		
		
		return output;
	}
	
	function deleteItem(progress:Null<Int>) :Void
	{
		var len:Null<Int> = data.length;
		for (i in 0...len){
			var item:DataProgressItem = data[i];
			if (item.progress == progress){
				data.splice(i, 1);
				return;
			}
		}
	}
	
	
	
	
	
	
	function get_progress():Null<Float> 
	{
		return progress;
	}
	
	function set_progress(value:Null<Float>):Null<Float> 
	{
		return progress = value;
	}
	
	
}