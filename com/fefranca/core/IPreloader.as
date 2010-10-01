package com.fefranca.core
{
	import flash.display.DisplayObject;
	import potato.core.IDisposable;

	public interface IPreloader extends IDisposable
	{
		function set percentage(value:Number):void;
		function get displayObject():DisplayObject;
	}
}
