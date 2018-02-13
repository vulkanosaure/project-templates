package com.vinc.patterns.redux;
import com.vinc.patterns.Action;

class Store {

    public static inline var ACTION_INITIALIZE:String = 'faux:initialize';

    private var state:Dynamic;
    private var subscribers:Array<Dynamic->Void>;

    private var reducer:Reducer;
	
	
	

    public function new(reducer:Reducer, initialState:Dynamic = null) {
        this.reducer = reducer;
        this.state = reducer.reduce(initialState, new Action(ACTION_INITIALIZE));
        this.subscribers = [];
    }

    public function setState(state:Dynamic):Void {
        if (this.state == state) return;
        this.state = state;
		for (func in this.subscribers) func(this.state);
    }
	
	
	public function testMock():Void
	{
		trace("print testMock");
	}
	

    public function getState():Dynamic {
        return this.state;
    }
	
	
	
    public function dispatch(action:Dynamic):Void {
		
		//could not simulate applyMiddleware behaviour so i just implement thunk here
		var typename:String = Type.typeof(action).getName();
		
		if (typename == "TFunction"){
			action(dispatch, getState);
		}
		else{
			setState(reducer.reduce(getState(), action));			
		}
    }
	
	
	

    public function subscribe(subscriber:Dynamic->Void):Void {
        this.subscribers.push(subscriber);
    }
	
	
	
	//not used
	
    public function mergeState(state:Dynamic):Void {
        
		throw "check this function mergeState";
		setState(Lambda.concat(this.getState(), state));
    }
}
