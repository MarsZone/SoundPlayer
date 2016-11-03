package player.service
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.filesystem.File;
	
	import player.events.FolderResultEvent;
	import mx.collections.ArrayCollection;

	public class FolderService implements IFolderService
	{
		[Inject]
		public var eventDispatcher:IEventDispatcher;
		
		private var _file:File;
		
		
		public function promptToChooseFolder():void
		{
			_file = File.desktopDirectory;
			_file.addEventListener(Event.SELECT,onFolderSelect);
			_file.browseForDirectory("请选择一个文件夹");
		}
		private function onFolderSelect(event:Event):void
		{
			var arrs:Array = _file.getDirectoryListing();
			var arrCollection:ArrayCollection = new ArrayCollection();
			getAllFile(arrs,arrCollection);
			eventDispatcher.dispatchEvent(new FolderResultEvent(FolderResultEvent.FOLDER_RESULT, arrCollection));
		}
		
		//内部遍历所有的文件.
		protected function getAllFile(arrs:Array,arrCollection:ArrayCollection):ArrayCollection{
			var dir_arr:ArrayCollection = new ArrayCollection;
			for each(var arr_file:File in arrs){
				if(arr_file.isDirectory){
					//如果是目录.保存
					dir_arr.addItem({name:arr_file.name,nativePath:arr_file.nativePath});
				}else{
					//判断是否为map3 or wav
					if(arr_file.extension=="mp3"|| arr_file.extension =="wav")
					{
						arrCollection.addItem({name:arr_file.name,nativePath:arr_file.nativePath,url:arr_file.url});
					}
				}
			}
			//遍历目录
			for each(var dir:* in dir_arr)
			{
				//file = new File(dir['nativePath']);
				var temp_file:File = new File(dir['nativePath']);
				var arrs:Array = temp_file.getDirectoryListing();
				
				//递归调用
				arrCollection.addItem({name:dir['name'],children:getAllFile(arrs,new ArrayCollection())})
				
			}
			return arrCollection;
		}
	}
}