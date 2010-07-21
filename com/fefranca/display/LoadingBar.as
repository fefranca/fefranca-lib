package com.fefranca.display
{
	import flash.display.GradientType;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.text.TextField;
	
	
	/**
	 * ...
	 * @author Fernando França
	 */
	public class LoadingBar extends Sprite
	{
		private var _barWidth:Number;
		private var _barHeight:Number;
		private var _barPadding:Number;
		private var _innerBarWidth:Number;
		private var _innerBarHeight:Number;
		private var _color:Number;
		private var _backgroundColor:Number;
		private var _backgroundAlpha:Number;
		private var _border:Number;
		
		private var _percentage:Number;
		private var _txt:TextField;
		
		public function LoadingBar(x:Number = 0, y:Number = 0, width:Number = 200, height:Number = 10, padding:Number = 2, color:Number = 0x404142, backgroundAlpha:Number = 0.5, border:Number = 1)
		{
			super();
			this.x = x;
			this.y = y;
			_barWidth = width;
			_barHeight = height;
			_barPadding = padding;
			_innerBarWidth = 1 + _barWidth - 2 * _barPadding;
			_innerBarHeight = 1 + _barHeight - 2 * _barPadding;
			_color = color;
			_backgroundColor = color;
			_backgroundAlpha = backgroundAlpha;
			
			_border = border;
			if(_border <= 0) _border = NaN;
			//addEventListener(Event.ENTER_FRAME, updateBar, false, 0, true);
			
			_txt = new TextField();
			_txt.x = 10;
			_txt.y = _barHeight + 10;
			//addChild(_txt);
			setPercentage(0);
		}
		
		public function set backgroundColor(value:Number):void
		{
			_backgroundColor = value;
		}
		
		public function setPercentage(value:Number):void {
			percentage = value;
		}
		
		public function get percentage():Number
		{
			return _percentage;
		}
		
		public function set percentage(value:Number):void
		{
			_percentage = value;
			
			graphics.clear();
			graphics.lineStyle(_border, _color);
			graphics.drawRect(0, 0, _barWidth, _barHeight);			
			graphics.moveTo(0, 0);
			
			graphics.lineStyle();
			graphics.beginFill(_backgroundColor, _backgroundAlpha);
			graphics.drawRect(_barPadding, _barPadding, _innerBarWidth, _innerBarHeight);
			graphics.endFill();
			
			graphics.beginFill(_color);
			graphics.drawRect(_barPadding, _barPadding, Math.ceil(_innerBarWidth  * _percentage), _innerBarHeight);
			graphics.endFill();
			
			_txt.text = ""+Math.ceil(_percentage*100) + "%";
		}
		
	}

}

