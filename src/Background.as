package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	public class Background extends Sprite
	{
		[Embed(source="../swf/background.swf"]
		private var BackgroundImage:Class;		
		
		private var background:DisplayObject = new BackgroundImage();
		public function Background()
		{
			this.addChild(background);
		}
	}
}