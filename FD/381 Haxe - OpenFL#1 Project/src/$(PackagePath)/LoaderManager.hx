package;
import com.vinc.display.VButton;
import com.vinc.display.VImage;
import haxe.io.Error;
import haxe.Timer;
import openfl.Assets;
import openfl.media.Sound;
import openfl.media.SoundTransform;
import openfl.system.Capabilities;
import starling.text.BitmapFont;
import starling.text.TextField;
import starling.textures.Texture;
import starling.textures.TextureAtlas;
import starling.utils.AssetManager;

/**
 * ...
 * @author Vincent Huss
 */
class LoaderManager
{
	private static var _am:AssetManager;

	public function new() 
	{
		
	}
	
	
	public static function load(onComplete:AssetManager->Void):Void
	{
		var assets:AssetManager = new AssetManager();
		_am = assets;
		
        assets.verbose = Capabilities.isDebugger;
		
		VButton.assets = assets;
		VImage.assets = assets;
		
		
		
		var listAtlas:Array<String> = ["atlas-game-0"];
		
		var listSounds:Array<String> = [
			//"sound.mp3",
		];
		
		var listSoundPreload:Array<String> = [
			//"sound",
		];
		
		
        Timer.delay(function()
        {
            //atlas
			
			for (_atlasname in listAtlas) {
				
				var atlasTexture:Texture = Texture.fromBitmapData(Assets.getBitmapData("assets/atlas/"+_atlasname+".png"), false);
				var atlasXml:Xml = Xml.parse(Assets.getText("assets/atlas/" + _atlasname+".xml")).firstElement();
				
				assets.addTexture(_atlasname, atlasTexture);
				assets.addTextureAtlas(_atlasname, new TextureAtlas(atlasTexture, atlasXml));
				
			}
			
			
			
			//fonts
			
            var _fontTexture:Texture = Texture.fromBitmapData(Assets.getBitmapData("assets/fonts/font_0.png"), false);
            var _fontXml:Xml = Xml.parse(Assets.getText("assets/fonts/font.fnt")).firstElement();
            TextField.registerBitmapFont(new BitmapFont(_fontTexture, _fontXml), "font_counter");
			
			
			
			
			//sounds
			
			for (sound in listSounds) {
				
				var tab:Array<String> = sound.split(".");
				var idsound:String = tab[0];
				assets.addSound(idsound, Assets.getSound("assets/sounds/"+sound));
			}
			
			
			//probleme de delai du sound
			
			for (sound in listSoundPreload) {
				var _sound:Sound = assets.getSound(sound);
				var _soundTransform:SoundTransform = new SoundTransform(0);
				_sound.play(0, 0, _soundTransform);
			}
			
			
            
            onComplete(assets);
        }, 0);
		
	}
	
	public static function am():AssetManager 
	{
		return _am;
	}
	
	
	
	
	
}