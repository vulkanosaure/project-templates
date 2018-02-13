package com.vinc.fx.scrollingbg;
import com.vinc.common.interfaces.displayobject.IDisplayObject;
import js.Lib;


/**
 * ...
 * @author Vincent Huss
 */
class ScrollingBG
{
	@:isVar private var mode(get, set):String = "horizontal";
	private var items:Array<IDisplayObject>;
	
	@:isVar public var x(get, set):Null<Float>;
	@:isVar public var y(get, set):Null<Float>;
	private var dimensions:Array<Float>;
	private var length:Null<Int>;
	private var prop_pos:String;
	private var save_pos:Null<Float>;
	private var dimension_visible:Null<Float>;
	@:isVar public var dim_total(get, null):Null<Float>;
	
	
	

	public function new(_dimensionVisible:Null<Float>)
	{
		
		items = [];
		dimensions = [];
		dimension_visible = _dimensionVisible;
	}
	
	
	public function add(item:IDisplayObject):Void
	{
		items.push(item);
	}
	
	
	public function init():Void
	{
		var len:Null<Int> = items.length;
		length = len;
		var cumul:Null<Float> = 0;
		prop_pos = (mode == "horizontal") ? "x" : "y";
		var prop_dim:String = (mode == "horizontal") ? "width" : "height";
		
		
		for (i in 0...len){
			var dobj:IDisplayObject = items[i];
			
			//trace("- cumul : " + cumul);
			dobj.setPosition(prop_pos, cumul);
			
			var dim:Null<Float> = dobj.getDimension(prop_dim);
			
			cumul += dim;
			dimensions.push(dim);
			
		}
		
		//Lib.debug();
		dim_total = Math.round(cumul);
	}
	
	
	function update():Void
	{
		//on a une position pos_base qui ne correspond pas forcément a qqchose de réaliste
		//on veut juste que l'item 0 soit a cette position, mais avec opérateur % sur dim_total
		//
		
		var pos_base:Null<Float> = (mode == "horizontal") ? x : y;
		var pos_base2:Null<Float> = pos_base % dim_total;
		
		
		var cumul:Null<Float> = 0;
		var forward:Bool = pos_base > save_pos;
		
		//trace("dim_total : " + dim_total + ", dimension_visible : " + dimension_visible);
		
		for (i in 0...length){
			var child:IDisplayObject = items[i];
			var pos:Null<Float> = pos_base2 + cumul;
			
			if (forward){
				if (pos > dimension_visible){
					pos -= dim_total;
				}
			}
			else{
				var dim:Null<Float> = dimensions[i];
				
				if (pos < -dim){
					pos += dim_total;
				}
			}
			
			child.setPosition(prop_pos, pos);
			cumul += dimensions[i];
			
		}
		
		save_pos = pos_base;
	}
	
	
	
	
	//________________________________________________________________
	
	function get_mode():String {return mode;}
	
	function set_mode(value:String):String {return mode = value; }
	
	
	function get_x():Null<Float> {return x;}
	
	function set_x(value:Null<Float>):Null<Float> {
		x = value;
		update();
		return x;
	}
	
	function get_y():Null<Float> {return y;}
	
	function set_y(value:Null<Float>):Null<Float> {
		y = value;
		update();
		return y;
	}
	
	function get_dim_total():Null<Float> {return dim_total;  }
		
	
	
	
	
	
}