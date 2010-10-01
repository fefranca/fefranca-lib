package com.fefranca.debug
{

	public function traceProperties(obj:Object):void
	{
		for(var key:* in obj)
		{
			trace(key, ":", obj[key]);
		}
	}

}

