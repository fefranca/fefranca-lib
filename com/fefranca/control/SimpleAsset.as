package com.fefranca.control
{
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.display.DisplayObject;
import potato.core.IDisposable;
import potato.core.IVisible;
import potato.display.safeRemoveChild;

public class SimpleAsset extends Sprite implements IDisposable, IVisible
{
	protected var _asset:MovieClip;
	protected var _behavior:IVisibleBehavior;
	protected var _hidden:Boolean;
	
	public function SimpleAsset(asset:MovieClip, behavior:IVisibleBehavior)
	{
		_asset = asset;
		
		this.mouseEnabled = false;
		this.mouseChildren = false;
		
		_behavior = behavior;
		_behavior.asset = _asset;
	
		_hidden = !_behavior.visible;
		this.visible = _behavior.visible;
		
		
		if(_asset.parent){
			safeRemoveChild(_asset);
			this.x = _asset.x;
			this.y = _asset.y;
			_asset.x = _asset.y = 0;
		}	
		addChild(_asset);
	}
	
	public function dispose():void
	{
		_behavior.dispose();
		_behavior = null;
		
		_asset.stop();
		safeRemoveChild(_asset);
		_asset = null;
	}
	
	public function show():void {
		if(_hidden){
			visible = true;
			_hidden = false;
			_behavior.show();
		}
	}

	public function hide():void {
		if(!_hidden){
			_hidden = true;
			_behavior.hide();
		}
	}
	
	public function get displayObject():DisplayObject
	{
		return this;
	}
	
	public function get asset():MovieClip
	{
		return _asset;
	}
	
}

}