package com.fefranca.utils
{
	import flash.utils.Dictionary;

	public function numberOfKeys(dictionary:Dictionary):int
	{
		var count:int = 0;
		for (var key:* in dictionary) count++;
		return count;
	}

}
