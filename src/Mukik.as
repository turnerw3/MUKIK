package
{//old version still on github if this gets too screwed up
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	[SWF(width="650", height="500", backgroundColor="#000000", frameRate="24")]
	
	public class Mukik extends Sprite
	{
		public var background: Background = new Background();
		public var snake:Snake;
		public var b:int = 45;//variable for the box size of the game... the size of the square of the snake's body parts and the blocks.
		public var xTurn:int;
		public var yTurn:int;
		
		public var size:int = 3; //length of the snake
		public var snakeBods:Array = new Array();
		public var bod:SnakeBod;
		private var tail:SnakeTail = new SnakeTail();
		public var vx:int;
		public var vy:int;
		public var bvx:int;
		public var bvy:int;
		public var dir:String; //l,r,u,d for the direction the snake is going.
		public var turn:Boolean = false;
		public var bounce:Boolean = false;
		public function Mukik()
		{
			createGame();
			setupListeners();
			
		}
		public function createGame():void {
			snake = new Snake(0);
			addObject(background, 0, 0);
			addObject(snake, 200, 50);
			addBody(size);
			
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
		public function addBody(size:int):void {
			
			//Add the body segments
			var p:int = 0;    //placeholder for putting on the snake bods
			for(var i:int = 0; i<size; i++){
				bod = new SnakeBod();
				p += 45;
				addObject(bod, snake.x-p, snake.y);				
				bod.rotation = 90;
				snakeBods.push(bod);
			}
			p +=45;
			addObject(tail,snake.x-p, snake.y);
			tail.rotation = 90;
			snakeBods.push(tail);
		}
		
		
		public function enterFrameHandler(event:Event):void {
			//var p:int = 0;
			snake.x += vx;
			snake.y += vy;
			for(var i:int = 0; i<size+1; i++) {
				snakeBods[i].x += vx;
				snakeBods[i].y += vy;
			}	
				
			if(bounce) {
				for(var i:int = 0; i<snakeBods.length; i++) {
					
					if (dir == "r") { //trying this out
						/*
						if (snake.x<b*2) { 
							snakeBods[i].y = snake.y;
							snakeBods[i].x = snake.x;
							//snakeBods[i].rotation = 90;
						}
						*/
						if (snake.x<b*3) {
							if(i==0) {
								snakeBods[i].x = snake.x-b;
								snakeBods[i].y = yTurn;
								snakeBods[i].rotation = 90;
							}
							
							if (i>0) {
							snakeBods[i].visible = false;
							//snakeBods[i].y = yTurn+b;
							}
							
						}
						else if (snake.x<b*4) {
							if(i==1) {
								snakeBods[i].x = snake.x-b*(i+1);
								snakeBods[i].y = yTurn;
								snakeBods[i].rotation = 90;
								snakeBods[i].visible = true;
							}
							/*
							if (i>1) {
								snakeBods[i].y += bvy;
								snakeBods[i].x += bvx;
							}
							*/
						}
						else if (snake.x<b*5) {
							if(i==2) {
								snakeBods[i].x = snake.x-b*(i+1);
								snakeBods[i].y = yTurn;
								snakeBods[i].rotation = 90;
								snakeBods[i].visible = true;

							}
							/*
							if (i>2) {
								snakeBods[i].y += bvy;
								snakeBods[i].x += bvx;
							}
							*/
						}
						else if (snake.x<b*6) {
							if(i==3) {
								snakeBods[i].x = snake.x-b*(i+1);
								snakeBods[i].y = yTurn;
								snakeBods[i].rotation = 90;
								snakeBods[i].visible = true;

							}
							/*
							if (i>3) {
								snakeBods[i].y += bvy;
								snakeBods[i].x += bvx;
							}
							*/
						}
						else {
							bounce = false;
						}
					}
				}
								
			}
			else if (turn) {
				//var j:int = 0;
				for(var i:int = 0; i<snakeBods.length; i++) {
					//j++;
					if (dir == "d") {
						if(snake.y < yTurn+b*2){
							if(i==0) {
								snakeBods[i].y = snake.y-b;
								snakeBods[i].x = xTurn;
								snakeBods[i].rotation = 180;
							}
							if (i>0) {
								snakeBods[i].y = yTurn;
								snakeBods[i].x += bvx*1.1;
							}
						}						
						
						else if(snake.y < yTurn+b*3) {
							if(i==1) {
								snakeBods[i].y = snake.y-b*(i+1);
								snakeBods[i].x = xTurn;
								snakeBods[i].rotation = 180;
							}
							if (i>1) {
								snakeBods[i].y = yTurn;
								snakeBods[i].x += bvx*1.1;
							}
						}
						else if(snake.y < yTurn+b*4) {
							if(i==2) {
								snakeBods[i].y = snake.y-b*(i+1);
								snakeBods[i].x = xTurn;
								snakeBods[i].rotation = 180;
							}
							if (i>2) {
								snakeBods[i].y = yTurn;
								snakeBods[i].x += bvx*1.1;
							}
						}
						else if(snake.y < yTurn+b*5) {
							if(i==3) {
								snakeBods[i].y = snake.y-b*(i+1);
								snakeBods[i].x = xTurn;
								snakeBods[i].rotation = 180;
							}
							if (i>3) {
								snakeBods[i].y = yTurn;
								snakeBods[i].x += bvx*1.1;
							}
						}
						else {
							turn = false;
						}						
					}
					if (dir == "l") {
						if(snake.x > xTurn-b*2){
							if(i==0) {
								snakeBods[i].x = snake.x+b;
								snakeBods[i].y = yTurn;
								snakeBods[i].rotation = -90;
							}
							if (i>0) {
								snakeBods[i].x = xTurn;
								snakeBods[i].y += bvy*1.1;
							}
						}						
							
						else if(snake.x > xTurn-b*3){
							if(i==1) {
								snakeBods[i].x = snake.x+b*(i+1);
								snakeBods[i].y = yTurn;
								snakeBods[i].rotation = -90;
							}
							if (i>1) {
								snakeBods[i].x = xTurn;
								snakeBods[i].y += bvy*1.1;
							}												
						}
						else if(snake.x > xTurn-b*4){
							if(i==2) {
								snakeBods[i].x = snake.x+b*(i+1);
								snakeBods[i].y = yTurn;
								snakeBods[i].rotation = -90;
							}
							if (i>2) {
								snakeBods[i].x = xTurn;
								snakeBods[i].y += bvy*1.1;
							}
						}						
						else if(snake.x > xTurn-b*5){
							if(i==3) {
								snakeBods[i].x = snake.x+b*(i+1);
								snakeBods[i].y = yTurn;
								snakeBods[i].rotation = -90;
							}
							if (i>3) {
								snakeBods[i].x = xTurn;
								snakeBods[i].y += bvy*1.1;
							}
						}						
						else {
							turn = false;
						}						
					}
				}				
			}
			/*
			else {
				
			}
			*/
			
				/*
				if (snakeBods[i].x < 50){
					snakeBods[i].x = 50;
				}
				
				if (snakeBods[i].x > stage.stageWidth - 50){
					snakeBods[i].x = stage.stageWidth-50;
				}
				if (snakeBods[i].y > stage.stageHeight - 50){
					snakeBods[i].y = stage.stageHeight - 50;
				}
				if (snakeBods[i].y < 50){
					snakeBods[i].y = 50;
				}
				*/
				
			
			//I need to redo turnSnake and put all these things that repeat in there.
			if (snake.x<50) {
				bvx = vx;
				bvy = vy;
				vx *= -1;
				vy=0;
				snake.y-=50;
				snake.x+=50;
				xTurn = snake.x;
				yTurn = snake.y;
				bounce = true;
				snake.rotation = 0;
				//turnSnake("right", snake);
				dir='r';			
			}
			if (snake.x>stage.stageWidth-50){
				xTurn = snake.x;
				yTurn = snake.y;
				vx *= -1;
				vy=0;
				snake.y+=50;
				snake.x-=50;
				bounce = true;
				snake.rotation = 180;
				//turnSnake("left", snake); 
				dir='l';
			}			
			if (snake.y>stage.stageHeight-50) {
				xTurn = snake.x;
				yTurn = snake.y;
				vy *= -1;
				vx=0;
				snake.x-=50;
				snake.y-=50;
				bounce = true;
				snake.rotation = -90;
				//turnSnake("up", snake);
				dir='u';
			}
			if (snake.y<50) {
				xTurn = snake.x;
				yTurn = snake.y;
				vy *= -1;
				vx=0;
				snake.x+=50;
				snake.y+=50;
				bounce = true;
				snake.rotation = 90;
				//turnSnake("down", snake);	
				dir='d';
			}			
		}
		public function keyDownHandler(event:KeyboardEvent):void {
			bvx = vx;
			bvy = vy;
			if(event.keyCode == Keyboard.RIGHT) {				
				vx=5;
				vy=0;				
				if (dir!='r') {
					turn = true;
					xTurn = snake.x;
					yTurn = snake.y;
					if (dir=='u') {snake.x+=50;}
					else {snake.y-=50;}
					snake.rotation = 0;					
					dir='r';
				}
				
			}
			else if(event.keyCode == Keyboard.LEFT) {
				vx=-5;
				vy=0;
				if (dir!='l') {
					turn = true;
					xTurn = snake.x;
					yTurn = snake.y;
					if (dir=='d') {snake.x-=50;}
					else {snake.y+=50;}
					snake.rotation = 180;					
					dir='l';
				}
			}
			else if(event.keyCode == Keyboard.UP) {
				vy=-5;
				vx=0;
				if (dir!='u') {
					turn = true;
					xTurn = snake.x;
					yTurn = snake.y;
					if (dir=='l') {snake.y-=50;}
					else {snake.x-=50;}					
					snake.rotation = -90;					
					dir='u';
				}
			}
			else if(event.keyCode == Keyboard.DOWN) {				
				vy=5;
				vx=0;
				if (dir!='d') {
					turn = true;
					xTurn = snake.x;
					yTurn = snake.y;
					if (dir=='r') {snake.y+=50;}
					else {snake.x+=50;}						
					snake.rotation = 90;					
					dir='d';
				}
			}
		}
		//all this needs to be fixed again to go along with being added to the stage instead of the snake.
		//now I am cutting out the use of this method to turn the snake bodies a different way.
		public function turnSnake(dir:String, snake:Sprite):void {  //input the direction of the turn with the keyboard event; "up" "down" "left" or "right" (right could actually be any other string.)
			
			//var bods:Array = body;
			var p:int = 0;
			var x:int = snake.x;
			var y:int = snake.y;
			if (dir=="up") {
				snake.rotation = -90;				
				for (var i: int = 0; i<size; i++) {
					p += 45;					
					snakeBods[i].x = snake.x;
					snakeBods[i].y = snake.y+p; 
					snakeBods[i].rotation = 0;					
				}
				p+=45;
				tail.x = snake.x;
				tail.y = snake.y+p;
				tail.rotation = 0;
			}
			else if (dir=="down") {
				snake.rotation = 90;				
				for (var i: int = 0; i<size; i++) {
					p += 45;
					snakeBods[i].x = snake.x;
					snakeBods[i].y = snake.y-p;
					snakeBods[i].rotation = 180;					
				}
				p+=45;
				tail.x = snake.x;
				tail.y = snake.y-p;
				tail.rotation = 180;
			}
			else if (dir=="left") {
				snake.rotation = 180;
				for (var i: int = 0; i<size; i++) {
					p += 45;
					snakeBods[i].x = snake.x+p;
					snakeBods[i].y = snake.y; 
					snakeBods[i].rotation = -90;
				}
				p += 45;
				tail.x = snake.x+p;
				tail.y = snake.y;
				tail.rotation = -90;
			}
			else {
				snake.rotation = 0;
				for (var i: int = 0; i<size; i++) {
					p += 45;
					snakeBods[i].x = snake.x-p;
					snakeBods[i].y = snake.y; 
					snakeBods[i].rotation = 90;
				}
				p += 45;
				tail.x = snake.x-p;
				tail.y = snake.y;
				tail.rotation = 90;
			}
		}
		public function removeBod():void {
			snakeBods.pop();
			this.removeChild(snakeBods[size-2]);
	} 
	}
}