package view;
import com.vinc.common.ObjectSearch;
import com.vinc.display.VImage;
import com.vinc.layout.LayoutManager;
import com.vinc.layout.LayoutSprite;
import com.vinc.mvc.ViewBase;
import com.vinc.time.DelayManager;
import motion.Actuate;
import motion.easing.Sine;
import starling.display.BlendMode;
import starling.display.Quad;
import starling.display.Sprite;

/**
 * ...
 * @author Vincent Huss
 */
class ViewLoader extends ViewBase
{
	var asset_loader_point:VImage;
	var loader:LayoutSprite;
	var mask:Quad;

	public function new() 
	{
		super();
	}
	
	override public function construct():Void 
	{
		trace("ViewLoader.construct");
		
		var bg:VImage = new VImage("bg");
		Vars.containerBG.addChild(bg);
		bg.idLayout = "bg";
		LayoutManager.addItem(bg, {"center-h" : 0.5, "center-v" : 0.5});
		bg.blendMode = BlendMode.NONE;
		bg.touchable = false;
		
		
		var container:Sprite = Vars.containerFG;
		
		
		
		
		var container_loader:LayoutSprite = new LayoutSprite();
		container.addChild(container_loader);
		container_loader.idLayout = "container-loader";
		LayoutManager.addItem(container_loader, {"width":"100%", "height":"100%"});
		ObjectSearch.registerID(container_loader, "screen_loader");
		
		container_loader.touchable = false;
		
		
		loader = new LayoutSprite();
		container_loader.addChild(loader);
		loader.idLayout = "loader";
		LayoutManager.addItem(loader, {"center-h" : 0.5, "center-v" : 0.48, "width" : 362, "height" : 314});
		
		
		
		var asset_loader:VImage = new VImage("asset-loader");
		loader.addChild(asset_loader);
		asset_loader.idLayout = "asset_loader";
		LayoutManager.addItem(asset_loader, {});
		
		asset_loader_point = new VImage("asset-loader-point");
		loader.addChild(asset_loader_point);
		asset_loader_point.idLayout = "asset_loader_point";
		LayoutManager.addItem(asset_loader_point, {"margin-left" : 202, "margin-top" : 136});
		
		mask = new Quad(73, 18);
		mask.x = 202; mask.y = 136;
		loader.addChild(mask);
		asset_loader_point.getImage().mask = mask;
		
		loader.alpha = 0;
		
		
		DelayManager.add("", 30, function(){
			var y:Float = loader.y;
			loader.y = y + 300;
			Actuate.tween(loader, 0.25, {y : y, alpha : 1}, true).ease(Sine.easeOut).delay(0.3);
		});
		
		
		
		
		
		
		
		
		
	}
	
	
	
	public function updateProgress(_progress:Float):Void
	{
		//trace("ViewLoader.updateProgress(" + _progress + ")");
		
		var step:Int = Math.floor((_progress * 100) / 8);
		var step2:Int = step % 4;
		//trace("step : " + step + ", step2 : " + step2);
		mask.scaleX = step2 / 3;
		
		
	}
	
	public function loadComplete() 
	{
		var y:Float = loader.y;
		trace("ViewLoader.loadComplete, y : " + y);
		
		Actuate.tween(loader, 0.2, {y: y - 70}).ease(Sine.easeOut);
		Actuate.tween(loader, 0.25, {y: y + 250, alpha:0}, false).ease(Sine.easeIn).delay(0.2);
		
	}
	
	
	
}