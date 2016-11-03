package player.model
{
	import flash.media.Sound;
	
	import base.BaseActor;
	
	import player.events.sound.SoundModelEvent;
	

	public class SoundModel extends BaseActor
	{
		private var _sound:Sound;
		
		public function get NewSound():Sound
		{
			return this._sound;
		}
		
		public function set NewSound(value:Sound):void
		{
			this._sound = value;
			dispatch(new SoundModelEvent(SoundModelEvent.SOUND_SET, _sound));
		}
	}
}