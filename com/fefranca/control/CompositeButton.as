package com.fefranca.control
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import com.fefranca.core.IDisposable;
	import com.fefranca.display.safeRemoveChild;
	import com.fefranca.core.IVisible;
	
	[Event(name="click", type="flash.events.MouseEvent")]
	
	public class CompositeButton extends Sprite implements IDisposable, IVisible
	{
		private var _buttonAsset:MovieClip;
		private var _hitArea:Sprite;
		private var _behavior:IButtonBehavior;
		private var _enabled:Boolean = false;
		private var _hidden:Boolean = true;
		private var _onMouseClick:Function = null;
		private var _onMouseOver:Function = null;
		private var _onMouseOut:Function = null;
		private var _onMouseDown:Function = null;
		private var _onMouseUp:Function = null;
		
		public function CompositeButton(buttonAsset:MovieClip, behavior:IButtonBehavior, onMouseClick:Function = null) {
			_buttonAsset = buttonAsset;
			_behavior = behavior;
 			_onMouseClick = onMouseClick;
			
			if(_buttonAsset.parent){
				safeRemoveChild(_buttonAsset);
				this.x = _buttonAsset.x;
				this.y = _buttonAsset.y;
				_buttonAsset.x = _buttonAsset.y = 0;
			}
			
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
			// Add children
			addChild(_buttonAsset);
			_buttonAsset.addChild(_hitArea);
			
			// Initialize behavior
			_behavior.asset = _buttonAsset;
			_behavior.init();
			_hidden = !_behavior.visible;
			visible = _behavior.visible;
			enabled = visible;
		}
		
		public function get hitSprite():Sprite {
			return _hitArea;
		}
		
		public function set enabled(bool:Boolean):void {
			if(bool != _enabled){
				if(bool) {
					_hitArea.addEventListener(MouseEvent.ROLL_OVER, handleMouseOver);//_behavior.onMouseOver);
					_hitArea.addEventListener(MouseEvent.ROLL_OUT, handleMouseOut);//_behavior.onMouseOut);
					_hitArea.addEventListener(MouseEvent.MOUSE_DOWN, handleMouseDown);//_behavior.onMouseDown);
					_hitArea.addEventListener(MouseEvent.MOUSE_UP, handleMouseUp);//_behavior.onMouseUp);
					_hitArea.addEventListener(MouseEvent.CLICK, handleMouseClick);//_behavior.onMouseClick);
				}
				else {
					_hitArea.removeEventListener(MouseEvent.ROLL_OVER, handleMouseOver);
					_hitArea.removeEventListener(MouseEvent.ROLL_OUT, handleMouseOut);
					_hitArea.removeEventListener(MouseEvent.MOUSE_DOWN, handleMouseDown);
					_hitArea.removeEventListener(MouseEvent.MOUSE_UP, handleMouseUp);
					_hitArea.removeEventListener(MouseEvent.CLICK, handleMouseClick)
				}
			}
			_enabled = bool;
			this.mouseEnabled = this.mouseChildren = _enabled;
			_hitArea.visible = _enabled;
			_hitArea.buttonMode = _enabled;
			_hitArea.useHandCursor = _enabled;
		}
		
		public function get enabled():Boolean {
			return _enabled;
		}
		
		public function set onMouseClick(value:Function):void
		{
			_onMouseClick = value;
		}
		
		public function set onMouseOver(value:Function):void
		{
			_onMouseOver = value;
		}
		
		public function set onMouseOut(value:Function):void
		{
			_onMouseOut = value;
		}
		
		public function set onMouseDown(value:Function):void
		{
			_onMouseDown = value;
		}
		
		public function set onMouseUp(value:Function):void
		{
			_onMouseUp = value;
		}
		
		public function dispose():void {
			enabled = false;
			
			safeRemoveChild(_buttonAsset);
			safeRemoveChild(_hitArea);
			
			_behavior.dispose();
			
			_buttonAsset = null;
			_hitArea = null;
			_behavior = null;
			_onMouseClick = null;
			_onMouseOver = null;
			_onMouseOut = null;
			_onMouseUp = null;
			_onMouseDown = null;
		}
		
		public function show():void {
			if(_hidden){
				visible = true;
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
		
		public function get asset():MovieClip {
			return _buttonAsset;
		}
		
		public function get displayObject():DisplayObject
		{
			return this;
		}
		
		/**
		 * Handles mouse click events 
		 * @param e MouseEvent 
		 */
		private function handleMouseClick(e:MouseEvent):void {
			_behavior.onMouseClick(e);
			if(_onMouseClick != null) _onMouseClick(e);
		}
		
		private function handleMouseOver(e:MouseEvent):void {
			_behavior.onMouseOver(e);
			if(_onMouseOver != null) _onMouseOver(e);
		}
		
		private function handleMouseOut(e:MouseEvent):void {
			_behavior.onMouseOut(e);
			if(_onMouseOut != null) _onMouseOut(e);
		}
		
		private function handleMouseUp(e:MouseEvent):void {
			_behavior.onMouseUp(e);
			if(_onMouseUp != null) _onMouseUp(e);
		}
		
		private function handleMouseDown(e:MouseEvent):void {
			_behavior.onMouseDown(e);
			if(_onMouseDown != null) _onMouseDown(e);
		}
				//
				//public function onMouseOver():void {
				//	if(_enabled) _behavior.onMouseOut(null);
				//}
	}
}
