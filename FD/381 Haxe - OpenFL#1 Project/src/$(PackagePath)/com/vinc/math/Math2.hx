package com.vinc.math;


class Math2 {
	
	
	public static var MOCK_RANDOM:Bool = false;
	public static var MOCK_RANDOM_SEQ:Array<Float> = [0.0, 0.54, 0.2, 0.13, 0.4, 0.93, 0.6, 0.35, 0.8, 0.05, 0.99, 0.12, 0.5, 0.4, 0.72, 0.11, 0.13, 0.66, 
	0.51, 0.91, 0.99, 0.72, 0.15, 0.18, 0.32, 0.29, 0.55, 0.45, 0.85, 0.48, 0.19, 0.26, 0.31, 0.82, 0.72, 0.51, 0.81, 0.67, 0.53, 0.82, 0.51, 0.91, 0.54, 
	0.12, 0.53, 0.59, 0.19, 0.71, 0.91, 0.75, 0.88, 0.64, 0.13, 0.61, 0.23, 0.55];
	
	
	
	public function new()
	{
		
	}
	
	
	//_____________________________________________________________________________
	//trigo
	
	static public function getTrigoCoord(_coord:String, angle:Null<Float>, rayon:Null<Float>, useDegre:Bool=false):Null<Float>
	{
		if(_coord!="x" && _coord!="y") throw "Math2.getTrigoCoord(), value must be 'x' or 'y' for arg 1";
		if(useDegre) angle = angle*Math.PI/180;
		var retour:Null<Float> = null;
		if(_coord=="x") retour = Math.cos(angle)*rayon;
		else if(_coord=="y") retour = Math.sin(angle)*rayon;
		return retour;
	}
	
	
	//todo : a améliorer pour la gestion des exceptions
	static public function getAngle2pt(x_start:Null<Float>, y_start:Null<Float>, x_end:Null<Float>, y_end:Null<Float>, useDegre:Bool=false):Null<Float>
	{
		var dx:Null<Float> = x_end-x_start;
		var dy:Null<Float> = y_end-y_start;
		var angle:Null<Float> = Math.atan2(dy, dx);
		if(useDegre) angle = angle * 180/Math.PI;
		return angle;
	}
	
	
	
	//tothink
	//le sens est ici important, eventuellement, param qui se fiche du sens -> result %180
	static public function getAngle3pt(x1:Null<Float>, y1:Null<Float>, x2:Null<Float>, y2:Null<Float>, x3:Null<Float>, y3:Null<Float>, witch:Null<Float>=0, useDegre:Bool=false):Null<Float>
	{
		var ax:Null<Float>, ay:Null<Float>, bx:Null<Float>, by:Null<Float>, cx:Null<Float>, cy:Null<Float>;
		ax = null;
		ay = null;
		bx = null;
		by = null;
		cx = null;
		cy = null;
		if(witch==0){
			ax = x1;
			ay = y1;
			bx = x2;
			by = y2;
			cx = x3;
			cy = y3;
		}
		else if(witch==1){
			ax = x2;
			ay = y2;
			bx = x1;
			by = y1;
			cx = x3;
			cy = y3;
		}
		else if(witch==2){
			ax = x3;
			ay = y3;
			bx = x1;
			by = y1;
			cx = x2;
			cy = y2;
		}
		
		var a1:Null<Float> = getAngle2pt(ax, ay, bx, by, useDegre);
		var a2:Null<Float> = getAngle2pt(ax, ay, cx, cy, useDegre);
		var result:Null<Float> = (a1 - a2);
		while(result<0) result += (useDegre) ? 360 : Math.PI*2;
		return result;
	}
	
	
	
