package com.fefranca.control
{
	import flash.events.MouseEvent;
	import com.fefranca.control.AVisibleBehavior;
	import com.fefranca.control.IButtonBehavior;

	public class AButtonBehavior extends AVisibleBehavior implements IButtonBehavior
	{
		public function AButtonBehavior() {}
	  
	  public function onMouseOver(e:MouseEvent):void {}
	  
	  public function onMouseOut(e:MouseEvent):void {}
	  
	  public function onMouseClick(e:MouseEvent):void {}
	
	}
}