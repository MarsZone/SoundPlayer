package player.events
{
	import flash.events.Event;

	public class FileModelEvent extends Event
	{
		public static const FILE_NAME_CHANGE:String = "fileNameChange";
		public static const FILE_PATH_CHANGE:String = "filePathChange";
		public static const FILE_URL_CHANGE:String = "fileUrlChange";
		
		
		public function FileModelEvent(type:String, value:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_value = value;
		}
		
		private var _value:String;
		public function get value():String
		{
			return _value;
		}
		
		override public function clone():Event
		{
			return new FileModelEvent(type, value, bubbles, cancelable);
		}
	}
}