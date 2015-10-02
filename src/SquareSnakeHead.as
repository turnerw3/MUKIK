package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	public class SquareSnakeHead extends Sprite
	{
		[Embed(source="../swf/snake_head_rectangle.swf"]
		private var SnakeHeadImage:Class;		
		
		private var snakeHead:DisplayObject = new SnakeHeadImage();
		public function SquareSnakeHead()
		{
			this.addChild(snakeHead);
		}
	}
}