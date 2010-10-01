package com.fefranca.services
{
	import flash.events.Event;

	public class ServiceEvent extends Event
	{
		public static const CALL_START:String   = "call_start";
		public static const CALL_COMPLETE:String = "call_complete";
		public static const CALL_ERROR:String    = "call_error";
		public static const CALL_RETRY:String   = "call_retry";
		
		protected var _content:Object = null;
		
		public function ServiceEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		public function get content():Object
		{
			return _content;
		}
		
		public function set content(value:Object):void
		{
			_content = value;
		}
		
	}
}
