package com.fefranca.net.social
{
import flash.net.URLRequest;
import flash.net.URLRequestMethod;
import flash.net.URLVariables;
import flash.net.navigateToURL;
import com.fefranca.net.Navigation;

/**
 * Utilities for the Twitter public API
 * @author Fernando França
 */
public class Twitter 
{
	public static const MAX_CHARS:int = 140;
	
	public static function post(message:String, messageURL:String = "", window:String = "_blank"):void
	{
		if(messageURL.length > 0) messageURL = " " + messageURL;
		
		if(message.length > MAX_CHARS - messageURL.length){
			message = message.substr(0, MAX_CHARS - messageURL.length - 3) + "...";
		}
		message = message + messageURL;
		
		var url:String = "http://twitter.com/home";
		var request:URLRequest = new URLRequest(url);
        var variables:URLVariables = new URLVariables();
        variables.status = message;
        request.data = variables;
        request.method = URLRequestMethod.GET;
		
		// Tries posting using a pop-up. Uses navigateToURL upon failure.
		if(!Navigation.openWindow(request.url + "?" + variables.toString(), "_blank", "width=820, height=430, toolbar=0, status=0")){
			navigateToURL(request, window);
		}
	}
}

}