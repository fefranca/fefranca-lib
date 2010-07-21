package com.fefranca.control
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import com.fefranca.core.IDisposable;
	
	public interface IButtonBehavior extends IVisibleBehavior
	{
		function onMouseOver(e:MouseEvent):void;
		function onMouseOut(e:MouseEvent):void;
		function onMouseDown(e:MouseEvent):void;
		function onMouseUp(e:MouseEvent):void;
		function onMouseClick(e:MouseEvent):void;
	}
}