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
	private static inline var MAX_DRAG_DIST:Float = 50;
	
	public var _clickableMargin:Int;
	public var _clickableMarginLeft:Int;
	public var _clickableMarginRight:Int;
	public var _clickableMarginTop:Int;
	public var _clickableMarginBottom:Int;

	public function new(upState:Texture, text:String="", downState:Texture=null,
                        overState:Texture=null, disabledState:Texture=null) 
	{
		super(upState, text, downState, overState, disabledState);
		
	}
	
	
	
	override public function hitTest(localPoint:Point, forTouch:Bool = false):DisplayObject 
	{
		if (forTouch && (!visible || !touchable)) return null;
		
		//trace("hitTest recursiveTouch = false");
		
		var theBounds:Rectangle = getBounds(this);
		var _cm:Int = _clickableMargin == null ? 0 : _clickableMargin;
		theBounds.inflate(_cm, _cm);
		
		//trace("_cm :" + _cm);
		
		if (_clickableMarginLeft != null) theBounds.left -= _clickableMarginLeft;
		if (_clickableMarginRight != null) theBounds.right += _clickableMarginRight;
		if (_clickableMarginTop != null) theBounds.top -= _clickableMarginTop;
		if (_clickableMarginBottom != null) theBounds.bottom += _clickableMarginBottom;
		
		if (theBounds.containsPoint(localPoint)) return this;
		
		this.addEventListener(TouchEvent.TOUCH, __onTouch);
		
		return null;
	}
	
	
	
	
	
	
	private override function __onTouch(event:TouchEvent):Void
    {
        Mouse.cursor = (mUseHandCursor && mEnabled && event.interactsWith(this)) ?
            MouseCursor.BUTTON : MouseCursor.AUTO;
        
        var touch:Touch = event.getTouch(this);
        var isWithinBounds:Bool;

        if (!mEnabled)
        {
            return;
        }
        else if (touch == null)
        {
			if (state != ButtonState.UP) {
				state = ButtonState.UP;
				dispatchEventWith("Button2_TOUCH", true, state);
			}
        }
        else if (touch.phase == TouchPhase.HOVER)
        {
			if (state != ButtonState.OVER) {
				state = ButtonState.OVER;
				dispatchEventWith("Button2_TOUCH", true, state);
			}
        }
        else if (touch.phase == TouchPhase.BEGAN && mState != ButtonState.DOWN)
        {
            mTriggerBounds = getBounds(stage, mTriggerBounds);
            mTriggerBounds.inflate(MAX_DRAG_DIST, MAX_DRAG_DIST);
			
			if (state != ButtonState.DOWN) {
				state = ButtonState.DOWN;
				dispatchEventWith("Button2_TOUCH", true, state);
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
					dispatchEventWith("Button2_TOUCH", true, state);
				}
            }
            else if (mState == ButtonState.UP && isWithinBounds)
            {
                //...and reactivate when the finger moves back into the bounds.
				if (state != ButtonState.DOWN) {
					state = ButtonState.DOWN;
					dispatchEventWith("Button2_TOUCH", true, state);
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