	static public function getHypotenuse(x1:Null<Float>, y1:Null<Float>, x2:Null<Float>, y2:Null<Float>): Float
	{
		var dx:Null<Float> = x2-x1;
		var dy:Null<Float> = y2-y1;
		return Math.sqrt(Math.pow(dx,2)+Math.pow(dy,2));
	}
	
	
	
	
	//calcul la hauteur d'un triangle issu du point désigné par l'argument witch
	static public function getTriangleHeight(x1:Null<Float>, y1:Null<Float>, x2:Null<Float>, y2:Null<Float>, x3:Null<Float>, y3:Null<Float>, witch:Null<Float>=0):Null<Float>
	{
		var ax:Null<Float>, ay:Null<Float>, bx:Null<Float>, by:Null<Float>, cx:Null<Float>, cy:Null<Float>;
		ax = null;
		ay = null;
		bx = null;
		by = null;
		cx = null;
		cy = null;
		if(witch==0){
			ax = x1;
			ay = y1;
			bx = x2;
			by = y2;
			cx = x3;
			cy = y3;
		}
		else if(witch==1){
			ax = x2;
			ay = y2;
			bx = x3;
			by = y3;
			cx = x1;
			cy = y1;
		}
		else if(witch==2){
			ax = x3;
			ay = y3;
			bx = x2;
			by = y2;
			cx = x1;
			cy = y1;
		}
		
		var angle:Null<Float> = Math2.getAngle3pt(ax, ay, bx, by, cx, cy, 1, false);
		var hypotenuse:Null<Float> = Math2.getHypotenuse(ax, ay, bx, by);
		//sinus(anglB) = h / hypotenuse (SOH)
		var result:Null<Float> = Math.sin(angle) * hypotenuse;
		return result;
	}
	
	
	
	
	
	
	
	
	
	
	
	//_____________________________________________________________________________
	//arrondis
	
	static public function floor(nb:Null<Float>, inc:Null<Float>):Null<Float>
	{
		if(inc <= 0) throw "Math2.floor(), inc must be > than 0";
		var retour:Null<Float> = Math.floor(nb/inc) * inc;
		return retour;
	}
	
	static public function round(nb:Null<Float>, inc:Null<Float>):Null<Float>
	{
		if(inc <= 0) throw "Math2.floor(), inc must be > than 0";
		var retour:Null<Float> = Math.round(nb/inc) * inc;
		return retour;
	}
	
	static public function ceil(nb:Null<Float>, inc:Null<Float>):Null<Float>
	{
		if(inc <= 0) throw "Math2.floor(), inc must be > than 0";
		var retour:Null<Float> = Math.ceil(nb/inc) * inc;
		return retour;
	}
	
	
	
	
	
	
	
	//_____________________________________________________________________________
	//random
	
	static public function random(min:Null<Float>, max:Null<Float>, inc:Null<Float>=1):Null<Float>
	{
		if (inc <= 0) throw "Math2.floor(), inc must be > than 0";
		
		var rand:Float;
		if (!MOCK_RANDOM) rand = Math.random();
		else rand = getMockRandom();
		
		var retour:Null<Float> = Math2.floor(rand * (max-min+inc) + min, inc);
		return retour;
	}
	
	static private var counterMockRandom:Int = 0;
	static private function getMockRandom() :Float
	{
		var output:Float = MOCK_RANDOM_SEQ[counterMockRandom];
		counterMockRandom++;
		if (counterMockRandom >= MOCK_RANDOM_SEQ.length) counterMockRandom = 0;
		return output;
	}
	
	static public function random_input(min:Null<Float>, max:Null<Float>, inc:Null<Float>, input:Null<Float>):Null<Float>
	{
		if(inc <= 0) throw "Math2.floor(), inc must be > than 0";
		
		
		var _nbsoluce:Null<Float> = (max - min) / inc;
		//trace("random_input _nbsoluce : " + _nbsoluce);
		_nbsoluce = Math.round(_nbsoluce) + 1;
		var _rest:Null<Float> = input % _nbsoluce;
		var _output:Null<Float> = min + _rest * inc;
		return _output;
	}
	
	
	
	static public function getAverage(_valueA:Null<Float>, _valueB:Null<Float>, _coeffA:Null<Float>, _coeffB:Null<Float>):Null<Float> 
	{
		var _total:Null<Float> = _valueA * _coeffA + _valueB * _coeffB;
		var _divide:Null<Float> = _coeffA + _coeffB;
		return _total / _divide;
	}
	
	
	static public function getRandProbability(_frequency:Null<Float>):Bool
	{
		if (_frequency <= 0) return false;
		if (_frequency >= 1) return true;
		
		var _denom:Null<Float> = Math2.round((1 / _frequency), 0.1);
		var _rand:Null<Float> = Math2.random(0, _denom, 0.1);
		return (_rand < 1);
	}
	
	
	static private var _counterProbabilityOrder:Null<Float> = 0;
	static public function getRandProbabilityOrder(_frequency:Null<Float>):Bool
	{
		if (_frequency <= 0) return false;
		if (_frequency >= 1) return true;
		
		var _denom:Null<Float> = Math2.round((1 / _frequency), 0.1);
		
		//trace("_counterProbabilityOrder : " + _counterProbabilityOrder);
		_counterProbabilityOrder += 1;
		if (_counterProbabilityOrder >= _denom) {
			_counterProbabilityOrder = 0;
			return true;
		}
		else return false;
	}
	
	
	
	
	static public function getProgressionValue(_input:Null<Float>, _minsrc:Null<Float>, _maxsrc:Null<Float>, _mindst:Null<Float>, _maxdst:Null<Float>, _boundMin:Bool = true, _boundMax:Bool = true):Null<Float>
	{
		var _percentinput:Null<Float> = (_input - _minsrc) / (_maxsrc - _minsrc);
		if (_boundMin && _percentinput < 0) _percentinput = 0;
		if (_boundMax && _percentinput > 1) _percentinput = 1;
		var _output:Null<Float> = _mindst + (_maxdst - _mindst) * _percentinput;
		return _output;
	}
	
	
	
