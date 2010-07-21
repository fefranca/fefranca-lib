package com.fefranca.utils
{

	/**
	 * Trims whitespace around the string
	 * @param value String 
	 * @return String 
	 */
	public function stringTrim(value:String):String
	{
		if(value == null) return "";
		
		return value.replace(/^\s+|\s+$/g, "");
	}

}

