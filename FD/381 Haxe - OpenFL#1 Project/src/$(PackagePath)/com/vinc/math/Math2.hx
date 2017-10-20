package com.vinc.math;

import openfl.errors.Error;

class Math2 {
	
	
	
	public function new()
	{
		
	}
	
	
	//_____________________________________________________________________________
	//trigo
	
	static public function getTrigoCoord(_coord:String, angle:Float, rayon:Float, useDegre:Bool=false):Float
	{
		if(_coord!="x" && _coord!="y") throw new Error("Math2.getTrigoCoord(), value must be 'x' or 'y' for arg 1");
		if(useDegre) angle = angle*Math.PI/180;
		var retour:Float = null;
		if(_coord=="x") retour = Math.cos(angle)*rayon;
		else if(_coord=="y") retour = Math.sin(angle)*rayon;
		return retour;
	}
	
	
	//todo : a améliorer pour la gestion des exceptions
	static public function getAngle2pt(x_start:Float, y_start:Float, x_end:Float, y_end:Float, useDegre:Bool=false):Float
	{
		var dx:Float = x_end-x_start;
		var dy:Float = y_end-y_start;
		var angle:Float = Math.atan2(dy, dx);
		if(useDegre) angle = angle * 180/Math.PI;
		return angle;
	}
	
	
	
	//tothink
	//le sens est ici important, eventuellement, param qui se fiche du sens -> result %180
	static public function getAngle3pt(x1:Float, y1:Float, x2:Float, y2:Float, x3:Float, y3:Float, witch:Float=0, useDegre:Bool=false):Float
	{
		var ax:Float, ay:Float, bx:Float, by:Float, cx:Float, cy:Float;
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
		
		var a1:Float = getAngle2pt(ax, ay, bx, by, useDegre);
		var a2:Float = getAngle2pt(ax, ay, cx, cy, useDegre);
		var result:Float = (a1 - a2);
		while(result<0) result += (useDegre) ? 360 : Math.PI*2;
		return result;
	}
	
	
	
	static public function getHypotenuse(x1:Float, y1:Float, x2:Float, y2:Float): Float
	{
		var dx:Float = x2-x1;
		var dy:Float = y2-y1;
		return Math.sqrt(Math.pow(dx,2)+Math.pow(dy,2));
	}
	
	
	
	
	//calcul la hauteur d'un triangle issu du point désigné par l'argument witch
	static public function getTriangleHeight(x1:Float, y1:Float, x2:Float, y2:Float, x3:Float, y3:Float, witch:Float=0):Float
	{
		var ax:Float, ay:Float, bx:Float, by:Float, cx:Float, cy:Float;
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
		
		var angle:Float = Math2.getAngle3pt(ax, ay, bx, by, cx, cy, 1, false);
		var hypotenuse:Float = Math2.getHypotenuse(ax, ay, bx, by);
		//sinus(anglB) = h / hypotenuse (SOH)
		var result:Float = Math.sin(angle) * hypotenuse;
		return result;
	}
	
	
	
	
	
	
	
	
	
	
	
	//_____________________________________________________________________________
	//arrondis
	
	static public function floor(nb:Float, inc:Float):Float
	{
		if(inc <= 0) throw new Error("Math2.floor(), inc must be > than 0");
		var retour:Float = Math.floor(nb/inc) * inc;
		return retour;
	}
	
	static public function round(nb:Float, inc:Float):Float
	{
		if(inc <= 0) throw new Error("Math2.floor(), inc must be > than 0");
		var retour:Float = Math.round(nb/inc) * inc;
		return retour;
	}
	
	static public function ceil(nb:Float, inc:Float):Float
	{
		if(inc <= 0) throw new Error("Math2.floor(), inc must be > than 0");
		var retour:Float = Math.ceil(nb/inc) * inc;
		return retour;
	}
	
	
	
	
	
	
	
	//_____________________________________________________________________________
	//random
	
	static public function random(min:Float, max:Float, inc:Float=1):Float
	{
		if(inc <= 0) throw new Error("Math2.floor(), inc must be > than 0");
		var retour:Float = Math2.floor(Math.random() * (max-min+inc) + min, inc);
		return retour;
	}
	
