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
		protected var _onMouseClick:Function;
		
		public function CompositeButton(buttonAsset:MovieClip, behavior:IButtonBehavior, onMouseClick:Function = null) {
			_asset = buttonAsset;
			_behavior = behavior;
 			_onMouseClick = onMouseClick;
			
			// Smart auto-replace
			if(_asset.parent){
				safeRemoveChild(_asset);
				this.x = _asset.x;
				this.y = _asset.y;
				_asset.x = _asset.y = 0;
			}
			
			// Define our hit area
			if(_asset.hasOwnProperty("hit")){
				_hitArea = _asset.hit;
				_asset.removeChild(_asset.hit);
			}
			else {
				var r:Rectangle = _asset.getBounds(_asset);
				_hitArea = new Sprite();
				_hitArea.graphics.beginFill(0, 0);
				_hitArea.graphics.drawRect(r.x, r.y, r.width, r.height);
			}
			
			// Add children
			addChild(_asset);
			_asset.addChild(_hitArea);
			
			// Initialize behavior
			_behavior.asset = _asset;
			_visible = _behavior.visible;
			setEnabled(_behavior.visible);
		}
		
		public function get hitSprite():Sprite {
			return _hitArea;
		}
		
		public function set enabled(value:Boolean):void
		{
			if(value != _enabled){
				setEnabled(value);
			}
		}
		
		public function get enabled():Boolean {
			return _enabled;
		}
		
		protected function setEnabled(value:Boolean):void
		{
			_enabled = value;
			if(value == true) {
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
			this.mouseEnabled = this.mouseChildren = value;
			_hitArea.visible = value;
			_hitArea.buttonMode = value;
			_hitArea.useHandCursor = value;
		}
		
		public function dispose():void
		{
			enabled = false;
			
			safeRemoveChild(_asset);
			safeRemoveChild(_hitArea);
			
			_behavior.dispose();
			
			_asset = null;
			_hitArea = null;
			_behavior = null;
			_onMouseClick = null;
		}
		
		public function show():void {
			if(!_visible){
				_visible = true;
				visible = true;
				enabled = true;
				_behavior.show();
			}
		}
		
		public function hide():void {
			if(_visible){
				_visible = false;
				enabled = false;
				_behavior.hide();
			}
		}
		
		public function get asset():MovieClip {
			return _asset;
		}
		
		public function get displayObject():DisplayObject
		{
			return this;
		}
		
		public function set onMouseClick(value:Function):void
		{
			_onMouseClick = value;
		}
		
		/**
		 * Handles mouse click events 
		 * @param e MouseEvent 
		 */
		protected function handleMouseClick(e:MouseEvent):void {
			_behavior.onMouseClick(e);
			if(_onMouseClick != null) _onMouseClick(e);
		}
		
		protected function handleMouseOver(e:MouseEvent):void {
			_behavior.onMouseOver(e);
		}
		
		protected function handleMouseOut(e:MouseEvent):void {
			_behavior.onMouseOut(e);
		}
		
		protected function handleMouseUp(e:MouseEvent):void {
			_behavior.onMouseUp(e);
		}
		
		protected function handleMouseDown(e:MouseEvent):void {
			_behavior.onMouseDown(e);
		}
	}
}