package com.vinc.patterns.redux;
import haxe.Json;
class ObjectUtil {
    public function ObjectUtil() {
    }

    public static function isSimple(o:Dynamic):Bool {
		
		trace("$$ TOCHECK :: isSimple type : " + $type(o));
		return true;
    }

    public static function same(o1:Dynamic, o2:Dynamic):Bool {
        return (Json.stringify(o1) == Json.stringify(o2));
    }
}
