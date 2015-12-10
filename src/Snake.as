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
		public var snakeHead0:Sprite = new TriSnakeHead;
		public var snakeHead1:Sprite = new SquareSnakeHead;
		public var snakeHead2:Sprite = new CrossSnakeHead;

		public function Snake(t:int)
		{
			this.addChild(snakeHead0);
			this.addChild(snakeHead1);
			this.addChild(snakeHead2);
			snakeHead0.visible = false;
			snakeHead1.visible = false;
			snakeHead2.visible = false;
			type = t;
			
			//decide which snake head to put on
			if (type==0) {
				snakeHead0.visible = true;
				
			}
			else if(type==1) {
				snakeHead1.visible = true;
				
			}
			else if(type==2){
				snakeHead2.visible = true;
				
			}
			
			
		
		}
		public function switchHead():void 
		{
			if(type == 0) {
				type = 1;
				snakeHead0.visible = false;
				snakeHead1.visible = true;
			}
			else if(type == 1) {
				type = 2;
				snakeHead1.visible = false;
				snakeHead2.visible = true;
			}
			else if(type == 2) {
				type = 0;
				snakeHead2.visible = false;
				snakeHead0.visible = true;
			}
		}
				
	}
}