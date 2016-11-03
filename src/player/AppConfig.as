package player
{	
	
	import player.control.ChooseFolderCommand;
	import player.control.LoadSoundCommand;
	import player.control.SetFolderDataCommand;
	import player.control.*;
	import player.events.utils.ButtonClickEvent;
	import player.events.FileResultEvent;
	import player.events.*;
	import player.events.sound.*;
	import player.events.utils.*;
	import player.events.utils.ItemRenderEvent;
	import player.model.FileModel;
	import player.model.*;
	import player.service.FileService;
	import player.service.FolderService;
	import player.service.IFileService;
	import player.service.IFolderService;
	import player.service.LoadSoundService;
	import player.view.SoundPlayerContainer;
	import player.view.SoundPlayerContainerMediator;
	import player.view.TreeContainer;
	import player.view.TreeContainerMediator;
	
	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.framework.api.IConfig;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.IInjector;
	import robotlegs.bender.framework.api.ILogger;
	import robotlegs.bender.framework.api.LogLevel;
	
	public class AppConfig implements IConfig
	{
		[Inject]
		public var injector:IInjector;
		
		[Inject]
		public var mediatorMap:IMediatorMap;
		
		[Inject]
		public var commandMap:IEventCommandMap;
		
		[Inject]
		public var logger:ILogger;
		
		[Inject]
		public var _context:IContext;
		
		public function AppConfig(){}
		
		public function configure():void
		{
			models();
			mediators();
			commands();
			_context.logLevel = LogLevel.DEBUG;
			logger.info("logger in AppConfig");
		}
		private function models():void
		{
			injector.map(IFileService).toSingleton(FileService);
			injector.map(IFolderService).toSingleton(FolderService);
			injector.map(LoadSoundService).asSingleton();
			
			injector.map(FileModel).asSingleton();
			injector.map(FolderModel).asSingleton();
			injector.map(SoundModel).asSingleton();
		}
		
		private function mediators():void
		{
			mediatorMap.map(TreeContainer).toMediator(TreeContainerMediator);
			mediatorMap.map(SoundPlayerContainer).toMediator(SoundPlayerContainerMediator);
		}
		
		private function commands():void
		{
			//commandMap.map(ItemRenderEvent.DOUBLE_CLICK,ItemRenderEvent).toCommand();
			commandMap.map(FileResultEvent.FILE_RESULT,FileResultEvent).toCommand(SetSelectedFileCommand);
			
			commandMap.map(ButtonClickEvent.CHOOSE_FOLDER,ButtonClickEvent).toCommand(ChooseFolderCommand);
			commandMap.map(FolderResultEvent.FOLDER_RESULT,FolderResultEvent).toCommand(SetFolderDataCommand);
			
			commandMap.map(ItemRenderEvent.DOUBLE_CLICK,ItemRenderEvent).toCommand(LoadSoundCommand);
			
			commandMap.map(SoundModelEvent.SOUND_RECEIVE,SoundModelEvent).toCommand(SetSoundCommand);
		}
	}
}