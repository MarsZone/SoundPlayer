package player.events.sound
{
	import flash.events.Event;

	public class LoadSoundEvent extends Event
	{
		public static const IOERROR_SOUND_EVENT:String = "IOERROR_SOUND_EVENT";
		public static const PROGRESS_SOUND_EVENT:String = "PROGRESS_SOUND_EVENT";
		public static const ID3_SOUND_EVENT:String = "ID3_SOUND_EVENT";
		public static const COMPLETE_SOUND_EVENT:String = "COMPLETE_SOUND_EVENT";
		
		
		public function LoadSoundEvent(type:String, value:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_value = value;
		}
		
		private var _value:String;
		public function get value():String
		{
			return _value;
		}
		
		override public function clone():Event
		{
			return new LoadSoundEvent(type, value, bubbles, cancelable);
		}
	}
}