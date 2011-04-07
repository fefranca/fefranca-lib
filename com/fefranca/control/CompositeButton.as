package com.fefranca.control
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import potato.core.IDisposable;
	import potato.core.IVisible;
	import potato.display.safeRemoveChild;
	
	[Event(name="click", type="flash.events.MouseEvent")]
	
	public class CompositeButton extends Sprite implements IDisposable, IVisible
	{
		protected var _asset:MovieClip;
		protected var _hitArea:Sprite;
		protected var _behavior:IButtonBehavior;
		protected var _enabled:Boolean = false;
		protected var _visible:Boolean = false;
		protected var _onClick:Function;
		
		public function CompositeButton(buttonAsset:MovieClip, behavior:IButtonBehavior, onClick:Function = null)
		{
			_asset = buttonAsset;
			_behavior = behavior;
 			_onClick = onClick;
			
			// Smart auto-replace
			if(_asset.parent)
			{
				safeRemoveChild(_asset);
				this.x = _asset.x;
				this.y = _asset.y;
				_asset.x = _asset.y = 0;
			}
			
			// Define our hit area
			if(_asset.hasOwnProperty("hit")){
				_hitArea = _asset.hit;
			}
			else {
				var r:Rectangle = _asset.getBounds(_asset);
				_hitArea = new Sprite();
				_hitArea.graphics.beginFill(0, 0);
				_hitArea.graphics.drawRect(r.x, r.y, r.width, r.height);
				_asset.addChild(_hitArea);
			}
			hitArea = _hitArea;
			
			// Initialize enabled
			enabled = false;
			
			// Add children
			addChild(_asset);
			
			// Initialize behavior
			_visible = false;
			visible = false;
			_behavior.asset = _asset;
		}
		
		public function set onClick(value:Function):void
		{
		  _onClick = value;
		}
		
		public function set enabled(value:Boolean):void
		{
			if(value != _enabled){
				_enabled = value;
  			if(_enabled) {
  				this.addEventListener(MouseEvent.ROLL_OVER, onMouseOver);
  				this.addEventListener(MouseEvent.ROLL_OUT, onMouseOut);
  				this.addEventListener(MouseEvent.CLICK, onMouseClick);
  			}
  			else {
  				this.removeEventListener(MouseEvent.ROLL_OVER, onMouseOver);
  				this.removeEventListener(MouseEvent.ROLL_OUT, onMouseOut);
  				this.removeEventListener(MouseEvent.CLICK, onMouseClick)
  			}
        //this.mouseEnabled = this.mouseChildren = value;
  			_hitArea.visible = value;
  		  this.buttonMode = value;
  			this.useHandCursor = value;
  			this.mouseChildren = this.mouseEnabled = value;
			}
		}
		
		public function get enabled():Boolean {
			return _enabled;
		}
		
		public function dispose():void
		{
			enabled = false;
			
			safeRemoveChild(_asset);
			safeRemoveChild(_hitArea);
			
			if(_behavior) _behavior.dispose();
			
			_asset = null;
			_hitArea = null;
			_behavior = null;
			_onClick = null;
		}
		
		public function show():void {
			if(!_visible){
				_visible = true;
				visible = true;
				enabled = true;
				if(_behavior) _behavior.show();
			}
		}
		
		public function hide():void {
			if(_visible){
				_visible = false;
				enabled = false;
				if(_behavior) _behavior.hide();
			}
		}
		
		protected function onMouseOver(e:MouseEvent):void
		{
			if(_behavior) _behavior.onMouseOver(e);
		}
		
		protected function onMouseOut(e:MouseEvent):void
		{
			if(_behavior) _behavior.onMouseOut(e);
		}
		
		protected function onMouseClick(e:MouseEvent):void
		{
			if(_behavior) _behavior.onMouseClick(e);
			if(_onClick != null) _onClick(e);
		}
	}
}