package com.fefranca.data
{
	/**
	 * Simple data storage class
	 * 
	 * @author Fernando França 
	 */	
	
	public class DataStore
	{
		private static var _shared:Object = new Object;
		
		public static function get shared():Object {
			return _shared;
		}
	}
}