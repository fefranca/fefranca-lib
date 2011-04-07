package com.fefranca.control
{
	import com.fefranca.control.IVisibleBehavior;
	import flash.display.MovieClip;

	public class AVisibleBehavior implements IVisibleBehavior
	{
		protected var _asset:MovieClip;
		
		public function AVisibleBehavior(){}
	
		public function set asset(value:MovieClip):void
		{
			_asset = value;
		}
		
		public function show():void {}
	
		public function hide():void {}
		
		public function dispose():void
		{
			_asset = null;
		}
	
	}
}