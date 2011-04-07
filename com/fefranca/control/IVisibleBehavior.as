package com.fefranca.control
{
	import flash.display.MovieClip;
	import potato.core.IDisposable;
	import potato.core.IVisible;
	
	public interface IVisibleBehavior extends IDisposable, IVisible
	{
		function set asset(asset:MovieClip):void;
		
	  // Inherited:
		//function dispose():void;
		//function show():void;
		//function hide():void;
	}
}