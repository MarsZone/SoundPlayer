package player.view
{
	//import flash.events.MouseEvent;
	import flash.events.MouseEvent;
	
	import mx.controls.treeClasses.TreeItemRenderer;
	import mx.controls.Alert;
	import player.events.utils.ItemRenderEvent;
	import flash.events.Event;
	
	public class CustomTreeItemRenderer extends TreeItemRenderer
	{
		protected var file_name:String;
		protected var file_nativePath:String;
		protected var file_url:String;
		
		public function CustomTreeItemRenderer()
		{
			super();
		}
		
		override public function set data(value:Object):void{
			if(value != null){
				super.data = value;
				this.file_name=value.name;
				this.file_nativePath = value.nativePath;
				this.file_url = value.url;
				this.doubleClickEnabled=true;
				this.addEventListener(MouseEvent.DOUBLE_CLICK,onDoubleClick);
			}
		}
		
		protected function onDoubleClick(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			trace("Double Click:"+this.file_name);
			//SoundPlayer.ctir= this;
			//this.owner.dispatchEvent(new Event(SoundPlayer.SOUND_CHOSE));
			//.dispatchEvent(new Event(CustomTreeItemRenderer.SOUND_CHOSE));
			if(!this.url)
			{
				Alert.show("This is a folder.","Warning.");
				return;
			}
			TreeContainer.ctir = this;
			this.owner.dispatchEvent(new Event(TreeContainer.ITEM_CHOSE));//tree的默认Event 是什么ListEvent. 所以如果使用别的Event会报错.
		}
		
		override protected function createChildren():void{
			super.createChildren();
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			if(super.data){
				//var tld:TreeListData = TreeListData(super.listData);
			}
		}
		public function get nativePath():String{
			return this.file_nativePath;
		}
		public function get url():String{
			return this.file_url;
		}
	}
}