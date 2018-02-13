package com.vinc.display.text;
import com.vinc.layout.LayoutSprite;
#if html5
import js.Lib;
#end
import openfl.utils.Object;
import starling.text.TextField;
import starling.text.TextFieldAutoSize;
import starling.utils.HAlign;
import starling.utils.VAlign;

/**
 * ...
 * @author Vincent Huss
 */
class VText extends LayoutSprite
{
	public var text:String;
	
	public var textWidth:Null<Int> = null;
	public var textHeight:Null<Int> = null;
	
	private var options:Object;
	var _tf:TextField;
	
	public function new(_options:Object) 
	{
		super();
		options = _options;
		if (options.halign == null) options.halign = "left";
		if (options.uppercase == null) options.uppercase = false;
		this.touchable = false;
	}
	
	public function init():Void
	{
		_tf = new TextField(textWidth, textHeight, "", options.font, options.size, options.color);
		//trace("VText.init " + options.font+", "+options.size+", "+options.color);
		
		if (options.leading != null) _tf.leading = Math.round(options.leading - options.size * 1.13);
		//letterspacing pas géré en starling 1
		
		_tf.hAlign = options.halign;
		_tf.vAlign = VAlign.TOP;
		
		if (textWidth == null && textHeight == null) _tf.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
		else if (textHeight == null) _tf.autoSize = TextFieldAutoSize.VERTICAL;
		else if (textWidth == null) _tf.autoSize = TextFieldAutoSize.HORIZONTAL;
		
		this.addChild(_tf);
		if (Constants.DEBUG_TEXT) _tf.border = true;
		
		updateText(text);
		
		
	}
	
	public function updateText(value:String) :Void
	{
		text = value;
		
		if (options.uppercase) _tf.text = text.toUpperCase();
		else _tf.text = text;
		
		_tf.batchable = (text.length < 16);
	}
	
}