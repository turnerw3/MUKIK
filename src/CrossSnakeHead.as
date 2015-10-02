package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	public class CrossSnakeHead extends Sprite
	{
		[Embed(source="../swf/snake_head_cross.swf"]
		private var SnakeHeadImage:Class;		
		
		private var snakeHead:DisplayObject = new SnakeHeadImage();
		public function CrossSnakeHead()
		{
			this.addChild(snakeHead);
		}
	}
}