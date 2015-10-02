package
{
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class Snake extends Sprite
	{
				
		//public properties
		
		public var bSize: int = 50;
		
		public var t:int;  //for the type of snake.  0=triangle, 1=square, 2=cross
		  //size of the snake
		public var snakeHead:Sprite;
		public var snakeBods:Array = new Array();
		public var bod:SnakeBod;
		private var tail:SnakeTail = new SnakeTail();
		public function Snake(type:int)
		{
			
			t = type;
			
			//decide which snake head to put on
			if (t==0) {
				snakeHead = new TriSnakeHead();
				
			}
			else if(t==1) {
				snakeHead = new SquareSnakeHead();
				
			}
			else {
				snakeHead = new CrossSnakeHead();
				
			}
			this.addChild(snakeHead);
			snakeHead.rotation = 90;
		
		}
		//public function addBod():void {
		//	var bod:SnakeBod = new SnakeBod();
		//	snakeBods.push(bod);
			
		//}
		public function addBody(size:int, snake:Sprite):void {
			
			//Add the body segments
			var p:int = 0;    //placeholder for putting on the snake bods
			for(var i:int = 0; i<size; i++){
				bod = new SnakeBod();
				snake.addChild(bod);
				p += 50;
				bod.x = (snake.x+100) - p;  //these shouldn't be right.  I think there is a problem with the reference point on the swf file.
				bod.y = snake.y-50;
				
				bod.rotation = 90;
				snakeBods.push(bod);
			}
			p += bSize;
			snake.addChild(tail);
			tail.x = snake.x-p;
			tail.y = snake.y;
			tail.rotation = 90;
		}
		
		public function removeBod():void {
			
			snakeBods.pop();
			snakeHead.removeChild(snakeBods[snakeBods.length-1]);
		}
		//below needs fixed
		public function turnSnake(dir:String, snake:Sprite):void {  //input the direction of the turn with the keyboard event; "up" "down" "left" or "right" (right could actually be any other string.)
			var length:int = snakeBods.length;
			var p:int = 0;
			var x:int = snake.x;
			var y:int = snake.y;
			if (dir=="up") {
				snakeHead.rotation = 0;
				for (var i: int = 0; i<length; i++) {
					p += bSize;
					
					snakeBods[i].x = x;
					snakeBods[i].y = y - p; 
					snakeBods[i].rotation = 0;
				}
				p+=bSize
				tail.x = x;
				tail.y = y - p;
				tail.rotation = 0;
			}
			else if (dir=="down") {
				snakeHead.rotation = 180;
				for (var i: int = 0; i<length; i++) {
					p += bSize;
					snakeBods[i].x = x;
					snakeBods[i].y = y + p;
					snakeBods[i].rotation = 180;
				}
				tail.x = snakeHead.x;
				tail.y = snakeHead.y + p;
				tail.rotation = 180;
			}
			else if (dir=="left") {
				snakeHead.rotation = 270;
				for (var i: int = 0; i<length; i++) {
					p += bSize;
					snakeBods[i].x = x + p;
					snakeBods[i].y = y; 
					snakeBods[i].rotation = 270;
				}
				tail.x = x + p;
				tail.y = y;
				tail.rotation = 270;
			}
			else {
				snakeHead.rotation = 90;
				for (var i: int = 0; i<length; i++) {
					p += bSize;
					snakeBods[i].x = x - p;
					snakeBods[i].y = y; 
					snakeBods[i].rotation = 90;
				}
				tail.x = x - p;
				tail.y = y;
				tail.rotation = 90;
			}
		}
	}
}