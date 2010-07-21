package com.fefranca.core
{

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.utils.getDefinitionByName;
	import flash.events.IOErrorEvent;
	
	/**
	 * Lightweight preloader (Factory class)
	 * 
	 * @author Fernando França
	 */
	public class FactoryPreloader extends MovieClip 
	{
		protected var _preloader:IPreloader;
		protected var _mainClassName:String;
		
		public function FactoryPreloader(mainClassName:String, preloader:IPreloader) 
		{	
			super();
			
			_mainClassName = mainClassName;
			_preloader = preloader;
			_preloader.init();
			addChild(_preloader.displayObject);
			
			addEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);
			loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError);
		}
		
		protected function onProgress(e:ProgressEvent):void 
		{
			var p:Number = e.bytesLoaded / e.bytesTotal;
			_preloader.percentage = p;
			if(p == 1.0) play(); //hack ;)
		}
		
		public function onError(e:IOErrorEvent):void
		{
			
		}
		
		protected function checkFrame(e:Event):void 
		{
			if (currentFrame == totalFrames) 
			{
				startUp();
			}
		}
		
		protected function startUp():void 
		{
			removeEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, onProgress);
			
			removeChild(_preloader.displayObject);
			_preloader.dispose();
			_preloader = null;
			
			//this.stop();
			
			var mainClass:Class = getDefinitionByName(_mainClassName) as Class;
			addChildAt(new mainClass() as DisplayObject, 0);
		}
		
	}
	
}