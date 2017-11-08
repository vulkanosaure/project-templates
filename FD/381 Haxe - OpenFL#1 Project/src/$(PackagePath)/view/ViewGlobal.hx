package view;
import com.vinc.common.ObjectSearch;
import com.vinc.display.text.VText;
import com.vinc.layout.LayoutManager;
import com.vinc.layout.LayoutSprite;
import com.vinc.mvc.MVCRoot;
import com.vinc.mvc.ViewBase;
import starling.display.ButtonState;
import starling.display.Sprite;
import ui.VButton1;

/**
 * ...
 * @author Vincent Huss
 */
class ViewGlobal extends ViewBase
{
	var btn_sound_off:VButton1;
	var btn_sound_on:VButton1;
	var btn_close:VButton1;

	public function new()
	{
		super();
	}

	override public function construct():Void
	{
		trace("ViewGlobal.construct.");
		
		var container:Sprite = Vars.containerBG;

		//______________________________________________
		//header

		container = Vars.containerFG;
		
		
		
		
		var header:LayoutSprite = new LayoutSprite();
		container.addChild(header);
		header.idLayout = "header";
		LayoutManager.addItem(header, {});
		ObjectSearch.registerID(header, "header");
		

		var btn_sound:LayoutSprite = new LayoutSprite();
		header.addChild(btn_sound);
		btn_sound.idLayout = "btn_sound";
		LayoutManager.addItem(btn_sound, {"margin-right" : 140, "margin-top" : 30});
		ObjectSearch.registerID(btn_sound, "btn_sound");

		btn_sound_off = new VButton1("interface/btn_sound_off");
		btn_sound.addChild(btn_sound_off);
		btn_sound_off.clickHandler = MVCRoot.getController("screen_global").onclick;
		btn_sound_off.idLayout = "btn_sound_off";

		btn_sound_on = new VButton1("interface/btn_sound_on");
		btn_sound.addChild(btn_sound_on);
		btn_sound_on.clickHandler = MVCRoot.getController("screen_global").onclick;
		btn_sound_on.idLayout = "btn_sound_on";

		ObjectSearch.registerID(header, "header_title");

		var txt_426:VText = new VText(StylesText.SDSans_FillOne_2A7DC0_70);
		header.addChild(txt_426);
		txt_426.idLayout = "txt_426";
		LayoutManager.addItem(txt_426, {"margin-left" : 30, "margin-top" : 30});
		txt_426.text = "MEMORY";
		txt_426.textWidth = 550;
		txt_426.init();

		var txt_427:VText = new VText(StylesText.FontboxJeronimoBouncy_FFFFFF_38);
		header.addChild(txt_427);
		txt_427.idLayout = "txt_427";
		LayoutManager.addItem(txt_427, {"margin-left" : 32, "margin-top" : 104});
		txt_427.text = "TRAVAILLE TA MÉMOIRE AVEC ONSFAN LAPOIRE";
		txt_427.textWidth = 450;
		txt_427.init();

		ObjectSearch.registerID(txt_426, "header_title1");
		ObjectSearch.registerID(txt_427, "header_title2");

		btn_close = new VButton1("interface/btn_close");
		header.addChild(btn_close);
		btn_close.idLayout = "btn_close";
		LayoutManager.addItem(btn_close, {"margin-right" : 30, "margin-top" : 30});
		btn_close.clickHandler = MVCRoot.getController("screen_global").onclick;
		ObjectSearch.registerID(btn_close, "btn_close");
		
		
		
		
		

	}

	public function updateBtnSound(soundOn:Bool)
	{
		
		btn_sound_on.visible = !soundOn;
		btn_sound_off.visible = soundOn;
	}
	
	public function resetBtns() 
	{
		btn_close.updateState(ButtonState.UP);
	}

}