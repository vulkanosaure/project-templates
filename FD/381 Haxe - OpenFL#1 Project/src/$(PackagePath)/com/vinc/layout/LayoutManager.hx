package com.vinc.layout;
import com.vinc.layout.LayoutSprite;
import com.vinc.time.DelayManager;
import openfl.display.Stage;
import openfl.errors.Error;
import openfl.events.Event;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import openfl.utils.Object;
import starling.core.Starling;
import starling.display.DisplayObject;
import starling.display.DisplayObjectContainer;
import starling.display.Sprite;
import starling.utils.Max;
import starling.utils.RectangleUtil;
import starling.utils.ScaleMode;


/**
 * ...
 * @author Vincent Huss
 */
class LayoutManager
{
	static public inline var SHOW_ALL:String = "showAll";
	static public inline var NO_BORDER:String = "noBorder";
	
	private static var _isReady:Bool = false;
	private static var _delayOnResize:Bool = false;
	private static var _evtResize:Event;
	
	private static var _starling:Starling;
	private static var _mktteSize:Point;
	
	private static var _containers:Array<Object>;
	private static var _containers_sp:Array<Sprite>;
	private static var _items:Array<LayoutSprite>;
	
	static private var _screenRect:Rectangle;
	static private var _listResizeHandlers:Array<Void->Void>;
	
	
	
	public function new() 
	{
		
	}
	
	
	//appelé 2 fois
	//1ere fois : mktteSize, screenRect
	//2eme fois : starling , mktteSize
	
	//reordonner
	
	public static function init(__starling:Starling, __mktteSize:Point, __screenSize:Point = null):Void
	{
		_starling = __starling;
		_mktteSize = __mktteSize;
		if(__screenSize != null) _screenRect = new Rectangle(0, 0, __screenSize.x, __screenSize.y);
		
	}
	
	public static function addResizeLister(_handler:Void->Void):Void
	{
		if (_listResizeHandlers == null) _listResizeHandlers = new Array();
		_listResizeHandlers.push(_handler);
		
	}
	
	
	
	static public function update() 
	{
		
		_isReady = true;
		
		if (true) {
			_delayOnResize = false;
			onResize(null);
		}
	}
	
	
	
	
	static public function addContainer(_item:Sprite, _coeffResize:Null<Float>, _options:Object = null) :Void
	{
		if (_containers == null) {
			_containers = new Array();
			_containers_sp = new Array();
		}
		_containers.push( { "item" : _item, "coeffResize" : _coeffResize, "options" : _options } );
		_containers_sp.push(_item);
		
	}
	
	
	
