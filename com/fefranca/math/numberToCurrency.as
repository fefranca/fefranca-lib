package com.fefranca.math
{
	
	public function numberToCurrency(value:Number):String
	{
		var fixedString:String = value.toFixed(2);		
		
		// No virgules, no fun
		if(value < 1000){
			return fixedString;	
		}

		// Smart use of the modulus operand
		var integerLength:int = fixedString.length - 3;
		var finalString:String = ""; 
		
		for(var i:int = integerLength % 3; i < integerLength; i+= 3)
		{
			if(i != 0) finalString += fixedString.substring(i - 3, i) + ",";
		}
		finalString += fixedString.substr(integerLength - 3, 6);
		
		return finalString;
	}
	
}

