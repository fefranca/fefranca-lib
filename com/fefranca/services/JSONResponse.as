package com.fefranca.services
{
	import com.fefranca.services.IResponseParser;
	import com.adobe.serialization.json.JSONDecoder;
	import com.adobe.serialization.json.JSONEncoder;

	public class JSONResponse implements IResponseParser
	{
		public function parse(rawContent:String):*
		{
			try
			{
				var jsonDecoder:JSONDecoder = new JSONDecoder(rawContent, false);
				var content:* = jsonDecoder.getValue();
				return content;
			} 
			catch (e:Error)
			{
				trace("JSONResponse::parse() error", e.message);
				return null;
			}
			
		}
		
		public function encode(value:*):String
		{
			var jsonEncoder:JSONEncoder = new JSONEncoder(value);
			return jsonEncoder.getString();
		}
	}

}