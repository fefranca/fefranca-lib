package com.fefranca.math
{

public class Range extends Object
{
	public var min:Number;
	public var max:Number;
	
	public function Range(min:Number, max:Number)
	{
		super();
		this.min = min;
		this.max = max;
	}
	
	public function getValueFromPercentage(p:Number):Number
	{
		return min + (max - min) * p;
	}
	
	public function getPercentageFromValue(value:Number):Number
	{
		return (value - min) / (max - min);
	}
	
	public function constrain(value:Number):Number {
		if(value > this.max){
			return this.max;
		}
		else if(value < this.min){
			return this.min;
		}
		else {
			return value;
		}
	}
	
}

}

