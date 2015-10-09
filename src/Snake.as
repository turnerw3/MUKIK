package
{
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class Snake extends Sprite
	{
				
		//public properties
		
		public var bSize: int = 45;
		
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
			//adding body segments is much more natural than I once thought because it knows zero to be lined up with it's parent (the snake head essentially)
			//Add the body segments
			var p:int = 0;    //placeholder for putting on the snake bods
			for(var i:int = 0; i<size; i++){
				bod = new SnakeBod();
				this.addChild(bod);
				p += 45;
				bod.x = -p;  
				bod.y = 0;
				
				bod.rotation = 90;
				snakeBods.push(bod);
			}
			p += 45;
			this.addChild(tail);
			tail.x = -p;
			tail.y = 0;
			tail.rotation = 90;
		}
		
		public function removeBod():void {
			
			snakeBods.pop();
			snakeHead.removeChild(snakeBods[snakeBods.length-1]);
		}
		//below needs fixed
		public function turnSnake(dir:String, snake:Sprite):void {  //input the direction of the turn with the keyboard event; "up" "down" "left" or "right" (right could actually be any other string.)
			var length:int = snakeBods.length;
			//var bods:Array = body;
			var p:int = 0;
			var x:int = snake.x;
			var y:int = snake.y;
			if (dir=="up") {
				snakeHead.rotation = 0;				
				for (var i: int = 0; i<length; i++) {
					p += bSize;					
					snakeBods[i].x = 0;
					snakeBods[i].y = p; 
					snakeBods[i].rotation = 0;					
				}
				p+=bSize;
				tail.x = 0;
				tail.y = p;
				tail.rotation = 0;
			}
			else if (dir=="down") {
				snakeHead.rotation = 180;				
				for (var i: int = 0; i<length; i++) {
					p += bSize;
					snakeBods[i].x = 0;
					snakeBods[i].y = -p;
					snakeBods[i].rotation = 180;					
				}
				p+=bSize;
				tail.x = 0;
				tail.y = -p;
				tail.rotation = 180;
			}
			else if (dir=="left") {
				snakeHead.rotation = -90;
				for (var i: int = 0; i<length; i++) {
					p += bSize;
					snakeBods[i].x = p;
					snakeBods[i].y = 0; 
					snakeBods[i].rotation = -90;
				}
				p += bSize;
				tail.x = p;
				tail.y = 0;
				tail.rotation = -90;
			}
			else {
				snakeHead.rotation = 90;
				for (var i: int = 0; i<length; i++) {
					p += bSize;
					snakeBods[i].x = -p;
					snakeBods[i].y = 0; 
					snakeBods[i].rotation = 90;
				}
				p += bSize;
				tail.x = -p;
				tail.y = 0;
				tail.rotation = 90;
			}
		}
	}
}