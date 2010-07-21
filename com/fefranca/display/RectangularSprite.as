package com.fefranca.display
{
import flash.display.Sprite;

public class RectangularSprite extends Sprite
{
	
	public function RectangularSprite(width:Number, height:Number, color:uint = 0xff0000, alpha:Number = 1.0)
	{
		super();
		graphics.beginFill(color, alpha);
		graphics.drawRect(0, 0, width, height);
		graphics.endFill();
	}
	
}

}