	static private function getUnitValue(str:String):Dynamic
	{
		var len:Null<Int> = str.length;
		if (str.substr(len - 2) == "px"){
			var val:Null<Int> = Std.parseInt(str.substr(0, len - 2));
			return {value:val, unit:"px"};
		}
		else{
			var val:Null<Int> = Std.parseInt(str.substr(0, len - 1));
			return {value:val, unit:"%"};
		}
	}
	
	
	static public function addItem(_item:LayoutSprite, _data:Object = null) 
	{
		//trace("LayoutManager.additem "+_item.idLayout);
		if (_items == null) _items = new Array();
		_items.push(_item);
		
		if (_data != null) {
			for (_key in _data) 
			{
				//trace(_key + " : " + _data[_key]);
				
				var _val:Null<Int> = Std.int(_data[_key]);
				var _valfloat:Null<Float> = Std.parseFloat(_data[_key]);
				
				
				if (_key == "id") _item.idLayout = Std.string(_data[ _key]);
				else if (_key == "width"){
					
					if (Std.is(_data[_key], String)){
						var tab:Dynamic = getUnitValue(Std.string(_data[_key]));
						if (tab.unit == "px") _item.layoutWidth = tab.value;
						else _item.layoutWidthPercent = tab.value;
						trace("item.layoutWidthPercent : " + _item.layoutWidthPercent);
					}
					else _item.layoutWidth = _val;
					
				}
				else if (_key == "height"){
					_item.layoutHeight = _val;
				}
				else if (_key == "margin-left") _item.marginLeft = _val;
				else if (_key == "margin-right") _item.marginRight = _val;
				else if (_key == "margin-top") _item.marginTop = _val;
				else if (_key == "margin-bottom") _item.marginBottom = _val;
				else if (_key == "center-h") _item.centerH = _valfloat;
				else if (_key == "center-v") _item.centerV = _valfloat;
			}
		}
		
		
		if (_item.parent == null) {
			throw new Error("must call LayoutManager.addItem after adding item to display list");
		}
		
		var _parent:DisplayObjectContainer = _item;
		var _indexof:Null<Int> = -1;
		while (true) {
			_parent = _parent.parent;
			if (Std.is(_parent, Sprite)) {
				
				_indexof = _containers_sp.indexOf(cast(_parent, Sprite));
			}
			
			if (_indexof != -1) break;
			if (_parent == _starling.stage) {
				break;
			}
			
		}
		
		
		_parent = _item;
		while (_item.containerWidth == null) {
			
			
			_parent = _parent.parent;
			if (_parent == _starling.stage) break;
			
			if (Std.is(_parent, LayoutSprite)) {
				var _ls:LayoutSprite = cast(_parent, LayoutSprite);
				if (_ls.layoutWidth != null) {
					_item.containerWidth = _ls.layoutWidth;
					_item.containerHeight = _ls.layoutHeight;
					break;
				}
			}
		}
		
		
		//trace("_indexof : " + _indexof+", _ls.id : "+_item.idLayout);
		if (_indexof != -1) {
			_item.rootContainer = cast(_containers_sp[_indexof], Sprite);
		}
		
	}
	
	
	
	
	
	
	
	static public function onResize(e:Event):Void
    {
		trace("LayoutManager.onResize ");
		if (e != null) _evtResize = e;
		
		if (!_isReady) {
			_delayOnResize = true;
			return;
		}
		
		var _st:Stage = cast(_evtResize.currentTarget, Stage);
		_screenRect = new Rectangle(0, 0, _st.stageWidth, _st.stageHeight);
		
        
		_starling.stage.stageWidth = Std.int(_screenRect.width);
        _starling.stage.stageHeight = Std.int(_screenRect.height);
		
		try
        {
            _starling.viewPort = _screenRect;
        }
        catch (error:Error) { }
		
		
		
		
		//return;
		
		var _len:Null<Int> = _containers.length;
		for (i in 0..._len) 
		{
			var _obj:Object = _containers[i];
			
			var _sp:Sprite = cast(_obj.item, Sprite);
			var _coeffResize:Null<Float> = cast(_obj.coeffResize, Float);
			var _options:Object = _obj.options;
			resizeContainer(_sp, _coeffResize, _options);
			
		}
		
		
		var _nbitem:Null<Int> = _items.length;
		for (j in 0..._nbitem) 
		{
			var _ls:LayoutSprite = cast(_items[j], LayoutSprite);
			layoutItem(_ls);
		}
		
		
		//handlers
		var _len:Null<Int> = (_listResizeHandlers == null) ? 0 : _listResizeHandlers.length;
		for (k in 0..._len) 
		{
			_listResizeHandlers[k]();
		}
		
    }
	
	
	
