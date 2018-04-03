package controllers;
import com.vinc.debug.ActionRecorder;
import com.vinc.game.Engine;
import com.vinc.game.StoreItems;
import com.vinc.game.dataprogress.DataProgress;
import com.vinc.game.dataprogress.DataProgressItem;
import com.vinc.math.Math2;
import com.vinc.mvc.ControllerBase;
import com.vinc.mvc.MVCRoot;
import com.vinc.navigation.Navigation;
import com.vinc.patterns.ActionDispatcher;
import com.vinc.sound.SoundManager;
import com.vinc.time.DelayManager;
import game.items.Item;
import openfl.events.TimerEvent;
import openfl.geom.Rectangle;
import openfl.utils.Timer;
import starling.display.Sprite;
import view.ViewEnd;
import view.ViewGame;

/**
 * ...
 * @author Vincent Huss
 */
class ControllerGame extends ControllerBase
{
	var _view:ViewGame;
	
	private static inline var DELAY_SECU:Null<Int> = 100;
	
	private var _lockAction:Bool = true;
	private var _timer:Null<Int>;
	private var _t:Timer;
	
	var _dataProgress:DataProgress;
	var storeItem:StoreItems<Item>;
	private var _nblife:Null<Int>;
	private var _score:Float;
	var multiplicator:Float;
	var _gameover:Bool;
	

	public function new() 
	{
		super();
		
	}
	
	override public function init():Void 
	{
		trace("CtrlGame.init");
		
		super.init();
		
		_view = cast(MVCRoot.getView("screen_game"), ViewGame);
		
		
		//_view.init();
		Engine.addEnterframe("", handleDataProgress, null);
		/*
		Engine.addEnterframe("", handleHeroNavigation, {direction:null});
		Engine.addEnterframe("", handleGlobalAnims, null);
		Engine.addEnterframe("", handleSoundBonus, null);
		*/
		_dataProgress = new DataProgress();
		_dataProgress.feedFunction = feedFunction;
		_dataProgress.feedLength = 5000;
		
		storeItem = new StoreItems();
		
		/*
		ActionDispatcher.listen("left", onNavigate.bind("left"));
		ActionDispatcher.listen("right", onNavigate.bind("right"));
		ActionDispatcher.listen("release", onNavigateRelease);
		ActionDispatcher.listen("catch", onclickAction);
		*/
		
		ActionDispatcher.listen("enterframe", onActionEnterframe);
		
		
	}
	
	
	
	
	public function initGame():Void
	{
		var delayStart:Float = (Constants.DEBUG_MODE) ? 1 : 200;
		trace("CtrlGame.initGame "+delayStart);
		
		//_____________________________________________
		//start recording frames
		
		if(Constants.DEBUG_ACTIONRECORDER){
			Math2.MOCK_RANDOM = true;
			Math2.resetMockRandom();
			ActionRecorder.start(initGame);
		}
		//
		
		_lockAction = true;
		Engine.pause();
		resetAll();
		
		trace("DelayManager.add " + delayStart);
		if (!Constants.DEBUG_MODE) DelayManager.add("", delayStart, _view.startAnimCounter);
		
		if (!Constants.DEBUG_MODE) delayStart += 4800;
		DelayManager.add("", delayStart, startGame);
		
	}
	
	
	
	
	private function resetAll() 
	{
		trace("ControllerGame.resetAll");
		
		
		_view.initGame();
		_nblife = 3;
		_view.displayLife(_nblife);
		
		_score = 0;
		_view.setScore(_score);
		multiplicator = 1;
		_gameover = false;
		
		
		storeItem.foreach(function(item:Item):Void
		{
			removeItem(item);
		});
		storeItem.reset();
		
		_dataProgress.reset();
	}
	
	
	private function startGame():Void
	{
		trace("ControllerGame.startGame");
		Engine.play();
		_lockAction = false;
	}
	
	
	
	
	
	
	private function feedFunction(_indexGeneration:Null<Int>):Array<DataProgressItem>
	{
		trace("feedFunction " + _indexGeneration);
		
		var _counterPeriodicite:Int = 0;
		var _periodicite:Int = 1;
		var _historic:Array<Int> = [];
		
		var output:Array<DataProgressItem> = [];
		for (i in 0...5000){
			_counterPeriodicite++;
			if (_counterPeriodicite == _periodicite){
				
				_periodicite = Math.round(Math2.random(30, 70, 1));
				_counterPeriodicite = 0;
				
				//trace("_periodicite : " + _periodicite);
				
				var _proba:Array<Float> = [
					1,			//TYPE_TARGET1
					1,			//TYPE_TARGET2
					1,			//TYPE_TARGET3
					1,			//TYPE_ENEMY1
					1,			//TYPE_ENEMY2
				];
				
				var _lapInterdictions:Array<Int> = [
					0,			//TYPE_TARGET1
					0,			//TYPE_TARGET2
					0,			//TYPE_TARGET3
					0,			//TYPE_ENEMY1
					0,			//TYPE_ENEMY2
				];
				
				var type:Int = null;
				
				while (true){
					
					type = Math.round(Math2.getRandIndexProbability(_proba));
					
					var _lap:Int = _lapInterdictions[type];
					if (_lap != 0){
						
						var _lastindex:Int = _historic.lastIndexOf(type);
						var _date:Int = _historic.length - _lastindex;
						//trace("_date : " + _date);
						if (_lastindex == -1 || _date >= _lap) break;
						
					}
					else break;
				}
				
				_historic.push(type);
				if (_historic.length > 10) _historic.shift();
				//trace("_h : " + _historic);
				
				
				var x:Int = 0;
				var y:Int = 0;
				
				output.push(new DataProgressItem(i, {type:type, x:x, y:y}));
			}
		}
		
		return output;
	}
	
	
	
	
	private function finishAndNavigate(_winner:Bool):Void
	{
		_gameover = true;
		Engine.pause();
		DelayManager.add("", 500, Navigation.gotoScreen, ["", "screen_gameover", 500]);
		
	}
	
	
	
