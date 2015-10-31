package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	public class Rock extends Sprite
	{
		[Embed(source="../swf/rock_plain.swf"]
		private var RockImage:Class;		
		
		private var Rock:DisplayObject = new RockImage();
		public function Rock()
		{
			this.addChild(Rock);
		}
	}
}