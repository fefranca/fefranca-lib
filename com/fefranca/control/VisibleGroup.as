package com.fefranca.control
{

import com.fefranca.core.IDisposable
import com.fefranca.core.IVisible;

/**
 * Contains IVisible objects. Subgrouping is also possible with this approach.
 * 
 * @author Fernando França
 * @since  01.06.2010
 */
public class VisibleGroup implements IVisible, IDisposable
{
	private var _elements:Vector.<IVisible>;
	
	public function VisibleGroup()
	{
		super();
	}
	
	public function init():void
	{
		_elements = new Vector.<IVisible>();
	}
	
	public function dispose():void
	{
		//var obj:IVisible;
		//		for each(obj in _elements){
		//			obj.dispose();
		//		}
		_elements.length = 0;
		_elements = null;
	}
	
	public function get elements():Vector.<IVisible> {
		return _elements;
	}
	
	public function addElement(obj:IVisible):void 
	{
		_elements.push(obj);
	}
	
	public function removeElement(obj:IVisible):void 
	{
		_elements.splice(_elements.indexOf(obj), 1);
	}
	
	public function show():void
	{
		var obj:IVisible;
		for each(obj in _elements){
			obj.show();
		}
	}
	
	public function hide():void
	{
		var obj:IVisible;
		for each(obj in _elements){
			obj.hide();
		}
	}
	
}

}

