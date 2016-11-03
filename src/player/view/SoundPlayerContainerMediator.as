package player.view
{
	import player.events.utils.ItemRenderEvent;
	import player.events.sound.LoadSoundEvent;
	import player.events.sound.SoundModelEvent;
	
	import robotlegs.bender.bundles.mvcs.Mediator;

	public class SoundPlayerContainerMediator extends Mediator
	{
		[Inject]
		public var view:SoundPlayerContainer;
		
		override public function initialize():void{
			
			this.addContextListener(LoadSoundEvent.ID3_SOUND_EVENT,onID3Receive);
			
			this.addContextListener(LoadSoundEvent.PROGRESS_SOUND_EVENT,onProgressHandler);
			
			this.addContextListener(LoadSoundEvent.IOERROR_SOUND_EVENT,onIOErrorHandler);
			
			this.addContextListener(LoadSoundEvent.COMPLETE_SOUND_EVENT,onCompleteHandler);
			
			this.addContextListener(ItemRenderEvent.DOUBLE_CLICK,onChoseNewSound);
			
			this.addContextListener(SoundModelEvent.SOUND_SET,onSoundChange);
		}
		
		private function onSoundChange(event:SoundModelEvent):void
		{
			// TODO Auto Generated method stub
			view.setSound(event.value);
		}
		
		private function onChoseNewSound(event:ItemRenderEvent):void
		{
			// TODO Auto Generated method stub
			view.reload();
		}
		
		private function onCompleteHandler(event:LoadSoundEvent):void
		{
			// TODO Auto Generated method stub
			view.setSongInfo(event.value);
		}
		
		private function onIOErrorHandler(event:LoadSoundEvent):void
		{
			// TODO Auto Generated method stub
			view.setSongInfo(event.value);
		}
		
		private function onProgressHandler(event:LoadSoundEvent):void
		{
			// TODO Auto Generated method stub
			view.setSongInfo(event.value);
		}
		
		private function onID3Receive(event:LoadSoundEvent):void
		{
			// TODO Auto Generated method stub
			view.setSongInfo(event.value);
		}
	}
}