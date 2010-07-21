package com.fefranca.net
{
import flash.net.URLLoader;
import flash.events.IOErrorEvent;
import flash.events.Event;
import flash.net.URLRequest;
import flash.events.ProgressEvent;

public class XMLLoader
{
	protected var _loader:URLLoader;
	protected var _onComplete:Function = null;
	protected var _onProgress:Function = null;
	
	public function XMLLoader()
	{
		super();
		_loader = new URLLoader();
		_loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
		_loader.addEventListener(ProgressEvent.PROGRESS, onLoadProgress);
		_loader.addEventListener(Event.COMPLETE, onLoadComplete);
	}
	
	public function load(url:String, onComplete:Function, onProgress:Function = null):void {
		_onComplete = onComplete;
		_onProgress = onProgress;
		
		try {	
			_loader.load(new URLRequest(url));
		} 
		catch (e:SecurityError) {
			trace("XMLLoader SecurityError:" + e);
		}
	}
	
	protected function onLoadProgress(e:ProgressEvent):void
	{
		if(_onProgress != null) _onProgress(e.bytesLoaded / e.bytesTotal);
	}
	
	protected function onLoadComplete(e:Event):void
	{
		var xmlContent:XML = new XML(_loader.data);
		_onComplete(xmlContent);
	}
	
	protected function onIOError(e:IOErrorEvent):void
	{
		trace("XMLLoader IOErrorEvent:" + e);
		//_onError(e);
	}
	
	
	
}

}