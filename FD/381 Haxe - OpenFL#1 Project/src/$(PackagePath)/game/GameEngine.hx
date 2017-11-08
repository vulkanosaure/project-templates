package game;
import com.vinc.common.BroadCaster;
import openfl.display.Stage;
import starling.display.Sprite;
import starling.events.Event;


/**
 * ...
 * @author Vincent Huss
 */
class GameEngine
{
	private var _container:Sprite;
	var _openflstage:Stage;
	
	var _started:Bool;
	var _waitingstart:Bool;
	var _isgameover:Bool;
	
	//var _containerScroll:QuadBatch;
	var _cameraContainer:Sprite;
	var _nbpts:Int;
	
	
	
	public function new(__openflstage:Stage, __container:Sprite) 
	{
		_container = __container;
		_openflstage = __openflstage;
		
		_cameraContainer = new Sprite();
		_container.addChild(_cameraContainer);
		
		
		_container.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		/*
		_containerScroll = new QuadBatch();
		_cameraContainer.addChild(_containerScroll);
		*/
		
		_waitingstart = true;
		
		stop();
	}
	
	
	
	public function getScore():Int
	{
		return _nbpts;
	}
	
	public function isStarted():Bool
	{
		return _started;
	}
	
	
	
	public function reset() 
	{
		_waitingstart = true;
		_isgameover = false;
		_nbpts = 0;
		BroadCaster.dispatchEvent(new Event("COUNTER", false, _nbpts));
		
	}
	
	
	public function start():Void
	{
		reset();
		_started = true;
		_waitingstart = false;
		_isgameover = false;
	}
	public function stop():Void
	{
		_started = false;
	}
	
	public function isGameOver() 
	{
		return _isgameover;
	}
	
	
	
	private function enterFrameHandler(e:Event):Void 
	{
		//trace("GameEngine.enterFrameHandler");		
		
		if (!_waitingstart) {
			if (_started) {
				//_cameraContainer.x -= SPEED_CAMERA;
				
			}
			
		}
		else {
			//placer un eventuel ralenti de fin de timer ici
			
		}
	}
	
	
}