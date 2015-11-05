package
{
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class Snake extends Sprite
	{
				
		//public properties
		
		public var bSize: int = 45;
		
		public var type:int;  //for the type of snake.  0=triangle, 1=square, 2=cross
		  //size of the snake
		public var snakeHead:Sprite;
		
		public function Snake(t:int)
		{
			
			type = t;
			
			//decide which snake head to put on
			if (type==0) {
				snakeHead = new TriSnakeHead();
				
			}
			else if(type==1) {
				snakeHead = new SquareSnakeHead();
				
			}
			else {
				snakeHead = new CrossSnakeHead();
				
			}
			this.addChild(snakeHead);
			
		
		}
				
	}
}