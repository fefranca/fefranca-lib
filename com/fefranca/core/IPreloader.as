package com.fefranca.core
{
import flash.display.DisplayObject;

public interface IPreloader extends IDisposable
{
	function set percentage(value:Number):void;
	function get displayObject():DisplayObject;
}

}
