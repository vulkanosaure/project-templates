package com.vinc.helpers;
import com.vinc.math.Math2;

/**
 * ...
 * @author Vincent Huss
 */
class ArrayUtils 
{
	
	
	/**
	Shuffles the array passed as argument
	a copy is returned
	**/
	public static function shuffle<T>(_tabsrc:Array<T>):Array<T>
	{
		var _newtab:Array<T> = new Array();
		
		var _len:Null<Int> = _tabsrc.length;
		var _tabsrccopy:Array<T> = new Array();
		for (i in 0..._len) _tabsrccopy.push(_tabsrc[i]);
		
		for (i in 0..._len) 
		{
			var _randsrc:Null<Int> = Std.int(Math2.random(0, _tabsrccopy.length - 1));
			var _itemrand = _tabsrccopy[_randsrc];
			_newtab.push(_itemrand);
			_tabsrccopy.splice(_randsrc, 1);
		}
		return _newtab;
	}
	
}