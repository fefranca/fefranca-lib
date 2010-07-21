package com.fefranca.events
{
import flash.events.Event;

public class AudioStreamEvent extends Event
{
	public static const ERROR:String   = "error";
	public static const LOADING:String = "loading";
	public static const PLAYING:String = "playing";
	public static const PAUSED:String  = "paused";
	
	public function AudioStreamEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
	{
		super(type, bubbles, cancelable);
	}
	
}

}