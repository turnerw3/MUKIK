package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	public class Square extends Sprite
	{
		[Embed(source="../swf/rock_rectangle.swf"]
		private var RockImage:Class;		
		
		private var Square:DisplayObject = new RockImage();
		public function Square()
		{
			this.addChild(Square);
		}
	}
}