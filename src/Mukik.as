package
{//old version still on github if this gets too screwed up
	//import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.ui.Keyboard;
	
	[SWF(width="1050", height="900", backgroundColor="#000000", frameRate="24")]
	
	public class Mukik extends Sprite
	{
		private var _menu:Menu;
		private var _levelOne:LevelOne;
		
		public function Mukik() 
		{
			_menu = new Menu(stage);
			stage.addChild(_menu);
		}
		
	}
		
}