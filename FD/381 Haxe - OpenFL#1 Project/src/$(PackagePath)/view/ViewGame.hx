package view;
import com.vinc.common.ObjectSearch;
import com.vinc.display.VImage;
import com.vinc.display.text.VText;
import com.vinc.layout.LayoutManager;
import com.vinc.layout.LayoutSprite;
import com.vinc.mvc.ViewBase;
import com.vinc.time.DelayManager;
import game.items.Item;
import motion.Actuate;
import openfl.geom.Rectangle;
import starling.display.Quad;
import ui.VButton1;
import starling.display.Sprite;
/**
 * ...
 * @author Vincent Huss
 */
class ViewGame extends ViewBase
{
	
	var items:Sprite;
	var _rectDebug:Quad;
	
	
	
	public function new() 
	{
		super();
	}
	
	override public function construct():Void 
	{
		var container:Sprite = Vars.containerFG;
		
		
		//___________________________________________________________
		//GAME
		
		
		
		var game:LayoutSprite = new LayoutSprite();
		container.addChild(game);
		game.idLayout = "game";
		LayoutManager.addItem(game, {});
		ObjectSearch.registerID(game, "screen_game");
		
		
		items = new Sprite();
		game.addChild(items);
		
		
		//...
		
		
		
		
	}
	
	
	
	private var _currentCounterStart:Int;
	var counter:LayoutSprite;
	var asset_go:VImage;
	var txt_score:VText;
	
	public function startAnimCounter():Void
	{
		counter.visible = false;
		
		_currentCounterStart = 3;
		setImageVisible(counter, "go");
		
		for (i in 0...4){
			DelayManager.add("", 1200 * i + 1000, function(index){
				animCounter(index + "");
			}, [_currentCounterStart]);
			_currentCounterStart--;
		}
		
	}
	
	public function initGame() 
	{
		counter.visible = false;
	}
	
	public function displayLife(_nb:Int) :Void
	{
		
	}
	
	public function setScore(score:Float) 
	{
		//txt_score.updateText(score+"");
	}
	
	public function addItem(item:Item) 
	{
		items.addChild(item);
	}
	
	public function removeItem(item:Item) 
	{
		items.removeChild(item);
	}
	
	
	public function getZoneHit() :Rectangle
	{
		var w:Null<Float> = 300;
		var h:Null<Float> = 80;
		
		var x:Null<Float> = 0;
		var y:Null<Float> = 0;
		
		var output:Rectangle = new Rectangle(x, y, w, h);
		return output;
		
	}
	
	
	public function drawRect(_zone:Rectangle, _index:Int = 0) 
	{
		var _rect:Quad = null;
		if (_index == 0) _rect = _rectDebug;
		//else if (_index == 1) _rect = _rectDebug2;
		
		_rect.width = _zone.width;
		_rect.height = _zone.height;
		_rect.x = _zone.x;
		_rect.y = _zone.y;
		
	}
	
	private function animCounter(_name:String) :Void
	{
		trace("animCounter(" + _name+")");
		
		var item_anim:Sprite = counter;
		counter.visible = true;
		var _label:String = (_name == "0") ? "go" : _name + "";
		setImageVisible(counter, _label);
		item_anim = counter;
		
		item_anim.alpha = 0;
		Actuate.tween(item_anim, 0.2, {alpha:1});
		Actuate.tween(item_anim, 0.2, {alpha:0}, false).delay(0.6);
		
		
	}
	
	private function setImageVisible(container:Sprite, name:String):Void
	{
		var numchildren:Int = container.numChildren;
		for (i in 0...numchildren) container.getChildAt(i).visible = false;
		container.getChildByName(name).visible = true;
	}
	
	
	
	public function animPointBonus(x:Null<Float>, y:Null<Float>, value:Null<Float>, multiplicator:Null<Float> = -1, type:String = "error", text:String = ""):Void
	{
		/*
		asset_catch.visible = (type == "catch");
		asset_catch2.visible = (type == "catch2");
		asset_error.visible = (type == "error");
		
		y -= 85;
		
		pts_bonus.x = x;
		pts_bonus.y = y + 50;
		pts_bonus.visible = true;
		pts_bonus.alpha = 0;
		
		if (multiplicator != -1){
			txt_pts_bonus.updateText("X " + multiplicator);
		}
		else if(value != 0){
			if (value < 0) txt_pts_bonus.updateText("- " + Math.abs(value));
			else txt_pts_bonus.updateText("" + value);
		}
		else if (text != ""){
			txt_pts_bonus.updateText(text);
		}
		else txt_pts_bonus.updateText("");
		
		
		Actuate.tween(pts_bonus, 0.4, {alpha:1, y:y}).ease(Sine.easeOut);
		Actuate.tween(pts_bonus, 0.3, {alpha:0}, false).ease(Sine.easeOut).delay(1.1);
		*/
		
	}
	
	
	
	
}