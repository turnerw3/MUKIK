package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	public class SnakeTail extends Sprite
	{
		[Embed(source="../swf/snake_tail.swf"]
		private var SnakeImage:Class;		
		
		private var snakeTail:DisplayObject = new SnakeImage();
		public function SnakeTail()
		{
			this.addChild(snakeTail);
		}
	}
}