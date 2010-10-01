package com.fefranca.services
{
	import com.fefranca.services.ServiceManager;
	
	public function call(serviceName:String, callParameters:Object = null, callConfiguration:Object = null):void
	{
		ServiceManager.instance.call(serviceName, callParameters, callConfiguration);
	}
	
}
