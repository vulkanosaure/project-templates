package;
class Constants
{
	public static inline var GAME_WIDTH:Int  = 750;
    public static inline var GAME_HEIGHT:Int = 1334;
	public static var LOCALHOST:Bool = true;
	
	#if debug
	public static inline var DEBUG_MODE:Bool = true;
	public static inline var DEBUG_TEXT:Bool = true;
	public static inline var DEBUG_NAVIGATION:Bool = true;
	static public inline var DEBUG_ACTIONRECORDER:Bool = true;
	public static inline var SCREEN_INIT:String = "screen_game";
	#else
	public static inline var DEBUG_MODE:Bool = false;
	public static inline var DEBUG_TEXT:Bool = false;
	public static inline var DEBUG_NAVIGATION:Bool = false;
	static public inline var DEBUG_ACTIONRECORDER:Bool = false;
	public static inline var SCREEN_INIT:String = "screen_home";
	#end
	
	
	
	
}