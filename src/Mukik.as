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
		public var b:int = 20;//variable for the box size of the game... the size of the square of the snake's body parts.
		public var xTurn:int;
		public var yTurn:int;
		private var board: Array = new Array();
		private var rock:Rock;
		private var rocks:Array = new Array();
		public var symbol:SymRock;
		private var symRocks:Array = new Array();
		
		public var size:int = 10;//length of the snake
		public var snakeBods:Array = new Array();
		public var bod:SnakeBod;
		private var tail:SnakeTail = new SnakeTail();
		public var vx:int = 2;
		public var vy:int = 0;
		public var bvx:int;
		public var bvy:int;
		//public var path:Array = new Array(size);//idk
		public var dir:String; //l,r,u,d for the direction the snake is going.
		public var turn:Boolean = false;
		public var bounce:Boolean = false;
		private var path: Array = new Array(size+1);  //this three dimensional array holds the number of snake body segments (including the tail) of path[i][x,y,r] = [x position, y position, and rotation being 0,1,2,3] for 0=vertical 1=90 degrees clockwise 2=180 and 3=270!  This will be stored 10 times for each segment to follow the path of the snake head.
		private var pCount:int = 0; //path counter
		private var pathMax:int = b/2;  // maximum paths needed to remember = the width of a body divided by the pixels moved per frame... or b/vx. if vx/y changes you must change 2 to match.
		private var bodyCount:int = path.length-1;
		public function Mukik()
		{
			board = 
				[
					[0,0,0,0,0,0,0,0,0,0,0],
					[0,0,0,0,0,0,0,0,0,0,0],
					[0,0,4,2,3,1,2,2,4,0,0],
					[0,0,2,0,0,0,0,0,1,1,4],
					[4,1,1,0,0,0,0,0,3,0,0],
					[0,0,3,0,0,4,1,3,2,0,0],
					[0,0,3,0,0,3,0,0,1,0,0],
					[0,0,4,0,0,2,0,0,1,0,0]
				];
			createGame();
			setupListeners();
			
		}
		public function createGame():void {
			snake = new Snake(0);		
			addObject(background, 0, 0);
			
			
			
			for (var i:int=0;i<board.length;i++) {
				for (var j:int=0;j<board[0].length;j++) {
					if (board[i][j] > 0) {       //if the board has something other than zero put a rock there.
						rock = new Rock();
						addObject(rock, j*50 + 50, i*50 + 50);
						rocks.push(rock);
						
						if(board[i][j] == 1) {    //if the number is one put a hidden triangle there
							symbol = new SymRock(0);
							addObject(symbol, j*50 + 50, i*50 + 50);
							symRocks.push(symbol);
							symbol.visible = false;
						}
						if(board[i][j] == 2) {    //if the number is two put a hidden square there
							symbol = new SymRock(1);
							addObject(symbol, j*50 + 50, i*50 + 50);
							symRocks.push(symbol);
							symbol.visible = false;
						}
						if(board[i][j] == 3) {    //if the number is three put a hidden cross there
							symbol = new SymRock(2);
							addObject(symbol, j*50 + 50, i*50 + 50);
							symRocks.push(symbol);
							symbol.visible = false;
						}
						if(board[i][j] == 4) {    //if the number is four put a hidden skull there
							symbol = new SymRock(3);
							addObject(symbol, j*50 + 50, i*50 + 50);
							symRocks.push(symbol);
							symbol.visible = false;
						}
					}
				}
			}
			
			for (var i:int = 0; i<path.length; i++) {
				path[i] = new Array(pathMax); 
			}
			for (var i:int = 0; i<path.length; i++) {
				for (var j:int = 0; j<pathMax; j++) {
					path[i][j] = [(200-i*b) + j*2, 50, 90];
				}
			}
			addObject(snake, 200, 50);
			snake.rotation = 90;
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
			
			for(var i:int = 0; i<size; i++){
				bod = new SnakeBod();
				
				addObject(bod, path[i][0][0], path[i][0][1]);	//use path to place the bodies		
				bod.rotation = path[i][0][2];
				//bod.visible = false;
				snakeBods.push(bod);
				
			}
			/*
			addObject(tail,path[size][0][0], path[size][0][1]);
			tail.rotation = path[size][0][2];
			//tail.visible = false;
			snakeBods.push(tail);
			*/
		}
		//addPath is the soul of the snake body movement.
		public function addPath(x:int, y:int, r:int):void {
			
			if(bodyCount >= 0) {
				if (pCount < pathMax) {
					path[bodyCount][pCount] = [x,y,r];
				}
			}			
			pCount++;
			if (pCount == pathMax) {
				pCount = 0;
				bodyCount--;
				if (bodyCount == 0) {
					bodyCount = path.length-1;
				}
				
			}		
			
		}
		
		
		public function enterFrameHandler(event:Event):void {
			//var p:int = 0;
			snake.x += vx;
			snake.y += vy;
			
			for(var i:int = 0; i<snakeBods.length; i++) {
				//if (path[i+1][0][0] != 0) {
					//snakeBods[i].visible = true;
					snakeBods[i].x = path[i+1][pCount][0];
					snakeBods[i].y = path[i+1][pCount][1];
					snakeBods[i].rotation = path[i+1][pCount][2];
				//}				
				
			}
			//set the vision
			addPath(snake.x, snake.y, snake.rotation);
			//checking for collision type and direction 
			for (var i:int = 0; i<rocks.length; i++) {
				if (Math.abs(snake.x-rocks[i].x) < 100 && Math.abs(snake.y-rocks[i].y) < 100) {
					symRocks[i].visible = true;
				}
				else {symRocks[i].visible = false;}
				
				if (snake.hitTestObject(rocks[i]) && snake.type == symRocks[i].type) {
					rocks[i].visible = false;
					//symRocks[i] = null;
					//rocks[i] = null;
					//this.removeChild(symRocks[i]);
				}
				else if (snake.hitTestObject(rocks[i]) ) {
					
						if (dir=="d") {
							 
							reverse("up", snake);
						}
						else if (dir =="u") {
							reverse("down", snake);
						}
						else if (dir=="r") {
							reverse("left", snake);
						}
						else if (dir=="l") {
							reverse("right", snake);
						}
										
				}
			}	
			
			if (snake.x<50) {
				
				
				reverse("right", snake);
							
			}
			if (snake.x>stage.stageWidth-50){				
				
				reverse("left", snake); 
				
			}			
			if (snake.y>stage.stageHeight-50) {
				
				reverse("up", snake);
			
			}
			if (snake.y<50) {
				
				reverse("down", snake);	
			
			}			
		}
		public function keyDownHandler(event:KeyboardEvent):void {
			if(!turn){
				bvx = vx;
				bvy = vy;
			}
			if(event.keyCode == Keyboard.RIGHT) {				
				vx=2;
				vy=0;				
				if (dir!='r') {
					turn = true;
					xTurn = snake.x;
					
					
					if (dir=='u') {snake.x+=b;}
					else {snake.y-=b;}
					yTurn = snake.y;
					snake.rotation = 90;					
					dir='r';
				}
				
			}
			else if(event.keyCode == Keyboard.LEFT) {
				vx=-2;
				vy=0;
				if (dir!='l') {
					turn = true;
					xTurn = snake.x;
					
					
					if (dir=='d') {snake.x-=b;}
					else {snake.y+=b;}
					yTurn = snake.y;
					snake.rotation = -90;					
					dir='l';
				}
			}
			else if(event.keyCode == Keyboard.UP) {
				vy=-2;
				vx=0;
				if (dir!='u') {
					turn = true;
					
					yTurn = snake.y;
					if (dir=='l') {snake.y-=b;}
					else {snake.x-=b;}
					xTurn = snake.x;
					snake.rotation = 0;					
					dir='u';
				}
			}
			else if(event.keyCode == Keyboard.DOWN) {				
				vy=2;
				vx=0;
				if (dir!='d') {
					turn = true;
					
					yTurn = snake.y;
					if (dir=='r') {snake.y+=b;}
					else {snake.x+=b;}
					xTurn = snake.x;
					snake.rotation = 180;					
					dir='d';
				}
			}
			
		}
		public function reverse(d:String, snake:Snake): void {
			bounce = true;
			if(d == "right"){
				vx *= -1;
				vy=0;
				snake.y-=b;
				snake.x+=b;
				xTurn = snake.x;
				yTurn = snake.y;
				
				snake.rotation = 90;
				dir="r";
			}
			if (d == "left") {
				vx *= -1;
				vy=0;
				snake.y+=b;
				snake.x-=b;
				xTurn = snake.x;
				yTurn = snake.y;
				
				snake.rotation = -90;
				dir="l";
			}
			if (d == "up") {
				vy *= -1;
				vx=0;
				snake.x-=b;
				snake.y-=b;
				xTurn = snake.x;
				yTurn = snake.y;
				
				snake.rotation = 0;
				dir="u";
			}
			if (d == "down") {
				vy *= -1;
				vx=0;
				snake.x+=b;
				snake.y+=b;
				xTurn = snake.x;
				yTurn = snake.y;
				
				snake.rotation = 180;
				dir="d";
			}
			
		}
		public function removeBod():void {
			snakeBods.pop();
			path.pop();
		}
	}
		
}