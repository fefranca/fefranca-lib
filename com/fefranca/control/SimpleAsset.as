package com.fefranca.control
{
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.display.DisplayObject;
import com.fefranca.core.IDisposable;
import com.fefranca.core.IVisible;
import com.fefranca.display.safeRemoveChild;

public class SimpleAsset extends Sprite implements IDisposable, IVisible
{
	private var _asset:MovieClip;
	private var _behavior:IVisibleBehavior;
	private var _hidden:Boolean;
	
	public function SimpleAsset(asset:MovieClip, behavior:IVisibleBehavior)
	{
		_asset = asset;
		this.mouseEnabled = false;
		this.mouseChildren = false;
		_behavior = behavior;
	}
	
	public function init():void
	{
		_behavior.asset = _asset;
		_behavior.init();
		
		_hidden = !_behavior.visible;
		this.visible = _behavior.visible;
		
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
	
}

}