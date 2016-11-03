package player.control
{
	import player.service.IFolderService;
	
	import robotlegs.bender.bundles.mvcs.Command;

	public class ChooseFolderCommand extends Command
	{
		[Inject]
		//folder Service
		public var FolderService:IFolderService;
		override public function execute():void
		{
			FolderService.promptToChooseFolder();	
		}
	}
}