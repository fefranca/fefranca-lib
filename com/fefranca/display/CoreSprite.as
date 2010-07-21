package com.fefranca.display
{
import flash.display.Sprite;
import com.fefranca.core.IDisposable;
import com.fefranca.core.IRecyclable;
import flash.display.DisplayObject;
import com.fefranca.display.safeRemoveChild;
import com.fefranca.data.ObjectPool;
import flash.events.IEventDispatcher;

public class CoreSprite extends Sprite implements IDisposable
{
	protected var _disposableChildren:Vector.<IDisposable>;
	protected var _recyclableChildren:Vector.<IRecyclable>;
	
	public function CoreSprite() {
		_disposableChildren = new Vector.<IDisposable>();
		_recyclableChildren = new Vector.<IRecyclable>();
	}
	
	public function init():void {
		
	}
	
	public function dispose():void {
		disposeChildren();
		recycleChildren();
		_disposableChildren = null
		_recyclableChildren = null;
	}
	
	/**
	 * Initializes and registers a disposable object
	 * @param obj IDisposable 
	 */
	public function addDisposable(obj:IDisposable):void {
    	obj.init();
    	_disposableChildren.push(obj);
    }

    public function addDisposableChild(obj:IDisposable, index:int = -1):void {
    	obj.init();
    	_disposableChildren.push(obj);
    	addChild(obj as DisplayObject);
    }

	public function addDisposableChildAt(obj:IDisposable, index:int):void {
    	obj.init();
    	_disposableChildren.push(obj);
    	addChildAt(obj as DisplayObject, index);
    }
    
	/**
	 * Initializes and registers a recyclable object
	 * @param obj IRecyclable 
	 */
    public function addRecyclable(obj:IRecyclable):void {
    	obj.init();
    	_recyclableChildren.push(obj);
    }

    public function addRecyclableChild(obj:IRecyclable, index:int = -1):void {
    	obj.init();
    	_recyclableChildren.push(obj);
    	addChild(obj as DisplayObject);
    }

	public function addRecyclableChildAt(obj:IRecyclable, index:int):void {
    	obj.init();
    	_recyclableChildren.push(obj);
    	addChildAt(obj as DisplayObject, index);
    }

	/**
	 * Dispose children that have been added to this object through the addDisposable methods
	 * @private
	 */
    public function disposeChildren():void {
    	var obj:IDisposable;
    	for each(obj in _disposableChildren) {
    		obj.dispose();
    		if (obj is DisplayObject) {
    			safeRemoveChild(obj as DisplayObject);
			}
    	}
    	_disposableChildren.length = 0;
    }

	/**
	 * Dispose children that have been added to this object through the addDisposable methods
	 * @private
	 */
    public function recycleChildren():void {
    	var obj:IRecyclable;
    	for each(obj in _recyclableChildren) {
    		obj.recycle();
    		if (obj is DisplayObject) {
    			safeRemoveChild(obj as DisplayObject);
			}
			ObjectPool.disposeObject(obj);
    	}
    	_recyclableChildren.length = 0;
    }
	
}

}