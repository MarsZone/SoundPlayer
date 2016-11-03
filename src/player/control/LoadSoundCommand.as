package player.control
{
	
	import player.events.utils.ItemRenderEvent;
	import player.service.LoadSoundService;
	
	import robotlegs.bender.bundles.mvcs.Command;

	public class LoadSoundCommand extends Command
	{
		[Inject]
		public var service:LoadSoundService;
		
		[Inject]
		public var event:ItemRenderEvent;
		
		override public function execute():void
		{
			service.load_sound(event.item.nativePath);
		}
	}
}