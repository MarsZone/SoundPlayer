package player.events
{
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;

	public class FolderResultEvent extends Event
	{
		public static const FOLDER_RESULT:String = "folderResult";
		
		public function FolderResultEvent(type:String, arrCollection:ArrayCollection, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_arrCollection = arrCollection;
		}
		
		private var _arrCollection:ArrayCollection;
		public function get arrCollection():ArrayCollection
		{
			return this._arrCollection;
		}
		
		override public function clone():Event
		{
			return new FolderResultEvent(type, arrCollection, bubbles, cancelable);
		}
	}
}