	override public function preupdate():Void 
	{
		trace("ControllerGame.preupdate");
		initGame();
		
	}
	
	
	private function removeItem(item:Item) 
	{
		trace("removeItem " + item.type);
		storeItem.remove(item);
		_view.removeItem(item);
		item.destroy();
	}
	
	
	
	
	//______________________________________________________________________
	//events
	
	
	
	private function handleDataProgress() 
	{
		//trace("handleDataProgress");
		
		_dataProgress.progress += 1;
		//trace("items.length : " + storeItem.items.length);
		var _newData:Array<DataProgressItem> = _dataProgress.getData();
		for (i in 0..._newData.length){
			
			var data:DataProgressItem = _newData[i];
			trace("new item, type : " + data.data.type);
			
			//var rota:Float = Math2.random( -0.04, 0.04, 0.01);
			
			var item:Item = new Item();
			item.init(data.data.type);
			item.x = data.data.x;
			item.y = data.data.y;
			
			storeItem.add(item);
			_view.addItem(item);
			
		}
		
		
		storeItem.foreach(function(item:Item):Void
		{
			item.step();
			
			
			/*
			
			var limity:Float = 1105;
			
			if (item.active){
				
				//gravity
				
				item.step();
				
				
				
				
				//hit permanent
				
				if (item.type == Item.TYPE_ENEMY1){
					
					var _zoneCatchHit:Rectangle = _view.getZoneHit();
					if (Constants.DEBUG_MODE) _view.drawRect(_zoneCatchHit, 1);
					
					if (_zoneCatchHit.contains(item.x, item.y)){
						
						if (!_invincible){
							
							removeItem(item);
							_view.animPointBonus(item.x, item.y, 0, -1, "error");
							_nblife--;
							_view.displayMalus(_nbmalus);
							SoundManager.play("error");
							
						}
					}
				}
				
				
				//end
				
				if (_nblife == 0){
					
					//gameover
					_lockAction = true;
					
					DelayManager.add("", 500, function():Void
					{
						SoundManager.play("timer_end");
					});
					DelayManager.add("", 1200, function():Void
					{
						finishAndNavigate(false);
					});
				}
				
				
			}
			
			
			if (item.active && item.y >= limity){
				item.active = false;
				
				_view.animPointMalus(item.x, item.y - 130, -10);
				item.y = limity;
				
				_score -= 10;
				_view.setScore(_score);
			}
			*/
			
			
			
			
		});
	}
	
	
	
	public function onActionEnterframe() 
	{
		//trace("onActionEnterframe");
		Engine.update();
	}
	
	
	/*
	
	function onNavigateRelease() 
	{
		//trace("onNavigateRelease");
		Engine.setParam("direction", null);
	}
	
	function onNavigate(side:String) 
	{
		trace("onNavigate(" + side+")");
		Engine.setParam("direction", side);
		
		
	}
	
	
	public function onclickAction() 
	{
		_isCatching = true;
		
		if (Constants.DEBUG_MODE) _view.setCatch(_isCatching);
		
		var _timeCatch:Float = 600;
		_view.animCatch(_timeCatch);
		_view.forceReleaseBtns();
		
		DelayManager.resetGroup("catch");
		DelayManager.add("catch", _timeCatch, function():Void
		{
			_isCatching = false;
			_view.setCatch(_isCatching);
		});
	}
	*/
	
	
	
}