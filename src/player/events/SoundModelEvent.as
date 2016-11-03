package player.events
{
	import flash.events.Event;
	import flash.media.Sound;

	public class SoundModelEvent extends Event
	{
		
		public function SoundModelEvent(type:String, value:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_value = value;
		}
		
		private var _value:Sound;
		public function get value():Sound
		{
			return _value;
		}
		
		override public function clone():Event
		{
			return new SoundModelEvent(type, value, bubbles, cancelable);
		}
	}
}