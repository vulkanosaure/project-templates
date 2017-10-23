package display;
import com.vinc.layout.LayoutSprite;
import starling.filters.FragmentFilter;
import starling.text.TextField;
import starling.utils.HAlign;

/**
 * ...
 * @author Vincent Huss
 */
class Counter extends LayoutSprite
{
	var _tf2:TextField;
	var _tf:TextField;

	public function new() 
	{
		super();
		
		
		_tf2 = new TextField(200, 100, "", "font_counter", 74, 0x000000);
		this.addChild(_tf2);
		//_tf2.border = true;
		_tf2.hAlign = HAlign.CENTER;
		_tf2.x = _tf2.y = 4;
		
		
		_tf = new TextField(200, 100, "", "font_counter", 74, 0xFFFFFF);
		this.addChild(_tf);
		//_tf.border = true;
		_tf.hAlign = HAlign.CENTER;
		
	}
	
	public function setValue(_value:Int) 
	{
		var _valstr:String = Std.string(_value);
		_tf.text = _valstr;
		_tf2.text = _valstr;
	}
	
}