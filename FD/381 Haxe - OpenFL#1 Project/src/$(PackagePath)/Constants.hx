package;
class Constants
{
	/*
    public static inline var GAME_WIDTH:Int  = 1200;
    public static inline var GAME_HEIGHT:Int = 677;
	*/
	public static inline var GAME_WIDTH:Int  = 480;
    public static inline var GAME_HEIGHT:Int = 800;
	
	#if debug
	public static inline var DEBUG_MODE:Bool = true;
	public static inline var DEBUG_NAVIGATION:Bool = true;
	#else
	public static inline var DEBUG_MODE:Bool = false;
	public static inline var DEBUG_NAVIGATION:Bool = false;
	#end
	
	
	
	
	
}