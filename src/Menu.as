package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.ui.Keyboard;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	public class Menu extends Sprite
	{
		[Embed(source="../mp3/menuTheme.mp3")]
		private var BgMusic:Class;
		private var music:Sound = new BgMusic();
		private var musicChannel:SoundChannel = new SoundChannel();
		
		[Embed(source="../swf/menuTitleBackground.swf")]
		private var TextureImage:Class;			
		private var texture:DisplayObject = new TextureImage();
		[Embed(source="../swf/jungleTexture.swf")]
		private var TextureImage2:Class;			
		private var texture2:DisplayObject = new TextureImage2();
		[Embed(source="../swf/menuTitle.swf")]
		private var TitleImage:Class;			
		private var title:DisplayObject = new TitleImage();
		[Embed(source="../swf/menuH2P1.swf")]
		private var H2P1Image:Class;			
		private var H2P1:DisplayObject = new H2P1Image();
		[Embed(source="../swf/menuH2P2.swf")]
		private var H2P2Image:Class;			
		private var H2P2:DisplayObject = new H2P2Image();
		[Embed(source="../swf/menuStory.swf")]
		private var StoryImage:Class;			
		private var Story:DisplayObject = new StoryImage();
		[Embed(source="../swf/menuTitleBTN.swf")]
		private var TitleBTNImage:Class;			
		private var titleBTN:DisplayObject = new TitleBTNImage();
		[Embed(source="../swf/menuStoryBTN.swf")]
		private var MenuBTNImage:Class;			
		private var menuBTN:DisplayObject = new MenuBTNImage();
		private var screen:int = 0;
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
			_stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			//stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);  //not needed for constant movement.
			//_stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		private function mouseDownHandler(event:MouseEvent):void {
			if (screen == 0) {
				if (_stage.mouseY > 700) {
					
						this.removeChild(texture);
						this.addChild(texture2);
						this.removeChild(title);
						this.addChild(Story);
						this.removeChild(titleBTN);
						this.addChild(menuBTN);
						screen++;
					
				}
					
			}
			else {
			if (_stage.mouseX > 700 && _stage.mouseY > 700 ) {
				
				if (screen == 1) {
					this.removeChild(Story);
					this.addChild(H2P1);
					
					screen++;
				}
				else if (screen == 2) {
					this.removeChild(H2P1);
					this.addChild(H2P2);
					screen++;
					
				}
				else if (screen == 3) {
					musicChannel.stop();
					dispatchEvent(new Event("levelOneStart", true));
					_stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
					_stage.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
					
				}
			}
			else if (_stage.mouseX < 300 && _stage.mouseY > 700) {
				if (screen == 1) {
					this.removeChild(texture2);
					this.addChild(texture);					
					this.removeChild(Story);
					this.addChild(title);
					this.removeChild(menuBTN);
					this.addChild(titleBTN);
					screen--;
				}
				else if (screen == 2) {
					this.removeChild(H2P1);
					this.addChild(Story);
					screen--;
					
				}
				else if (screen == 3) {
					this.removeChild(H2P2);
					this.addChild(H2P1);
					screen--;
					
				}
			}
			}
			
		}
		public function keyDownHandler(event:KeyboardEvent):void {
			
			if(event.keyCode == Keyboard.RIGHT) {	
				if (screen == 0) {
					this.removeChild(texture);
					this.addChild(texture2);
					this.removeChild(title);
					this.addChild(Story);
					this.removeChild(titleBTN);
					this.addChild(menuBTN);
					screen++;
				}
				else if (screen == 1) {
					this.removeChild(Story);
					this.addChild(H2P1);
								
					screen++;
				}
				else if (screen == 2) {
					this.removeChild(H2P1);
					this.addChild(H2P2);
					screen++;
					
				}
				else if (screen == 3) {
					musicChannel.stop();
					dispatchEvent(new Event("levelOneStart", true));
					_stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
					_stage.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
					
				}
					
				
			}
			else if(event.keyCode == Keyboard.LEFT) {
				if (screen == 1) {
					this.removeChild(texture2);
					this.addChild(texture);					
					this.removeChild(Story);
					this.addChild(title);
					this.removeChild(menuBTN);
					this.addChild(titleBTN);
					screen--;
				}
				else if (screen == 2) {
					this.removeChild(H2P1);
					this.addChild(Story);
					screen--;
				
				}
				else if (screen == 3) {
					this.removeChild(H2P2);
					this.addChild(H2P1);
					screen--;
					
				}
				
			}
		}
	}
}