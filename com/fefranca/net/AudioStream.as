package com.fefranca.net
{
import flash.events.EventDispatcher;
import flash.events.NetStatusEvent;
import flash.events.SecurityErrorEvent;
import flash.media.SoundTransform;
import flash.net.NetConnection;
import flash.net.NetStream;
import com.fefranca.net.events.AudioStreamEvent;
import potato.core.IDisposable;

/**
 *  Dispatched when an error occurs.
 *
 *  @eventType radio.events.AudioStreamEvent.ERROR
 */
[Event(name="error", type="radio.events.AudioStreamEvent")]

/**
 *  Dispatched when stream is loading (either connecting or buffering).
 *
 *  @eventType radio.events.AudioStreamEvent.LOADING
 */
[Event(name="loading", type="radio.events.AudioStreamEvent")]

/**
 *  Dispatched when stream is playing audio content (buffer is full).
 *
 *  @eventType radio.events.AudioStreamEvent.PLAYING
 */
[Event(name="playing", type="radio.events.AudioStreamEvent")]

/**
 *  Dispatched when stream has been paused.
 *
 *  @eventType radio.events.AudioStreamEvent.PAUSED
 */
[Event(name="paused", type="radio.events.AudioStreamEvent")]

public class AudioStream extends EventDispatcher implements INetStream, IDisposable
{
	private var _verbose:Boolean;
	private var _connectionURL:String;
	private var _streamName:String;
	private var _bufferTime:Number;
	
	private var _connection:NetConnection;
	private var _stream:NetStream;
	private var _volume:Number = 1.0;
	
	public function AudioStream(connectionURL:String, streamName:String, bufferTime:Number = 2)
	{
		super();
		_verbose = false;
		_connectionURL = connectionURL;
		_streamName = streamName;
		_bufferTime = bufferTime;	
	}
	
	public function set verbose(value:Boolean):void
	{
		_verbose = value;
	}
	
	public function init():void
	{
		_connection = new NetConnection();
		_connection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
        _connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
	}
	
	public function dispose():void
	{
		pause();
		_connection = null
		_stream = null;
	}
	
	public function play():void
	{
		if(! _connection.connected ){
			dispatchEvent(new AudioStreamEvent(AudioStreamEvent.LOADING));
			_connection.connect(_connectionURL);
		}
		else if( _stream ){
			dispatchEvent(new AudioStreamEvent(AudioStreamEvent.LOADING));
			_stream.play(_streamName);
		}
	}
	
	public function pause():void
	{
		if(_stream) _stream.close();
		_connection.close();
		dispatchEvent(new AudioStreamEvent(AudioStreamEvent.PAUSED));
	}
	
	public function set volume( value:Number ):void {
		_volume = value;
		if(_stream && _connection.connected) _stream.soundTransform = new SoundTransform(_volume);
	}
	
	public function get volume():Number
	{
		return _volume;
	}
	
	private function netStatusHandler(e:NetStatusEvent):void {
		if(_verbose) trace("warning:" +e.info.code);
		
        switch (e.info.code) {
            case "NetConnection.Connect.Success":
				// Connection established
                connectStream();
                break;
			case "NetConnection.Connect.Closed":
				dispatchEvent(new AudioStreamEvent(AudioStreamEvent.PAUSED));
				if(_stream) _stream.close();
				_stream = null;
				break;
			case "NetConnection.Connect.Failed":
			case "NetConnection.Connect.Rejected":
				dispatchEvent(new AudioStreamEvent(AudioStreamEvent.ERROR));
                break;

            case "NetStream.Play.StreamNotFound":
                trace("Stream not found.");
				dispatchEvent(new AudioStreamEvent(AudioStreamEvent.ERROR));
                break;

			case "NetStream.Play.Start" :
				// Buffering stream
				dispatchEvent(new AudioStreamEvent(AudioStreamEvent.LOADING));
				break;
				
			case "NetStream.Play.Stop" :
				// Stream paused
				dispatchEvent(new AudioStreamEvent(AudioStreamEvent.PAUSED));
				break;
				
			case "NetStream.Buffer.Full" :
				// Stream playing, buffered
				dispatchEvent(new AudioStreamEvent(AudioStreamEvent.PLAYING));
				_stream.soundTransform = new SoundTransform(_volume);
				break;
				
			case "NetStream.Buffer.Empty" :
				// Stream paused, buffering up
				dispatchEvent(new AudioStreamEvent(AudioStreamEvent.LOADING));

				break;
        }
    }

    private function securityErrorHandler(e:SecurityErrorEvent):void {
		trace("securityErrorHandler: " + e);
    }
	
	private function connectStream():void {
		_stream = new NetStream(_connection);
		_stream.checkPolicyFile = true;
		_stream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
		_stream.client = new CustomStreamClient(_verbose);
		_stream.bufferTime = _bufferTime;
		play();
	}
	
}

}

class CustomStreamClient {
	
	private var _verbose:Boolean;
	
	public function CustomStreamClient(verbose:Boolean){
		_verbose = verbose;
	}
	
	public function onPlayStatus( info:Object ):void {
		for( var i:* in info ){
			if(_verbose) trace("playstatus " + i + ":" + info[i] );
		}
	}
	
	public function onMetaData( info:Object ):void {	
		for( var i:* in info ){
			if(_verbose) trace("metadata " + i + ":" + info[i] );
		}
	}
	
	public function onCuePoint( info:Object ):void {
		for( var i:* in info ){
			if(_verbose) trace("cuepoint " + i + ":" + info[i] );
		}
	}
	
	public function onImageDataHandler( info:Object ):void {}
	
	public function onTextDataHandler( info:Object ):void {}

}