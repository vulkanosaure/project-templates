package;
import com.vinc.sound.SoundManager;
import haxe.Timer;
import openfl.Assets;
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
	
	
	
	
	private static var onPreloadCompleteHandler:AssetManager->Void;
	
	private static var onCompleteHandler:AssetManager->Void;
	private static var onProgressHandler:Float->Void;
	
	static private var assets:AssetManager;
	
	
	
	
	private static function filterTab(tab:Array<String>, prefixes:Array<String>, bInclude:Bool):Array<String>
	{
		var output:Array<String> = [];
		
		for (str in tab){
			if (bInclude){
				for (prefix in prefixes){
					var prefixlen:Int = prefix.length;
					if (str.substr(0, prefixlen) == prefix){
						output.push(str);
						break;
					}
				}
				
				
			}
			else{
				var bcontain:Bool = false;
				for (prefix in prefixes){
					var prefixlen:Int = prefix.length;
					if (str.substr(0, prefixlen) == prefix){
						bcontain = true;
						break;
					}
				}
				if (!bcontain) output.push(str);
			}
			
		}
		
		return output;
	}
	
	
	
	
	//load asset for preloader
	
	public static function preload(_onCompleteHandler:AssetManager->Void, rootPath:String):Void
	{
		onPreloadCompleteHandler = _onCompleteHandler;
		
		assets = new AssetManager();
		_am = assets;
		assets.verbose = Constants.DEBUG_MODE;
		
		var list:Array<String> = filterTab(Assets.list(), ["assets/preload/"], true);
		
		list = list.map(function(value){
			if (rootPath == "") return value;
			else return rootPath + "/" + value;
		});
		
		trace("list preload");
		trace(list);
		
		assets.enqueue(list);
		assets.loadQueue(preloadProgress);
		
		
	}
	
	private static function preloadProgress(_ratio:Float):Void
	{
		//trace("preloadProgress(" + _ratio + ")");
		if (_ratio == 1.0){
			preloadComplete();
		}
	}
	
	private static function preloadComplete():Void
	{
		trace("preloadComplete");
		onPreloadCompleteHandler(assets);
		
	}
	
	
	
	public static function load(_onCompleteHandler:AssetManager->Void, _onProgressHandler:Float->Void, rootPath:String):Void
	{
		onCompleteHandler = _onCompleteHandler;
		onProgressHandler = _onProgressHandler;
		
		//assets.enqueue
		var list:Array<String> = filterTab(Assets.list(), ["assets/preload/", "assets/sounds/"], false);
		trace("list 2 : " + list);
		
		list = list.map(function(value){
			if (rootPath == "") return value;
			else return rootPath + "/" + value;
		});
		
		assets.enqueue(list);
		assets.loadQueue(loadProgress);
		
	}
	
	private static function loadProgress(_ratio:Float):Void
	{
		onProgressHandler(_ratio);
		if (_ratio == 1.0){
			trace("-- COMPLETE");
			loadComplete();
		}
	}
	
	private static function loadComplete():Void
	{
		trace("loadComplete");
		initAssets();
	}
	
	
	
	
	public static function initAssets():Void
	{
		trace("initAssets"); 
		
		
		var list:Array<String> = filterTab(Assets.list(), ["assets/sounds/"], true);
		trace("list sound : " + list);
		
		var len = list.length;
		for (i in 0...len){
			var url:String = list[i];
			var tab:Array<String> = url.split("/");
			var id:String = tab[tab.length - 1];
			tab = id.split(".");
			id = tab[0];
			trace("addSound(" + id + ", " + url + ")");
			SoundManager.addSound(id, url, true);
			
		}
		
		
        Timer.delay(function()
        {
			//probleme de delai du sound
			//todo : check si tjs nécéssaire
			
			/*
			for (sound in listSoundPreload) {
				var _sound:Sound = assets.getSound(sound);
				var _soundTransform:SoundTransform = new SoundTransform(0);
				_sound.play(0, 0, _soundTransform);
			}
			*/
			
            onCompleteHandler(assets);
        }, 0);
		
		
		
	}
	
	public static function am():AssetManager 
	{
		return _am;
	}
	
	
	
	
	
}