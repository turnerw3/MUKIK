package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.ui.Keyboard;
	public class Menu extends Sprite
	{
		[Embed(source="../mp3/menuTheme.mp3")]
		private var BgMusic:Class;
		private var music:Sound = new BgMusic();
		private var musicChannel:SoundChannel = new SoundChannel();
		
		[Embed(source="../swf/jungleTexture.swf")]
		private var TextureImage:Class;			
		private var texture:DisplayObject = new TextureImage();
		[Embed(source="../swf/menuTitle.swf")]
		private var TitleImage:Class;			
		private var title:DisplayObject = new TitleImage();
		[Embed(source="../swf/menuH2P1.swf")]
		private var H2P1Image:Class;			
		private var H2P1:DisplayObject = new H2P1Image();
		[Embed(source="../swf/menuH2P2.swf")]
		private var H2P2Image:Class;			
		private var H2P2:DisplayObject = new H2P2Image();
		[Embed(source="../swf/menuTitleBTN.swf")]
		private var TitleBTNImage:Class;			
		private var titleBTN:DisplayObject = new TitleBTNImage();
		
		private var _stage:Object;
		public function Menu(stage:Object)
		{
			_stage = stage;
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		private function addedToStageHandler(event:Event): void {
			createMenu();
			this.removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			
		}
		private function createMenu():void {
			musicChannel = music.play(0, int.MAX_VALUE);
			this.addChild(texture);
			this.addChild(title);
			this.addChild(titleBTN);
			
			setupListeners();
		}
		public function setupListeners():void {
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			//stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);  //not needed for constant movement.
			//_stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		public function keyDownHandler(event:KeyboardEvent):void {
			
			if(event.keyCode == Keyboard.RIGHT) {				
				this.removeChild(title);
				this.addChild(H2P1);				
				
			}
			else if(event.keyCode == Keyboard.LEFT) {
				
				
			}
		}
	}
}