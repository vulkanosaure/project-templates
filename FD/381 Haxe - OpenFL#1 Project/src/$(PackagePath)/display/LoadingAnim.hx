package display;
import com.vinc.layout.LayoutSprite;
import openfl.events.TimerEvent;
import openfl.utils.Timer;
import starling.display.Image;
import starling.display.Sprite;
import starling.textures.Texture;

/**
 * ...
 * @author Vincent Huss
 */
class LoadingAnim extends LayoutSprite
{
	private var _counter:Int;
	var _timer:Timer;
	var _imgs:Array<Image>;

	public function new() 
	{
		super();
		
		var _text:Texture = Vars.assets.getTexture("interface/loading-item");
		var _space:Int = 34;
		
		var _img1:Image = new Image(_text);
		_img1.x = _space * 0;
		this.addChild(_img1);
		
		
		var _img2:Image = new Image(_text);
		_img2.x = _space * 1;
		this.addChild(_img2);
		
		
		var _img3:Image = new Image(_text);
		_img3.x = _space * 2;
		this.addChild(_img3);
		
		_timer = new Timer(300);
		_timer.addEventListener(TimerEvent.TIMER, onTimer);
		
		_imgs = new Array();
		_imgs.push(_img1);
		_imgs.push(_img2);
		_imgs.push(_img3);
		
	}
	
	public function start():Void
	{
		_counter = 0;
		_timer.start();
		onTimer(null);
	}
	public function stop():Void
	{
		_timer.stop();
	}
	
	private function onTimer(e:TimerEvent):Void 
	{
		for (i in 0...3) 
		{
			_imgs[i].visible = _counter > i;
		}
		
		_counter++;
		if (_counter >= 4) _counter = 0;
	}
	
}