	static public function random_input(min:Float, max:Float, inc:Float, input:Float):Float
	{
		if(inc <= 0) throw new Error("Math2.floor(), inc must be > than 0");
		
		
		var _nbsoluce:Float = (max - min) / inc;
		//trace("random_input _nbsoluce : " + _nbsoluce);
		_nbsoluce = Math.round(_nbsoluce) + 1;
		var _rest:Float = input % _nbsoluce;
		var _output:Float = min + _rest * inc;
		return _output;
	}
	
	
	
	static public function getAverage(_valueA:Float, _valueB:Float, _coeffA:Float, _coeffB:Float):Float 
	{
		var _total:Float = _valueA * _coeffA + _valueB * _coeffB;
		var _divide:Float = _coeffA + _coeffB;
		return _total / _divide;
	}
	
	
	static public function getRandProbability(_frequency:Float):Bool
	{
		if (_frequency <= 0) return false;
		if (_frequency >= 1) return true;
		
		var _denom:Float = Math2.round((1 / _frequency), 0.1);
		var _rand:Float = Math2.random(0, _denom, 0.1);
		return (_rand < 1);
	}
	
	
	static private var _counterProbabilityOrder:Float = 0;
	static public function getRandProbabilityOrder(_frequency:Float):Bool
	{
		if (_frequency <= 0) return false;
		if (_frequency >= 1) return true;
		
		var _denom:Float = Math2.round((1 / _frequency), 0.1);
		
		//trace("_counterProbabilityOrder : " + _counterProbabilityOrder);
		_counterProbabilityOrder += 1;
		if (_counterProbabilityOrder >= _denom) {
			_counterProbabilityOrder = 0;
			return true;
		}
		else return false;
	}
	
	
	
	
	static public function getProgressionValue(_input:Float, _minsrc:Float, _maxsrc:Float, _mindst:Float, _maxdst:Float):Float
	{
		var _percentinput:Float = (_input - _minsrc) / (_maxsrc - _minsrc);
		if (_percentinput < 0) _percentinput = 0;
		if (_percentinput > 1) _percentinput = 1;
		var _output:Float = _mindst + (_maxdst - _mindst) * _percentinput;
		return _output;
	}
	
	
	
	static public function getRandIndexProbability(_freqs:Array<Float>):Int 
	{
		//on remplit un array avec les index de frequences
		var _sum:Float = sum(_freqs);
		
		var _nbelmt:Int = 1000;
		var _indexes:Array<Int> = new Array();
		
		var _nbfreq:Int = _freqs.length;
		for (i in 0..._nbfreq) 
		{
			var _freq:Float = _freqs[i];
			var _space:Float = _freq / _sum * _nbelmt;
			var _spaceint:Int = Std.int(_space);
			//trace("_space : " + _space);
			for (j in 0..._spaceint) _indexes.push(i);
			
		}
		
		//trace("len after : " + _indexes.length);
		var _index:Float = random(0, _indexes.length - 1, 1);
		
		return _indexes[Std.int(_index)];
		
	}
	
	
	
	
	static public function roundFromList(_value:Float, _list:Array<Float>):Float 
	{
		//todo : chercher la valeur de list pour laquelle ya le moins de distance
		var _mindist:Float = -1;
		var _index:Int = -1;
		var _len:Int = _list.length;
		for (i in 0..._len)
		{
			var _delta:Float = Math.abs(_list[i] - _value);
			if (_mindist == -1 || _delta < _mindist) {
				_mindist = _delta;
				_index = i;
			}
		}
		return _list[_index];
		
	}
	
	
	
	
	static public function sum(_list:Array<Float>):Float
	{
		var _output:Float = 0;
		var _len:Int = _list.length;
		for (i in 0..._len) _output += _list[i];
		return _output;
	}
	
	
	
	
	
	
	
	//___________________________________________________________________________________
	//bézier
	
	
	static public function quadraticFunction(_p0:Float, _p1:Float, _p2:Float, _t:Float):Float 
	{
		var _output:Float;
		_output = _p0 * Math.pow(1 - _t, 2) + 2 * _p1 * _t * (1 - _t) + Math.pow(_t, 2) * _p2;
		return _output;
	}
	
	static public function cubicFunction(_p0:Float, _p1:Float, _p2:Float, _p3:Float, _t:Float):Float 
	{
		var _output:Float;
		_output = _p0 * Math.pow(1 - _t, 3) + 3 * _p1 * _t * Math.pow(1 - _t, 2) + 3 * _p2 * Math.pow(_t, 2) * (1 - _t) + _p3 * Math.pow(_t, 3);
		return _output;
	}
	
	
	
}
