package player.control
{
	import player.events.FileResultEvent;
	import player.model.FileModel;
	
	import robotlegs.bender.bundles.mvcs.Command;
		
	public class SetSelectedFileCommand extends Command
	{
		[Inject]
		public var event:FileResultEvent;
		
		[Inject]
		public var fileModel:FileModel;
		
		override public function execute():void
		{
			fileModel.fileName = event.fileName;
			fileModel.filePath = event.filePath;
			fileModel.fileUrl = event.fileUrl;
		}
	}
}