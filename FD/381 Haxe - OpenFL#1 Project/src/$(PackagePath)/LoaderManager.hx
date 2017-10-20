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
		
		
        Timer.delay(function()
        {
            
            var atlasTexture:Texture = Texture.fromBitmapData(Assets.getBitmapData("assets/atlas/atlas-game-0.png"), false);
            var atlasXml:Xml = Xml.parse(Assets.getText("assets/atlas/atlas-game-0.xml")).firstElement();
			
			
            var _fontTexture:Texture = Texture.fromBitmapData(Assets.getBitmapData("assets/fonts/flappyfont_0.png"), false);
            var _fontXml:Xml = Xml.parse(Assets.getText("assets/fonts/flappyfont.fnt")).firstElement();
            var _fontXmlScore:Xml = Xml.parse(Assets.getText("assets/fonts/flappyfont-score.fnt")).firstElement();
            TextField.registerBitmapFont(new BitmapFont(_fontTexture, _fontXml), "font_counter");
            TextField.registerBitmapFont(new BitmapFont(_fontTexture, _fontXmlScore), "font_score");
			//
			
			
            var _fontText2:Texture = Texture.fromBitmapData(Assets.getBitmapData("assets/fonts/flappyfont-raking_0.png"), false);
            var _fontXml2:Xml = Xml.parse(Assets.getText("assets/fonts/flappyfont-raking.fnt")).firstElement();
            TextField.registerBitmapFont(new BitmapFont(_fontText2, _fontXml2), "font_ranking");
			
			
			
			//
			
			
            assets.addTexture("atlas", atlasTexture);
            assets.addTextureAtlas("atlas", new TextureAtlas(atlasTexture, atlasXml));
            
			assets.addSound("wing_flap", Assets.getSound("assets/audio/wing_flap.mp3"));
			assets.addSound("counter", Assets.getSound("assets/audio/counter.mp3"));
			assets.addSound("fall", Assets.getSound("assets/audio/fall.mp3"));
			assets.addSound("hit", Assets.getSound("assets/audio/hit.mp3"));
			assets.addSound("navigate", Assets.getSound("assets/audio/navigate.mp3"));
			
			
			//probleme de delai du sound
			var _sound:Sound = assets.getSound("counter");
			var _soundTransform:SoundTransform = new SoundTransform(0);
			_sound.play(0, 0, _soundTransform);
			
			var _sound:Sound = assets.getSound("hit");
			var _soundTransform:SoundTransform = new SoundTransform(0);
			_sound.play(0, 0, _soundTransform);
			
			var _sound:Sound = assets.getSound("fall");
			var _soundTransform:SoundTransform = new SoundTransform(0);
			_sound.play(0, 0, _soundTransform);
            
            onComplete(assets);
        }, 0);
		
	}
	
	public static function am():AssetManager 
	{
		return _am;
	}
	
	
	
	
	
}