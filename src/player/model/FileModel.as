package player.model
{
	import base.BaseActor;
	
	import player.events.FileModelEvent;

	public class FileModel extends BaseActor
	{
		
		private var _fileName:String;
		public function get fileName():String
		{
			return _fileName;
		}
		public function set fileName(value:String):void
		{
			_fileName = value;
			dispatch(new FileModelEvent(FileModelEvent.FILE_NAME_CHANGE, _fileName));
		}
		
		
		private var _filePath:String;
		public function get filePath():String
		{
			return _filePath;
		}
		public function set filePath(value:String):void
		{
			_filePath = value;
			dispatch(new FileModelEvent(FileModelEvent.FILE_PATH_CHANGE, _filePath));
		}
		
		private var _fileUrl:String;
		public function get fileUrl():String
		{
			return _fileUrl;
		}
		public function set fileUrl(value:String):void
		{
			_fileUrl = value;
			dispatch(new FileModelEvent(FileModelEvent.FILE_URL_CHANGE, _fileUrl));
		}
		
	}
}