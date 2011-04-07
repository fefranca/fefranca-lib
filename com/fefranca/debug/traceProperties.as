package com.fefranca.debug
{

	public function traceProperties(obj:Object):void
	{
	  if(obj == null) return;
		for(var key:* in obj)
		{
			trace(key, ":", obj[key]);
		}
	}

}

