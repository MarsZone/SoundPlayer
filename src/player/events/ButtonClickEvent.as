package player.events
{
	import flash.events.Event;
	
	public class ButtonClickEvent extends Event
	{
		public static const CHOOSE_FILE:String = "chooseFile";
		public static const CHOOSE_FOLDER:String = "chooseFolder";
		
		public function ButtonClickEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new ButtonClickEvent(type, bubbles, cancelable);
		}
	}
}

