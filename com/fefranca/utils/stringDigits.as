package com.fefranca.utils
{
	public function stringDigits(n:int, digits:uint):String
	{
		var str:String = "" + n;
		while(str.length < digits){
			str = "0" + str;
		}
		return str;
	}

}

