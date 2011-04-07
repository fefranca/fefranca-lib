package com.fefranca.control
{
	import flash.events.MouseEvent;
	
	public interface IButtonBehavior extends IVisibleBehavior
	{
		function onMouseOver(e:MouseEvent):void;
		function onMouseOut(e:MouseEvent):void;
		function onMouseClick(e:MouseEvent):void;
		
	  // Inherited:
    // function set asset(asset:MovieClip):void;
		// function dispose():void;
		// function show():void;
		// function hide():void;
	}
}