	static public function getRandIndexProbability(_freqs:Array<Float>):Null<Int> 
	{
		//on remplit un array avec les index de frequences
		var _sum:Null<Float> = sum(_freqs);
		
		var _nbelmt:Null<Int> = 1000;
		var _indexes:Array<Int> = new Array();
		
		var _nbfreq:Null<Int> = _freqs.length;
		for (i in 0..._nbfreq) 
		{
			var _freq:Null<Float> = _freqs[i];
			var _space:Null<Float> = _freq / _sum * _nbelmt;
			var _spaceint:Null<Int> = Std.int(_space);
			//trace("_space : " + _space);
			for (j in 0..._spaceint) _indexes.push(i);
			
		}
		
		//trace("len after : " + _indexes.length);
		var _index:Null<Float> = random(0, _indexes.length - 1, 1);
		
		return _indexes[Std.int(_index)];
		
	}
	
	
	
	
	static public function roundFromList(_value:Null<Float>, _list:Array<Float>):Null<Float> 
	{
		//todo : chercher la valeur de list pour laquelle ya le moins de distance
		var _mindist:Null<Float> = -1;
		var _index:Null<Int> = -1;
		var _len:Null<Int> = _list.length;
		for (i in 0..._len)
		{
			var _delta:Null<Float> = Math.abs(_list[i] - _value);
			if (_mindist == -1 || _delta < _mindist) {
				_mindist = _delta;
				_index = i;
			}
		}
		return _list[_index];
		
	}
	
	
	
	
	static public function sum(_list:Array<Float>):Null<Float>
	{
		var _output:Null<Float> = 0;
		var _len:Null<Int> = _list.length;
		for (i in 0..._len) _output += _list[i];
		return _output;
	}
	
	
	static public function flatSin(v:Null<Float>) :Null<Float>
	{
		v += Math.PI / 2;
		var radianvalue:Null<Float> = v / Math.PI;		
		var output:Null<Float>;
		var pair:Bool = (Math.floor(radianvalue) % 2 == 0);
		var decimal:Null<Float> = radianvalue % 1;
		if (!pair) decimal = 1 - decimal;
		output = decimal * 2 - 1;
		//trace("flatSin, " + radianvalue + ", " + decimal+", pair : "+pair);
		return output;
	}
	
	static public function flatSinMixed(v:Null<Float>, coeffFlat:Null<Float>):Null<Float>
	{
		var v_flat:Null<Float> = flatSin(v);
		var v_sin:Null<Float> = Math.sin(v);
		
		var output:Null<Float> = getAverage(v_flat, v_sin, coeffFlat, 1 - coeffFlat);
		return output;
	}
	
	
	
	
	//___________________________________________________________________________________
	//bézier
	
	
	static public function quadraticFunction(_p0:Null<Float>, _p1:Null<Float>, _p2:Null<Float>, _t:Null<Float>):Null<Float> 
	{
		var _output:Null<Float>;
		_output = _p0 * Math.pow(1 - _t, 2) + 2 * _p1 * _t * (1 - _t) + Math.pow(_t, 2) * _p2;
		return _output;
	}
	
	static public function cubicFunction(_p0:Null<Float>, _p1:Null<Float>, _p2:Null<Float>, _p3:Null<Float>, _t:Null<Float>):Null<Float> 
	{
		var _output:Null<Float>;
		_output = _p0 * Math.pow(1 - _t, 3) + 3 * _p1 * _t * Math.pow(1 - _t, 2) + 3 * _p2 * Math.pow(_t, 2) * (1 - _t) + _p3 * Math.pow(_t, 3);
		return _output;
	}
	
	static public function resetMockRandom() 
	{
		counterMockRandom = 0;
	}
	
	
	
	
}
