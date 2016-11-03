package player.view
{
	import player.events.utils.ButtonClickEvent;
	import player.events.FolderModelEvent;
	import player.events.utils.ItemRenderEvent;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	
	public class TreeContainerMediator extends Mediator
	{
		[Inject]
		public var view:TreeContainer;
		
		override public function initialize():void{
			this.addViewListener(ButtonClickEvent.CHOOSE_FOLDER,dispatch,ButtonClickEvent);
			
			this.addViewListener(ItemRenderEvent.DOUBLE_CLICK,dispatch,ItemRenderEvent);
			
			this.addContextListener(FolderModelEvent.FOLDER_DATA_CHANGE,onFolderChange);
		}
		
		private function onFolderChange(event:FolderModelEvent):void
		{
			view.setTreeData(event.value);
		}
		
	}
}