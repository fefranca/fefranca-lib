package com.fefranca.dynamic
{
	import flash.events.MouseEvent;
	
	/**
	 * A first attempt at adding dynamic utilies to AS3.
	 * 
	 * @langversion ActionScript 3
	 * @playerversion Flash 10.0.0
	 * 
	 * @author Fernando França
	 * @since  18.08.2010
	 */
	public class $
	{
		/**
		 * Set is a powerful operator for setting properties of an object dynamically.<br/>
		 * 
		 * It is not type-safe and should be used with caution<br/>
		 * 
		 * It supports the following special properties:<br/>
		 * 
		 * <b>parent:</b> adds the object as a child of this value. <br/>
		 * <b>[event_type]:</b> adds an event listener to this event type (fired by the object).
		 * 
		 *
		 */
		public static function set(obj:*, props:Object):*
		{
			for (var key:String in props)
			{
				var keyValue:* = props[key];
				
				switch (key)
				{
					case "parent":
						keyValue.addChild(obj);
						break;
					case MouseEvent.CLICK:
						obj.addEventListener(MouseEvent.CLICK, keyValue, false, 0, true);
						break;
					default:
						obj[key] = keyValue;
						break;
				}
			}
		
			return obj;
		}
		//$.set(_topLink, {x: stage.stageWidth / 2, y: 0, parent: this, 'click': onTopLinkClick});
		
		
		// each Iterator (flash_proxy?)
		// $.find(obj, TextField).each.text = "AAA";
		// $.find(obj, TextField).each.appendText("test")
		// depth: 3
		// $.find(obj, "intanceName", 3).first.visible = false
		// $.find(obj, "intanceName", 3).last.visible = false
	}
}
