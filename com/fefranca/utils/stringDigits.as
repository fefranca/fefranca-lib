package com.fefranca.utils
{
	public function stringDigits(str:String, digits:uint):String
	{
		while(str.length < digits){
			str = "0" + str;
		}
		return str;
	}

}

