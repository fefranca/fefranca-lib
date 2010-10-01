package com.fefranca.services
{
	public class Service
	{
		protected var _url:String;
		protected var _parser:IResponseParser;
		protected var _timeout:int;
		protected var _retries:int;
		protected var _requestMethod:String;
		
		public function Service(url:String, parser:IResponseParser, requestMethod:String, timeout:int = 10000, retries:int = 3)
		{
			_url = url;
			_parser = parser;
			_requestMethod = requestMethod;
			_timeout = timeout;
			_retries = retries;
		}
		
		public function get url():String
		{
			return _url;
		}
		
		public function get parser():IResponseParser
		{
			return _parser;
		}
		
		public function get requestMethod():String
		{
			return _requestMethod;
		}
		
		public function get timeout():int
		{
			return _timeout;
		}
		
		public function get retries():int
		{
			return _retries;
		}
	}

}

