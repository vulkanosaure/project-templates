package view;
import com.vinc.common.ObjectSearch;
import com.vinc.display.VImage;
import com.vinc.display.text.VText;
import com.vinc.layout.LayoutManager;
import com.vinc.layout.LayoutSprite;
import com.vinc.mvc.MVCRoot;
import com.vinc.mvc.ViewBase;
import starling.display.Sprite;
import ui.VButton1;

/**
 * ...
 * @author Vincent Huss
 */
class ViewHome extends ViewBase
{

	public function new() 
	{
		super();
	}
	
	
	override public function construct():Void 
	{
		//______________________________________________
		//container-end
		
		
		var container:Sprite = Vars.containerFG;
		
		
		var container_end:LayoutSprite = new LayoutSprite();
		container.addChild(container_end);
		container_end.idLayout = "container_end";
		LayoutManager.addItem(container_end, {"width":"100%"});
		ObjectSearch.registerID(container_end, "screen_home");
		
		
		var zone_top:LayoutSprite = new LayoutSprite();
		container_end.addChild(zone_top);
		zone_top.idLayout = "zone_top";
		ObjectSearch.registerID(zone_top, "zone_top");
		LayoutManager.addItem(zone_top, {"center-h" : 0.5, "center-v" : 0.22});
		
		var text_end:VImage = new VImage("game/text-end");
		zone_top.addChild(text_end);
		text_end.idLayout = "text_end";
		LayoutManager.addItem(text_end, {"margin-top" : 17});
		
		var mascotte_end:VImage = new VImage("game/mascotte-end");
		zone_top.addChild(mascotte_end);
		mascotte_end.idLayout = "mascotte_end";
		LayoutManager.addItem(mascotte_end, {"margin-left" : 193});
		
		zone_top.touchable = false;
		
		
		
		
		var footer:LayoutSprite = new LayoutSprite();
		container_end.addChild(footer);
		footer.idLayout = "footer";
		LayoutManager.addItem(footer, {"center-h" : 0.5, "center-v" : 0.93, "width" : 702, "height" : 474});
		ObjectSearch.registerID(footer, "footer");
		
		
		var btn_quit:VButton1 = new VButton1("game/bg-btn-big");
		footer.addChild(btn_quit);
		btn_quit.idLayout = "btn_quit";
		LayoutManager.addItem(btn_quit, {"margin-left" : 359, "margin-top" : 125});
		btn_quit.clickHandler = MVCRoot.getController("screen_home").onclick;
		
		
		var txt_420:VText = new VText(StylesText.SDSans_FillOne_EA6323_80);
		btn_quit.addChild(txt_420);
		txt_420.y = 114;
		txt_420.text = "RETOUR";
		txt_420.textWidth = 340;
		txt_420.init();
		
		var txt_420a:VText = new VText(StylesText.SDSans_FillOne_EA6323_45);
		btn_quit.addChild(txt_420a);
		txt_420a.y = 179;
		txt_420a.text = "AUX JEUX";
		txt_420a.textWidth = 340;
		txt_420a.init();
		
		
		
		
		var btn_replay:VButton1 = new VButton1("game/bg-btn-big");
		footer.addChild(btn_replay);
		btn_replay.idLayout = "btn_replay";
		LayoutManager.addItem(btn_replay, {"margin-top" : 125});
		btn_replay.clickHandler = MVCRoot.getController("screen_home").onclick;
		
		var txt_420b:VText = new VText(StylesText.SDSans_FillOne_EA6323_80);
		btn_replay.addChild(txt_420b);
		txt_420b.y = 114;
		txt_420b.text = "REJOUE";
		txt_420b.textWidth = 340;
		txt_420b.init();
		
		var txt_420c:VText = new VText(StylesText.SDSans_FillOne_EA6323_45);
		btn_replay.addChild(txt_420c);
		txt_420c.y = 179;
		txt_420c.text = "AU JEU";
		txt_420c.textWidth = 340;
		txt_420c.init();
		
		
		
		var text_timeup:VText = new VText(StylesText.SDSans_FillOne_2A7DC0_50);
		footer.addChild(text_timeup);
		text_timeup.idLayout = "text_timeup";
		LayoutManager.addItem(text_timeup, {"margin-left" : 0, "margin-top" : 55});
		text_timeup.text = "LE TEMPS EST ÉCOULÉ";
		text_timeup.textWidth = 700;
		text_timeup.init();
		
		
		var gfx_421:VImage = new VImage("game/gfx-421");
		footer.addChild(gfx_421);
		gfx_421.idLayout = "gfx_421";
		LayoutManager.addItem(gfx_421, {"margin-left" : 289});
		gfx_421.touchable = false;
		
		
		
		
	}
	
	
	
	
}