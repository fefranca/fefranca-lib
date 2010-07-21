package com.fefranca.utils
{
import com.fefranca.core.IDisposable;
import flash.utils.Timer;
import flash.events.TimerEvent;

public class DelayedCall implements IDisposable
{
	private var _onComplete:Function = null;
	private var _timer:Timer;
	
	public function DelayedCall()
	{
		
	}
	
	public function init():void
	{
		_timer = new Timer(1000, 1);
		_timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
	}
	
	public function dispose():void
	{
		abort();
		_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
		_timer = null;
		_onComplete = null;
	}
	
	public function call(onComplete:Function, seconds:Number):void
	{
		_onComplete = onComplete;
		_timer.stop();
		_timer.delay = seconds * 1000;
		_timer.reset();
		_timer.start();
	}
	
	public function abort():void
	{
		_timer.stop();
	}
	
	public function onTimerComplete(e:TimerEvent):void
	{
		if(_onComplete != null) _onComplete();
	}
	
}

}