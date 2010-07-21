package com.fefranca.control
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import com.fefranca.core.IDisposable;
	import com.fefranca.display.safeRemoveChild;
	import flash.events.EventDispatcher;
	
	public class GhostButton extends EventDispatcher implements IDisposable
	{
		private var _buttonAsset:MovieClip;
		private var _hitArea:Sprite;
		private var _behavior:IButtonBehavior;
		private var _enabled:Boolean = false;
		private var _hidden:Boolean = true;
		private var _onClick:Function;
		
		public function GhostButton(buttonAsset:MovieClip, behavior:IButtonBehavior, onClick:Function = null) {
			_buttonAsset = buttonAsset;
			_behavior = behavior;
			_onClick = onClick;
			
			if(_buttonAsset.hasOwnProperty("hit")){
				_hitArea = _buttonAsset.hit;
				_buttonAsset.removeChild(_buttonAsset.hit);
			}
			else {
				var r:Rectangle = _buttonAsset.getBounds(_buttonAsset);
				_hitArea = new Sprite();
				_hitArea.graphics.beginFill(0, 0);
				_hitArea.graphics.drawRect(r.x, r.y, r.width, r.height);
			}
		}
		
		public function init():void {
			_buttonAsset.addChild(_hitArea);
		
			// Initialize behavior
			_behavior.asset = _buttonAsset;
			_behavior.init();
		}
		
		public function get hitSprite():Sprite {
			return _hitArea;
		}
		
		public function set enabled(value:Boolean):void {
			if(value == _enabled) return;
			
			_enabled = value;
			if(_enabled) {
				_hitArea.addEventListener(MouseEvent.MOUSE_OVER, _behavior.handleMouseOver);
				_hitArea.addEventListener(MouseEvent.MOUSE_OUT, _behavior.handleMouseOut);
				_hitArea.addEventListener(MouseEvent.MOUSE_UP, _behavior.handleMouseClick);
				_hitArea.addEventListener(MouseEvent.CLICK, this.handleMouseClick);
			}
			else {
				_hitArea.removeEventListener(MouseEvent.MOUSE_OVER, _behavior.handleMouseOver);
				_hitArea.removeEventListener(MouseEvent.MOUSE_OUT, _behavior.handleMouseOut);
				_hitArea.removeEventListener(MouseEvent.MOUSE_UP, _behavior.handleMouseClick);
				_hitArea.removeEventListener(MouseEvent.CLICK, this.handleMouseClick);
			}
			_hitArea.visible = _enabled;
			_hitArea.buttonMode = _enabled;
			_hitArea.useHandCursor = _enabled;
		}
		
		public function get enabled():Boolean {
			return _enabled;
		}
		
		public function set onClick(f:Function):void {
			_onClick = f;
		}
		
		public function dispose():void {
			enabled = false;
			
			//safeRemoveChild(_buttonAsset);
			safeRemoveChild(_hitArea);
			
			_behavior.dispose();
			
			_buttonAsset = null;
			_hitArea = null;
			_behavior = null;
			_onClick = null;
		}
		
		public function show():void {
			if(_hidden){
				_hidden = false;
				enabled = true;
				_behavior.show();
			}
		}
		
		public function hide():void {
			if(!_hidden){
				_hidden = true;
				enabled = false;
				_behavior.hide();
			}
		}
		
		private function handleMouseClick(e:MouseEvent):void {
			if(_onClick != null) _onClick(e);
		}
	}
}