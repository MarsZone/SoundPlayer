package player.control
{
	import player.events.FolderResultEvent;
	
	import robotlegs.bender.bundles.mvcs.Command;
	import player.model.FolderModel;

	public class SetFolderDataCommand extends Command
	{
		[Inject]
		public var event:FolderResultEvent;
		
		[Inject]
		public var folderModel:FolderModel;
		
		override public function execute():void
		{
			folderModel.arrCollection = event.arrCollection;
		}
	}
}