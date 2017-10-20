package com.vinc.game.nape.factory;
import openfl.errors.Error;
import starling.events.EventDispatcher;

/**
 * ...
 * @author Vincent Huss
 */
class GameItemFactory extends EventDispatcher
{
	private var _items:Array<IGameItemFactory>;
	private var _liststeps:Array<Int>;
	private var _laststep:Int;
	
	
	@:isVar public var progress(get, set):Int;
	
	@:isVar public var interval(get, set):Int;
	private var _interval:Int;
	public var firststep(default, set):Int;
	
	public var marginRight(default, set):Int;
	public var marginLeft(default, set):Int;
	
	private var _classItem:Class<IGameItemFactory>;
	
	
	public function new(__classItem:Class<IGameItemFactory>) 
	{
		super();
		
		marginLeft = 0;
		marginRight = 200;
		
		_classItem = __classItem;
		
		reset();
	}
	
	
	
	public function reset():Void
	{
		if (_items == null) _items = new Array();
		_liststeps = new Array();
		
		var _len:Int = _items.length;
		for (i in 0..._len) 
		{
			_items[i].destroy();
		}
		
		_items = new Array();
		
		progress = 0;
		_laststep = 0;
		
		
	}
	
	
	
	function get_progress():Int 
	{
		return progress;
	}
	
	function set_progress(value:Int):Int 
	{
		progress = value;
		return progress;
	}
	
	function get_interval():Int 
	{
		return interval;
	}
	
	function set_interval(value:Int):Int 
	{
		_interval = value;
		trace("set_interval(" + value+") : " + _interval);
		return interval = value;
	}
	
	
	function set_firststep(value:Int):Int 
	{
		return firststep = value;
	}
	
	
	function set_marginRight(value:Int):Int { return marginRight = value; }	
	
	function set_marginLeft(value:Int):Int { return marginLeft = value; }	
	
	
	private function createObject():IGameItemFactory
	{
		var _inst:IGameItemFactory = Type.createEmptyInstance(_classItem);
		return _inst;
	}
	
	
	
	//_______________________________________________________________
	
	
	
	public function update() :Void
	{
		if (_interval == null) throw new Error("interval must be set");
		
		
		
		/*
		delete first maybe ?
		run through every item
		if outside bounds, delete
		
		run through all theoric items (that should be there)
		if they don't exist, add them
		
		getDebugDisplay with a vertical line showing the progress, and 2 vertical lines for margin,
		handle it from outside
		arg for setting horizal or vertical mode
		
		*/
		
		var _intervalfloat:Float;
		
		var y:Float = progress + marginLeft;
		_intervalfloat = (y - firststep) / interval;
		var _nbintervalmin:Int = Math.ceil(_intervalfloat);
		if (_nbintervalmin < 0) _nbintervalmin = 0;
		
		y = progress + marginRight;
		_intervalfloat = (y - firststep) / interval;
		var _nbintervalmax:Int = Math.floor(_intervalfloat);
		
		//trace("_nbintervalmin : " + _nbintervalmin + ", _nbintervalmax : " + _nbintervalmax+" /// _items.length : "+_items.length);
		
		for (j in _nbintervalmin..._nbintervalmax) 
		{
			var _step:Int = interval * j + firststep;
			
			var _item:IGameItemFactory = getItemByStep(_step);
			if (_item == null) {
				//trace("- must create " + j);
				
				_liststeps.push(_step);
				
				_item = createObject();
				_items.push(_item);
				
				var _evt:GameItemFactoryEvent = new GameItemFactoryEvent(GameItemFactoryEvent.ADD_ITEM);
				_evt.item = _item;
				_evt.progress = _step;
				this.dispatchEvent(_evt);
			}
			
		}
		
		
		
		//remove (both ways)
		
		var _len:Int = _liststeps.length;
		_len = _liststeps.length;
		for (i in 0..._len)
		{
			var i2:Int = _len - i - 1;
			
			//trace("- i2 : " + i2);
			var _step:Int = _liststeps[i2];
			var _localstep:Int = _step - progress;
			
			if ((_localstep - marginLeft) < 0 || (_localstep > marginRight)) {
				//trace(" +++ remove " + i2);
				
				var _item:IGameItemFactory = _items[i2];
				
				
				_item.destroy();
				
				_liststeps.splice(i2, 1);
				_items.splice(i2, 1);
				
				var _evt:GameItemFactoryEvent = new GameItemFactoryEvent(GameItemFactoryEvent.REMOVE_ITEM);
				_evt.item = _item;
				this.dispatchEvent(_evt);
				
				
			}
			
		}
		
		
	}
	
	function getItemByStep(step:Int) :IGameItemFactory
	{
		var _len:Int = _items.length;
		for (i in 0..._len) 
		{
			if (_liststeps[i] == step) return _items[i];
		}
		return null;
	}
	
	public function getItems() :Array<IGameItemFactory>
	{
		return _items;
	}
	
	
	
}