package com.fefranca.control
{
	import flash.display.MovieClip;
	import com.fefranca.core.IDisposable;
	
	public interface IVisibleBehavior extends IDisposable
	{
		function set asset(asset:MovieClip):void;
		function get visible():Boolean;
		
		function show():void;
		function hide():void;
	}
}