	static private function layoutItem(_ls:LayoutSprite) :Void
	{
		//trace("layoutItem() " + _ls.centerH);
		
		if (_ls.centerH == null) {
			if (_ls.marginRight != null) {
				
				_ls.x = getContainerWidth(_ls) - _ls.getLayoutWidth() - _ls.marginRight;
			}
			else if (_ls.marginLeft != null) {
				_ls.x = _ls.marginLeft;
			}
		}
		else {
			_ls.x = getContainerWidth(_ls) * _ls.centerH - _ls.getLayoutWidth() * _ls.centerH;
			
		}
		
		
		if (_ls.centerV == null) {
			if (_ls.marginBottom != null) {
				//trace("_ls.y = " + getContainerHeight(_ls) + " - " + _ls.getLayoutHeight() + " - " + _ls.marginBottom);
				_ls.y = getContainerHeight(_ls) - _ls.getLayoutHeight() - _ls.marginBottom;
			}
			else if (_ls.marginTop != null) {
				_ls.y = _ls.marginTop;
			}
		}
		else{
			_ls.y = getContainerHeight(_ls) * _ls.centerV - _ls.getLayoutHeight() * _ls.centerV;
		}
		
		if (_ls.layoutPosition == null) _ls.layoutPosition = new Point();
		_ls.layoutPosition.x = _ls.x;
		_ls.layoutPosition.y = _ls.y;
		
	}
	
	
	
	
	static private function getContainerWidth(ls:LayoutSprite) :Null<Float>
	{
		/*
		if (ls.containerWidth != null) return ls.containerWidth;
		else {
			return _screenRect.width / ls.rootContainer.scaleX;
		}
		*/
		
		var rootdim:Null<Float> = _screenRect.width;
		
		if (ls.parent != null && !Std.is(ls, LayoutSprite)){
			
			var lsparent:LayoutSprite = Std.instance(ls.parent, LayoutSprite);
			if (lsparent.layoutWidthPercent != null) return Std.int(rootdim * ls.layoutWidthPercent / 100);
			else return lsparent.layoutWidth;
		}
		else return _screenRect.width / ls.rootContainer.scaleX;
		
	}
	static private function getContainerHeight(ls:LayoutSprite) :Null<Float>
	{
		/*
		if (ls.containerHeight != null) return ls.containerHeight;
		else return _screenRect.height / ls.rootContainer.scaleY;
		*/
		
		var rootdim:Null<Float> = _screenRect.height;
		
		if (ls.parent != null && !Std.is(ls, LayoutSprite)){
			
			var lsparent:LayoutSprite = Std.instance(ls.parent, LayoutSprite);
			if (lsparent.layoutHeightPercent != null) return Std.int(rootdim * ls.layoutHeightPercent / 100);
			else return lsparent.layoutHeight;
		}
		else return _screenRect.height / ls.rootContainer.scaleY;
	}
	
	
	
	
	
	
	static public function resizeContainer(_sp:Dynamic, _coeffResize:Null<Float>, _options:Object) :Void
	{
		var _mktteRect:Rectangle = new Rectangle(0, 0, _mktteSize.x, _mktteSize.y);
		trace("_mktteSize : " + _mktteSize);
		trace("_screenRect : " + _screenRect);
        
		var _rect0:Rectangle = RectangleUtil.fit(_mktteRect, _screenRect, ScaleMode.SHOW_ALL);
		var _scale0:Null<Float> = _rect0.width / _mktteRect.width;
		
		var _rect1:Rectangle = RectangleUtil.fit(_mktteRect, _screenRect, ScaleMode.NO_BORDER);
		var _scale1:Null<Float> = _rect1.width / _mktteRect.width;
		
		var _scale:Null<Float> = _scale0 + _coeffResize * (_scale1 - _scale0);
		
		
		if (_options != null){
			if (_options["max-scale"]){
				var _maxScale:Null<Float> = _options["max-scale"];
				if (_scale > _maxScale) _scale = _maxScale;
			}
			if (_options["min-scale"]){
				var _minScale:Null<Float> = _options["min-scale"];
				if (_scale < _minScale) _scale = _minScale;
			}
		
		}
		//_scale *= 1 / devicePixelRatio;
		trace("_scale : " + _scale);
		//_sp.scaleX = _sp.scaleY = _scale;
		//_sp["scaleX"] = _sp["scaleY"] = _scale;
		Reflect.setProperty(_sp, "scaleX", _scale);
		Reflect.setProperty(_sp, "scaleY", _scale);
		
		
		//trace("resizeContainer(x, " + _type+")");
		
		
	}
	
	
	
}