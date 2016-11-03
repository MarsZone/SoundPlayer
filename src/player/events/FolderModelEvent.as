package player.events
{
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;

	public class FolderModelEvent extends Event
	{
		public static const FOLDER_DATA_CHANGE:String = "folderDataChange";
		
		public function FolderModelEvent(type:String, value:ArrayCollection, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_value = value;
		}
		
		private var _value:ArrayCollection;
		public function get value():ArrayCollection
		{
			return _value;
		}
		
		override public function clone():Event
		{
			return new FolderModelEvent(type, value, bubbles, cancelable);
		}
	}
}