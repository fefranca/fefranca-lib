package com.fefranca.math
{
	/**
	 * Numeric range implementation
	 * 
	 * @langversion ActionScript 3
	 * @playerversion Flash 10.0.0
	 * 
	 * @author Fernando França
	 * @since  25.08.2010
	 */
	public class Range
	{
		public var min:Number;
		public var max:Number;
	
		public function Range(min:Number, max:Number)
		{
			this.min = min;
			this.max = max;
		}
		
		public function getValueFromPercentage(p:Number):Number
		{
			return min + (max - min) * p;
		}
	
		public function getPercentageFromValue(value:Number):Number
		{
			if (max - min == 0) return 0;
			
			return (value - min) / (max - min);
		}
		
		public function constrain(value:Number):Number
		{
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
		
		public function toString():String
		{
			return "Range ("+ min +"," + max + ")";
		}
	
	}

}

