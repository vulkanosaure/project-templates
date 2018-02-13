package com.vinc.xtends;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import openfl.ui.Mouse;
import openfl.ui.MouseCursor;
import starling.display.Button;
import starling.display.ButtonState;
import starling.display.DisplayObject;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.textures.Texture;

/**
 * ...
 * @author Vincent Huss
 */
class Button2 extends Button
{
	private static inline var MAX_DRAG_DIST:Null<Float> = 50;
	var theBounds:Rectangle;
	
	public var _clickableMargin:Null<Int>;
	public var _clickableMarginLeft:Null<Int>;
	public var _clickableMarginRight:Null<Int>;
	public var _clickableMarginTop:Null<Int>;
	public var _clickableMarginBottom:Null<Int>;

	public function new(upState:Texture, text:String="", downState:Texture=null,
                        overState:Texture=null, disabledState:Texture=null) 
	{
		super(upState, text, downState, overState, disabledState);
		this.addEventListener(TouchEvent.TOUCH, __onTouch);
		
	}
	
	
	
	override public function hitTest(localPoint:Point, forTouch:Bool = false):DisplayObject 
	{
		//return null;
		//trace("hitTest(" + forTouch + ")");
		if (forTouch && (!visible || !touchable)) return null;
		
		if (theBounds == null){
			theBounds = getBounds(this);
			var _cm:Null<Int> = _clickableMargin == null ? 0 : _clickableMargin;
			theBounds.inflate(_cm, _cm);
			
			if (_clickableMarginLeft != null) theBounds.left -= _clickableMarginLeft;
			if (_clickableMarginRight != null) theBounds.right += _clickableMarginRight;
			if (_clickableMarginTop != null) theBounds.top -= _clickableMarginTop;
			if (_clickableMarginBottom != null) theBounds.bottom += _clickableMarginBottom;
		}
		
		//trace("_cm :" + _cm);
		
		
		
		//return null;		//no lag
		
		if (theBounds.containsPoint(localPoint)) return this;
		
		
		return null;
	}
	
	
	
	
	
	
	
	
	
	private override function __onTouch(event:TouchEvent):Void
    {
		//trace("__onTouch");
		
        Mouse.cursor = (mUseHandCursor && mEnabled && event.interactsWith(this)) ?
        MouseCursor.BUTTON : MouseCursor.AUTO;
		
        
		//responsable 
        var touch:Touch = event.getTouch(this);
		
		//get touch ne ralentit pas
		//c'est la valeur que prend certains touch qui coz le ralentissement.
		
		
		/*
        var touch:Touch = null;
        
		if (this.parent.name == "debugbtn"){
			trace("debug btn");
			mState = ButtonState.DOWN;
			touch = new Touch(0);
			touch.phase = TouchPhase.ENDED;
			touch.cancelled = false;
		}
		*/
		
		
		var isWithinBounds:Bool;
		
		
		
		
		trace("__onTouch mEnabled : " + mEnabled + ", null : " + (touch == null) + ", phase : " + ((touch == null) ? "" : touch.phase) + ", mstate : " + mState);
		

        if (!mEnabled)
        {
            return;
        }
        else if (touch == null)
        {
			if (state != ButtonState.UP) {
				state = ButtonState.UP;
				dispatchEventWith("Button2_TOUCH", true, {state: state, touch: touch});
			}
        }
        else if (touch.phase == TouchPhase.HOVER)
        {
			if (state != ButtonState.OVER) {
				state = ButtonState.OVER;
				dispatchEventWith("Button2_TOUCH", true, {state: state, touch: touch});
			}
        }
        else if (touch.phase == TouchPhase.BEGAN && mState != ButtonState.DOWN)
        {
            mTriggerBounds = getBounds(stage, mTriggerBounds);
            mTriggerBounds.inflate(MAX_DRAG_DIST, MAX_DRAG_DIST);
			
			if (state != ButtonState.DOWN) {
				state = ButtonState.DOWN;
				dispatchEventWith("Button2_TOUCH", true, {state: state, touch: touch});
			}
            
        }
        else if (touch.phase == TouchPhase.MOVED)
        {
            isWithinBounds = mTriggerBounds.contains(touch.globalX, touch.globalY);
			
            if (mState == ButtonState.DOWN && !isWithinBounds)
            {
                // reset button when finger is moved too far away ...
				if (state != ButtonState.UP) {
					state = ButtonState.UP;
					dispatchEventWith("Button2_TOUCH", true, {state: state, touch: touch});
				}
            }
            else if (mState == ButtonState.UP && isWithinBounds)
            {
                //...and reactivate when the finger moves back into the bounds.
				if (state != ButtonState.DOWN) {
					state = ButtonState.DOWN;
					dispatchEventWith("Button2_TOUCH", true, {state: state, touch: touch});
				}
            }
        }
        else if (touch.phase == TouchPhase.ENDED && mState == ButtonState.DOWN)
        {
            state = ButtonState.UP;
            if (!touch.cancelled) dispatchEventWith(Event.TRIGGERED, true);
        }
    }
	
	
}