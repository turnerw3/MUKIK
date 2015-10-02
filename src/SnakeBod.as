package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	public class SnakeBod extends Sprite
	{
		[Embed(source="../swf/snake_body.swf"]
		private var SnakeImage:Class;		
		
		private var snakeBod:DisplayObject = new SnakeImage();
		public function SnakeBod()
		{
			this.addChild(snakeBod);
		}
	}
}