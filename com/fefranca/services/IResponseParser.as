package com.fefranca.services
{

	public interface IResponseParser
	{
		function parse(rawContent:String):*;
		function encode(value:*):String;
	}

}

