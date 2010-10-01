package com.fefranca.services
{
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	import com.fefranca.services.ServiceEvent;
	import flash.events.ProgressEvent;

	public class ServiceManager extends EventDispatcher
	{
		private var _registeredServices:Dictionary;
		
		public function ServiceManager(singleton:SingletonEnforcer)
		{
			_registeredServices = new Dictionary();
		}
		
		public function registerService(serviceName:String, service:Service):void
		{
			_registeredServices[serviceName] = service;
		}
		
		public function getServiceByName(serviceName:String):Service
		{
			return _registeredServices[serviceName];
		}
		
		public function call(serviceName:String, callParameters:Object = null, callConfiguration:Object = null):void
		{
			var serviceCall:ServiceCall = new ServiceCall(getServiceByName(serviceName), callParameters);
			
			// Handy configuration of listeners
			if(callConfiguration != null)
			{
				if(callConfiguration.hasOwnProperty("onComplete")) 
					serviceCall.addEventListener(ServiceEvent.CALL_COMPLETE, callConfiguration.onComplete, false, 0, true);
					
				if(callConfiguration.hasOwnProperty("onError"))
					serviceCall.addEventListener(ServiceEvent.CALL_ERROR, callConfiguration.onError, false, 0, true);
				
				if(callConfiguration.hasOwnProperty("onProgress"))
					serviceCall.addEventListener(ProgressEvent.PROGRESS, callConfiguration.onProgress, false, 0, true);
			}
			serviceCall.start();
		}
		
		private static var __instance:ServiceManager;
		
		public static function get instance():ServiceManager
		{
			if(!__instance)
				__instance = new ServiceManager(new SingletonEnforcer());
			return __instance;
		}
	}

}

/**
 * Enforces the Singleton design pattern.
 */
internal class SingletonEnforcer{}