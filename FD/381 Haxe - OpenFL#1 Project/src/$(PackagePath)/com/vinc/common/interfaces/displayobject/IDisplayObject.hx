package com.vinc.common.interfaces.displayobject;

/**
 * @author Vincent Huss
 */
interface IDisplayObject 
{
	function getPosition(prop:String):Null<Float>;
	function setPosition(prop:String, value:Null<Float>):Void;
	function setDimension(prop:String, value:Null<Float>):Void;
	function getDimension(prop:String):Null<Float>;
}