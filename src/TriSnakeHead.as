package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	public class TriSnakeHead extends Sprite
	{
		[Embed(source="../swf/snake_head_triangle.swf"]
		private var SnakeHeadImage:Class;		
		
		private var snakeHead:DisplayObject = new SnakeHeadImage();
		public function TriSnakeHead()
		{
			this.addChild(snakeHead);
		}
	}
}