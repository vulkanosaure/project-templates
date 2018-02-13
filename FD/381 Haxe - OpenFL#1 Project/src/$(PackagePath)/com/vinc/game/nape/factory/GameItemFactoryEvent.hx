package com.vinc.game.nape.factory;
import starling.events.Event;

/**
 * ...
 * @author Vincent Huss
 */
class GameItemFactoryEvent extends Event
{
	public static inline var ADD_ITEM:String = "addItem";
	public static inline var REMOVE_ITEM:String = "removeItem";
	public var item:IGameItemFactory;
	public var progress:Null<Int>;

	public function new(type:String, bubbles:Bool=false, data:Dynamic=null) 
	{
		super(type, bubbles, data);
	}
	
}