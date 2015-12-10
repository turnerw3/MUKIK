package
{//old version still on github if this gets too screwed up
	//import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.ui.Keyboard;
	
	[SWF(width="1050", height="900", backgroundColor="#000000", frameRate="30")]
	
	public class Mukik extends Sprite
	{
		private var _menu:Menu;
		private var _levelOne:LevelOne;
		private var _levelTwo:LevelTwo;
		
		public function Mukik() 
		{
			_menu = new Menu(stage);
			_levelOne = new LevelOne(stage);
			_levelTwo = new LevelTwo(stage);
			stage.addChild(_menu);
			stage.addEventListener("levelOneStart", MenuHandler);
			stage.addEventListener("levelOneRestart", LevelOneRestart);
			stage.addEventListener("levelTwoStart", LevelTwoStart);
			stage.addEventListener("levelTwoRestart", LevelTwoRestart);
			
			
		}
		private function MenuHandler(event:Event): void {
			stage.removeChild(_menu);
			_menu = null;
			stage.addChild(_levelOne);
			
		}
		private function LevelTwoStart(event:Event): void {
			stage.removeChild(_levelOne);
			_levelOne = null;
			stage.addChild(_levelTwo);
			
		}
		private function LevelOneRestart(event:Event): void {
		
				stage.removeChild(_levelOne);
				_levelOne = null;
				_levelOne = new LevelOne(stage);
				stage.addChild(_levelOne);
		
			
		}
		private function LevelTwoRestart(event:Event): void {
			
			stage.removeChild(_levelTwo);
			_levelTwo = null;
			_levelTwo = new LevelTwo(stage);
			stage.addChild(_levelTwo);
			
			
		}
	}
		
}