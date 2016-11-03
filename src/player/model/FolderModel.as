package player.model
{
	import mx.collections.ArrayCollection;
	
	import base.BaseActor;
	
	import player.events.FolderModelEvent;

	public class FolderModel extends BaseActor
	{
		private var _arrCollection:ArrayCollection;
		public function get arrCollection():ArrayCollection
		{
			return this._arrCollection;
		}
		
		public function set arrCollection(value:ArrayCollection):void
		{
			this._arrCollection = value;
			dispatch(new FolderModelEvent(FolderModelEvent.FOLDER_DATA_CHANGE, _arrCollection));
		}
	}
}