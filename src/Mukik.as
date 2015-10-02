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
		
		public var vx:int;
		public var vy:int;
		public function Mukik()
		{
			createGame();
			setupListeners();
			
		}
		public function createGame():void {
			snake = new Snake(0);
			addObject(background, 0, 0);
			addObject(snake, 150, 50);
			snake.addBody(4, snake);
		}
		public function addObject(object:Sprite, xpos:int, ypos:int):void {
			
			stage.addChild(object);
			object.x = xpos;
			object.y = ypos;
		}
		public function setupListeners():void {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			//stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		public function enterFrameHandler(event:Event):void {
			//move the snake
			snake.x += vx;
			snake.y += vy;
			//check bounds
			if (snake.x<50 || snake.x>stage.stageWidth-50) {
				vx *= -1;
				vy=0
			}
			if (snake.y<50 || snake.y>stage.stageHeight-50) {
				vy *= -1;
				vx=0
				//snake.y += vx;
			}			
		}
		public function keyDownHandler(event:KeyboardEvent):void {
			if(event.keyCode == Keyboard.RIGHT) {
				vx=5;
				vy=0;
				snake.turnSnake("right", snake);
			}
			else if(event.keyCode == Keyboard.LEFT) {
				vx=-5;
				vy=0;
				snake.turnSnake("left",snake);
			}
			else if(event.keyCode == Keyboard.UP) {
				vy=-5;
				vx=0;
				snake.turnSnake("up", snake);
			}
			else if(event.keyCode == Keyboard.DOWN) {
				vy=5;
				vx=0;
				snake.turnSnake("down", snake);
			}
		}
	}
}