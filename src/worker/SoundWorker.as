package worker
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.media.Sound;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.net.registerClassAlias;
	import flash.system.MessageChannel;
	import flash.system.Worker;
	import flash.utils.ByteArray;
	
	import player.service.LoadSoundService;
	
	public class SoundWorker extends Sprite
	{
		private var backGroundToMain:MessageChannel;
		
		private var mainToBackGround:MessageChannel;
		
//		private var file:File;
		private var file:File;
		private var sound:Sound;
		
		public function SoundWorker()
		{
			backGroundToMain = Worker.current.getSharedProperty(LoadSoundService.BACKGROUND_TO_MAIN);
			mainToBackGround = Worker.current.getSharedProperty(LoadSoundService.MAIN_TO_BACKGROUND);
			
			mainToBackGround.addEventListener(Event.CHANNEL_MESSAGE, onMainToBack);
		}
		
		protected function onMainToBack(event:Event):void
		{
			if(mainToBackGround.messageAvailable)
			{
				var header:String = mainToBackGround.receive();
				if(header == LoadSoundService.STREAM_URL)
				{
					var path:String = mainToBackGround.receive();
					file = new File(path);
					file.addEventListener(Event.COMPLETE, onLoadComplete);
					file.addEventListener(ProgressEvent.PROGRESS, onProgress);
					//stream.addEventListener(IOErrorEvent.IO_ERROR, streamHandler);
					//stream.addEventListener(SecurityErrorEvent.SECURITY_ERROR, streamHandler);
					file.load (); 
				}
			}
		}
		protected function errorHandler(event:IOErrorEvent):void {
			//songInfo.text = "Song not loaded";
			//dispatch
		}
		
		
		protected function onLoadComplete(event:Event):void
		{
			file.removeEventListener(Event.COMPLETE, onLoadComplete);
			file.removeEventListener(ProgressEvent.PROGRESS, onProgress);
			
			backGroundToMain.send(LoadSoundService.COMPLETE_WORKER_STATE);
			
			if(file.extension =="mp3")
			{
				backGroundToMain.send("mp3");
				backGroundToMain.send(file.data);
				backGroundToMain.send(file.data.length);	
			}else{
				backGroundToMain.send("wav");
				
				backGroundToMain.send(file.data);
				backGroundToMain.send(file.data.length);
			}
			
		}
		
		
		protected function onProgress(event:ProgressEvent):void
		{
			backGroundToMain.send(LoadSoundService.PROGRESS_WORKER_STATE);
			backGroundToMain.send(event.bytesLoaded);
			backGroundToMain.send(event.bytesTotal);
		}
	}
}