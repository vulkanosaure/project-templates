package game.items;
import com.vinc.common.Pool;
import com.vinc.display.VImage;
import starling.display.Sprite;

/**
 * ...
 * @author Vulkanosaure
 */
class Item extends Sprite
{
	public static inline var TYPE_TARGET1:Null<Int> = 0;
	public static inline var TYPE_TARGET2:Null<Int> = 1;
	public static inline var TYPE_TARGET3:Null<Int> = 2;
	public static inline var TYPE_ENEMY1:Null<Int> = 3;
	public static inline var TYPE_ENEMY2:Null<Int> = 4;
	
	public var type:Null<Int>;
	public var active:Bool;
	
	private var velocity:Null<Float> = 0;
	private var img_on:VImage;
	private var img_off:VImage;
	
	
	

	public function new() 
	{
		super();
	}
	
	
	
	
	public function init(_type:Null<Int>):Void
	{
		type = _type;
		
		
		var assetsstr:String = "";
		if (_type == TYPE_TARGET1) assetsstr += "char1";
		else if (_type == TYPE_TARGET2) assetsstr += "char2";
		else if (_type == TYPE_TARGET3) assetsstr += "char3";
		else if (_type == TYPE_ENEMY1) assetsstr += "enemy1";
		else if (_type == TYPE_ENEMY2) assetsstr += "enemy2";
		
		//trace("assetsstr : " + assetsstr);
		
		//img = new VImage(assetsstr);
		
		//img_on = new VImage(assetsstr + "-on");
		img_on = Pool.createInstance(type+"-on", VImage, [assetsstr + "-on"], 5);
		this.addChild(img_on);
		img_on.alignPivot();
		
		img_off = Pool.createInstance(type+"-off", VImage, [assetsstr + "-off"], 5);
		this.addChild(img_off);
		img_off.alignPivot();
		
		img_off.visible = false;
		
		active = true;
		velocity = 1.7;
		
		
	}
	
	public function step() 
	{
		this.x += velocity;
		this.y += velocity;
		
		//this.rotation += rota;
		
	}
	
	
	
	public function destroy() 
	{
		this.removeChild(img_off);
		this.removeChild(img_on);
	}
	
}