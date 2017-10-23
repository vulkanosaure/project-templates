package game.assets;
import openfl.events.TimerEvent;
import openfl.geom.Point;
import openfl.utils.Timer;
import openfl.Vector;
import starling.core.Starling;
import starling.display.MovieClip;
import starling.display.Sprite;
import starling.events.Event;
import starling.textures.Texture;

/**
 * ...2
 * @author Vincent Huss
 */
class HeroAsset extends Sprite
{
	static public var DIMENSION:Point = new Point(57, 39);
	static private inline var NB_FRAME:Int = 3;
	
	private var _playing:Bool;
	private var _way:Int;
	var _mc:MovieClip;
	var _timer:Timer;

	public function new() 
	{
		super();
		
        var _frames:Vector<Texture> = LoaderManager.am().getTextures("game/hero");
		trace("_frames len : " + _frames.length);
		_mc = new MovieClip(_frames);
		_mc.fps = 4;
		
		_mc.x = -Math.round(DIMENSION.x / 2);
		_mc.y = -Math.round(DIMENSION.y / 2);
		
		addChild(_mc);
		_mc.stop();
		Starling.current.juggler.add(_mc);
		
		/*
		_timer = new Timer(500);
		_timer.addEventListener(TimerEvent.TIMER, onTimer);
		_timer.start();
		*/
		
		_playing = false;
		
		//this.addEventListener(Event.ENTER_FRAME, onEnterframe);
		
		
	}
	
	
	
	
	
}