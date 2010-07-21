package com.fefranca.display
{
import flash.display.DisplayObject;
	/**
	 * Yet another safeRemoval implementation ;) 
	 * @param displayObject DisplayObject
	 */
	public function safeRemoveChild(displayObject:DisplayObject):void
	{
		if(displayObject != null && displayObject.parent) {
			displayObject.parent.removeChild(displayObject);
		}
	}
}
