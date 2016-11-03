package player.control
{
	import player.events.sound.SoundModelEvent;
	import player.model.SoundModel;
	
	import robotlegs.bender.bundles.mvcs.Command;

	public class SetSoundCommand extends Command
	{
		[Inject]
		public var event:SoundModelEvent;
		
		[Inject]
		public var soundModel:SoundModel;
		
		override public function execute():void
		{
			soundModel.NewSound = event.value;
		}
	}
}