package player.control
{
	import player.service.IFileService;
	
	import robotlegs.bender.bundles.mvcs.Command;

	public class ChooseFileCommand extends Command
	{
		[Inject]
		public var fileService:IFileService;
		
		override public function execute():void
		{
			
			fileService.promptToChooseFile();
		}
	}
}