package player.service
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.media.Sound;
	import flash.net.FileReference;
	import flash.net.registerClassAlias;
	import flash.system.MessageChannel;
	import flash.system.Worker;
	import flash.system.WorkerDomain;
	import flash.utils.ByteArray;
	
	import player.events.sound.LoadSoundEvent;
	import player.events.sound.SoundModelEvent;
	import de.popforge.format.wav.WavFormat;
	import de.popforge.audio.output.SoundFactory;

	public class LoadSoundService
	{
		[Inject]
		public var eventDispatcher:IEventDispatcher;
		
		private var sound:Sound;
		
		private var worker:Worker;
		
		private var backGroundToMain:MessageChannel;
		
		private var mainToBackGround:MessageChannel;
		
		
		public static const PROGRESS_WORKER_STATE:String = "PROGRESS_WORKER_STATE";
		public static const COMPLETE_WORKER_STATE:String = "COMPLETE_WORKER_STATE";
		public static const STREAM_URL:String = "STREAM_URL";
		public static const BACKGROUND_TO_MAIN:String = "BACKGROUND_TO_MAIN";
		public static const MAIN_TO_BACKGROUND:String = "MAIN_TO_BACKGROUND";
		
		public function load_sound(url:String):void
		{
			if(!worker)
			{
				initWorker();
				mainToBackGround.send(STREAM_URL);
				mainToBackGround.send(url);
			}else{
				mainToBackGround.send(STREAM_URL);
				mainToBackGround.send(url);
			}
		}
		protected function initWorker():void{

			registerClassAlias("flash.media.Sound",Sound);
			worker = WorkerDomain.current.createWorker(Workers.worker_SoundWorker,true);
			backGroundToMain = worker.createMessageChannel(Worker.current);
			mainToBackGround = Worker.current.createMessageChannel(worker);
			
			worker.setSharedProperty(LoadSoundService.BACKGROUND_TO_MAIN, backGroundToMain);
			worker.setSharedProperty(LoadSoundService.MAIN_TO_BACKGROUND, mainToBackGround);
			
			backGroundToMain.addEventListener(Event.CHANNEL_MESSAGE, onBackToMain);
			
			worker.start();
			
		}
		protected function onBackToMain(event:Event):void
		{
			if(backGroundToMain.messageAvailable)
			{
				var header:String = backGroundToMain.receive();
				if(header == LoadSoundService.PROGRESS_WORKER_STATE)
				{
					//gui.loadbar.scaleX = bm.receive() / bm.receive();
					var loaded:Number = backGroundToMain.receive();
					var total:Number = backGroundToMain.receive();
					var loadTime:Number = loaded  / total;
					var LoadPercent:uint = Math.round(100 * loadTime);
					
					var process_state:String = "Song size: " + total + " bytes\n" 
						+ "Loading " + LoadPercent + "%.";
					eventDispatcher.dispatchEvent(new LoadSoundEvent(LoadSoundEvent.PROGRESS_SOUND_EVENT,process_state));
				}
				else
				{
					sound = new Sound();
					//sound.load(new URLRequest(url));
					var type:String=backGroundToMain.receive();
					var bytes:ByteArray=new ByteArray();
					bytes.writeBytes(backGroundToMain.receive());
					var length:uint = backGroundToMain.receive();
					if(type=="mp3")
					{
						bytes.position=0;
						sound.loadCompressedDataFromByteArray(bytes,length);
						eventDispatcher.dispatchEvent(new SoundModelEvent(SoundModelEvent.SOUND_RECEIVE,sound));
						eventDispatcher.dispatchEvent(new LoadSoundEvent(LoadSoundEvent.COMPLETE_SOUND_EVENT,"Done."));
					}else{
						//bytes.position=0;
						//sound.loadPCMFromByteArray(bytes,length);
						//sound.loadPCMFromByteArray(bytes, bytes.bytesAvailable / 4, "float", false, 22050);
						var wavformat:WavFormat = WavFormat.decode(bytes);
						SoundFactory.fromArray(wavformat.samples, wavformat.channels, wavformat.bits, wavformat.rate, onSoundFactoryComplete);
					}
				}
			}
		}
		
		protected function onSoundFactoryComplete(_sound:Sound):void
		{
			eventDispatcher.dispatchEvent(new SoundModelEvent(SoundModelEvent.SOUND_RECEIVE,_sound));
			eventDispatcher.dispatchEvent(new LoadSoundEvent(LoadSoundEvent.COMPLETE_SOUND_EVENT,"Done."));
		}
		protected function errorHandler(event:IOErrorEvent):void {
			//songInfo.text = "Song not loaded";
			//dispatch
			eventDispatcher.dispatchEvent(new LoadSoundEvent(LoadSoundEvent.IOERROR_SOUND_EVENT,"Song not loaded"));
		}
		
		
		protected function showID3(event:Event):void {                
			var Id3:String = "Album: " + sound.id3.album + "\n" + 
				"Artist: " + sound.id3.artist + "\n" +
				"Genre: " + sound.id3.genre + "\n" +
				"Songname: " + sound.id3.songName + "\n" +
				"Track: " + sound.id3.track + "\n" +
				"Year: " + sound.id3.year;
			
			//dispatch
			eventDispatcher.dispatchEvent(new LoadSoundEvent(LoadSoundEvent.ID3_SOUND_EVENT,Id3));
		}
	}
}