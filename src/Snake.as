package
{
	import flash.diplay.DisplayObject;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class Snake extends Sprite
	{
		[Embed(source="../gifs/snake.gif"]
		private var SnakeImage:Class;		
		
		private var _snake:DisplayObject = new SnakeImage();
		
		//public properties
		public var vx:int = 0;
		public var vy:int = 0;
		public var t:int;  //for the type of snake.  0=triangle, 1=square, 2=cross, 3=death
		public function Snake(type:int)
		{
			t = type;
			
			
		}
	}
}