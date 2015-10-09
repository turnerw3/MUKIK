package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	[SWF(width="650", height="500", backgroundColor="#FFFFFF", frameRate="24")]
	
	public class Mukik extends Sprite
	{
		public var background: Background = new Background();
		public var snake:Snake;
		public var body:Array = new Array();
		public var size:int = 4; //length of the snake
		public var vx:int;
		public var vy:int;
		public var dir:String; //l,r,u,d for the direction the snake is going.
		public function Mukik()
		{
			createGame();
			setupListeners();
			
		}
		public function createGame():void {
			snake = new Snake(0);
			addObject(background, 0, 0);
			addObject(snake, 200, 50);
			snake.addBody(size, snake);
			body = snake.snakeBods;
			dir = 'r';
		}
		public function addObject(object:Sprite, xpos:int, ypos:int):void {			
			stage.addChild(object);
			object.x = xpos;
			object.y = ypos;
		}
		public function setupListeners():void {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			//stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);  //not needed for constant movement.
			stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		public function enterFrameHandler(event:Event):void {
			
			snake.x += vx;
			snake.y += vy;
			
			if (snake.x<50) {
				vx *= -1;
				vy=0;
				snake.y-=50;
				snake.x+=50;
				snake.turnSnake("right", snake);
				dir='r';			
			}
			if (snake.x>stage.stageWidth-50){
				vx *= -1;
				vy=0;
				snake.y+=50;
				snake.x-=50;
				snake.turnSnake("left", snake); 
				dir='l';
			}			
			if (snake.y>stage.stageHeight-50) {
				vy *= -1;
				vx=0;
				snake.x-=50;
				snake.y-=50;
				snake.turnSnake("up", snake);
				dir='u';
			}
			if (snake.y<50) {
				vy *= -1;
				vx=0;
				snake.x+=50;
				snake.y+=50;
				snake.turnSnake("down", snake);	
				dir='d';
			}
			
		}
		public function keyDownHandler(event:KeyboardEvent):void {
			if(event.keyCode == Keyboard.RIGHT) {
				vx=5;
				vy=0;
				if (dir!='r') {
					if (dir=='u') {snake.x+=50;}
					else {snake.y-=50;}
					snake.turnSnake("right", snake);
					dir='r';
				}
				
			}
			else if(event.keyCode == Keyboard.LEFT) {
				vx=-5;
				vy=0;
				if (dir!='l') {
					if (dir=='d') {snake.x-=50;}
					else {snake.y+=50;}
					snake.turnSnake("left", snake);
					dir='l';
				}
			}
			else if(event.keyCode == Keyboard.UP) {
				vy=-5;
				vx=0;
				if (dir!='u') {
					if (dir=='l') {snake.y-=50;}
					else {snake.x-=50;}					
					snake.turnSnake("up", snake);
					dir='u';
				}
			}
			else if(event.keyCode == Keyboard.DOWN) {
				vy=5;
				vx=0;
				if (dir!='d') {
					if (dir=='r') {snake.y+=50;}
					else {snake.x+=50;}						
					snake.turnSnake("down", snake);
					dir='d';
				}
			}
		}
		 
	}
}