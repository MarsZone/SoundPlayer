package player.events
{
	import flash.events.Event;
	
	import player.view.CustomTreeItemRenderer;

	public class ItemRenderEvent extends Event
	{
		public static const DOUBLE_CLICK:String = "itemDoubleClick";
		public function ItemRenderEvent(type:String,item:CustomTreeItemRenderer, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this._item = item;
		}
		
		private var _item:CustomTreeItemRenderer;
		public function get item():CustomTreeItemRenderer
		{
			return _item;
		}
		
		override public function clone():Event
		{
			return new ItemRenderEvent(type,item, bubbles, cancelable);
		}
	}
}