package com.fefranca.core
{
	import flash.display.DisplayObject;
	
	public interface IVisible
	{
		function get displayObject():DisplayObject;
		function show():void;
		function hide():void;
	}
}