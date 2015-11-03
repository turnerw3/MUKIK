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
		private var board: Array = new Array();
		private var rock:Rock;
		private var rocks:Array = new Array();
		public var symbol:SymRock;
		private var symRocks:Array = new Array();
		//public var boxMap:Object = new Object();  //hopefully dont need this
		public var size:int = 3; //length of the snake
		public var snakeBods:Array = new Array();
		public var bod:SnakeBod;
		private var tail:SnakeTail = new SnakeTail();
		public var vx:int;
		public var vy:int;
		public var bvx:int;
		public var bvy:int;
		//public var path:Array = new Array(size);//idk
		public var dir:String; //l,r,u,d for the direction the snake is going.
		public var turn:Boolean = false;
		public var bounce:Boolean = false;
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
				p += b;
				addObject(bod, snake.x-p, snake.y);				
				bod.rotation = 90;
				snakeBods.push(bod);
			}
			p += b;
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
			//set the vision
			
			//checking for collision type and direction 
			for (var i:int = 0; i<rocks.length; i++) {
				if (Math.abs(snake.x-rocks[i].x) < 150 && Math.abs(snake.y-rocks[i].y) < 200) {
					symRocks[i].visible = true;
				}
				else {symRocks[i].visible = false;}
				
				if (snake.hitTestObject(rocks[i]) && snake.type == symRocks[i].type) {
					rocks[i].visible = false;
					symRocks[i].visible = false;
					//this.removeChild(symRocks[i]);
				}
				else if (snake.hitTestObject(rocks[i])) {
					if (snake.x > rocks[i].x && snake.x < rocks[i].x+b && snake.y > rocks[i].y && snake.y < rocks[i].y+b) {
						if (dir=="d") {
							reverse("up", snake);
						}
					}
					
				}
			}
			
			
			if (turn) {
				bounce = false;
				//var j:int = 0;
				for(var i:int = 0; i<snakeBods.length; i++) {
					//j++;
					if (dir == "d") {
						if(snake.y < yTurn+b*2){
							if(i==0) {
								snakeBods[i].y = snake.y-b;
								snakeBods[i].x = xTurn;
								snakeBods[i].rotation = 180;
								if(!snakeBods[i].visible) {
									snakeBods[i].visible = true;
								}
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
								if(!snakeBods[i].visible) {
									snakeBods[i].visible = true;
								}
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
								if(!snakeBods[i].visible) {
									snakeBods[i].visible = true;
								}
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
								if(!snakeBods[i].visible) {
									snakeBods[i].visible = true;
								}
							}
							if (i>3) {
								snakeBods[i].y = yTurn;
								snakeBods[i].x += bvx*1.1;
							}
							turn = false;
						}
												
					}
					if (dir == "u") {
						if(snake.y > yTurn-b*2){
							if(i==0) {
								snakeBods[i].y = snake.y+b;
								snakeBods[i].x = xTurn;
								snakeBods[i].rotation = 0;
							}
							if (i>0) {
								snakeBods[i].y = yTurn;
								snakeBods[i].x += bvx*1.1;
							}
						}			
							
						else if(snake.y > yTurn-b*3) {
							if(i==1) {
								snakeBods[i].y = snake.y+b*(i+1);
								snakeBods[i].x = xTurn;
								snakeBods[i].rotation = 0;
							}
							if (i>1) {
								snakeBods[i].y = yTurn;
								snakeBods[i].x += bvx*1.1;
							}
						}
						else if(snake.y > yTurn-b*4) {
							if(i==2) {
								snakeBods[i].y = snake.y+b*(i+1);
								snakeBods[i].x = xTurn;
								snakeBods[i].rotation = 0;
							}
							if (i>2) {
								snakeBods[i].y = yTurn;
								snakeBods[i].x += bvx*1.1;
							}
						}
						else if(snake.y > yTurn-b*5) {
							if(i==3) {
								snakeBods[i].y = snake.y+b*(i+1);
								snakeBods[i].x = xTurn;
								snakeBods[i].rotation = 0;
							}
							if (i>3) {
								snakeBods[i].y = yTurn;
								snakeBods[i].x += bvx*1.1;
							}
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
							turn = false;
						}
						/*
						else {
							
						}
						*/
					}
					if (dir == "r") {
						if(snake.x < xTurn+b*2){
							if(i==0) {
								snakeBods[i].x = snake.x-b;
								snakeBods[i].y = yTurn;
								snakeBods[i].rotation = 90;
							}
							if (i>0) {
								snakeBods[i].x = xTurn;
								snakeBods[i].y += bvy*1.1;
							}
						}						
							
						else if(snake.x < xTurn+b*3){
							if(i==1) {
								snakeBods[i].x = snake.x-b*(i+1);
								snakeBods[i].y = yTurn;
								snakeBods[i].rotation = 90;
							}
							if (i>1) {
								snakeBods[i].x = xTurn;
								snakeBods[i].y += bvy*1.1;
							}												
						}
						else if(snake.x < xTurn+b*4){
							if(i==2) {
								snakeBods[i].x = snake.x-b*(i+1);
								snakeBods[i].y = yTurn;
								snakeBods[i].rotation = 90;
							}
							if (i>2) {
								snakeBods[i].x = xTurn;
								snakeBods[i].y += bvy*1.1;
							}
						}						
						else if(snake.x < xTurn+b*5){
							if(i==3) {
								snakeBods[i].x = snake.x-b*(i+1);
								snakeBods[i].y = yTurn;
								snakeBods[i].rotation = 90;
							}
							if (i>3) {
								snakeBods[i].x = xTurn;
								snakeBods[i].y += bvy*1.1;
							}
							turn = false;
						}						
											
					}
				}				
			}
			else if(bounce) {
				for(var i:int = 0; i<snakeBods.length; i++) {
					
					if (dir == "r") { 
						
						if (snake.x<xTurn+b*2) {
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
						else if (snake.x<xTurn+b*3) {
							if(i==1) {
								snakeBods[i].x = snake.x-b*(i+1);
								snakeBods[i].y = yTurn;
								snakeBods[i].rotation = 90;
								snakeBods[i].visible = true;
							}
							
						}
						else if (snake.x<xTurn+b*4) {
							if(i==2) {
								snakeBods[i].x = snake.x-b*(i+1);
								snakeBods[i].y = yTurn;
								snakeBods[i].rotation = 90;
								snakeBods[i].visible = true;
								
							}
							
						}
						else if (snake.x<xTurn+b*5) {
							if(i==3) {
								snakeBods[i].x = snake.x-b*(i+1);
								snakeBods[i].y = yTurn;
								snakeBods[i].rotation = 90;
								snakeBods[i].visible = true;
								
							}
							bounce = false;
						}
						
					}
					if (dir == "l") { 
						
						if (snake.x>xTurn-b*2) {
							if(i==0) {
								snakeBods[i].x = snake.x+b;
								snakeBods[i].y = yTurn;
								snakeBods[i].rotation = -90;
							}
							
							if (i>0) {
								snakeBods[i].visible = false;
								//snakeBods[i].y = yTurn+b;
							}
							
						}
						else if (snake.x>xTurn-b*3) {
							if(i==1) {
								snakeBods[i].x = snake.x+b*(i+1);
								snakeBods[i].y = yTurn;
								snakeBods[i].rotation = -90;
								snakeBods[i].visible = true;
							}
							
						}
						else if (snake.x>xTurn-b*4) {
							if(i==2) {
								snakeBods[i].x = snake.x+b*(i+1);
								snakeBods[i].y = yTurn;
								snakeBods[i].rotation = -90;
								snakeBods[i].visible = true;
								
							}
							
						}
						else if (snake.x>xTurn-b*5) {
							if(i==3) {
								snakeBods[i].x = snake.x+b*(i+1);
								snakeBods[i].y = yTurn;
								snakeBods[i].rotation = -90;
								snakeBods[i].visible = true;
								
							}
							bounce = false;
							
						}
						
					}
					if (dir == "u") { 
						
						if (snake.y>yTurn-b*2) {
							if(i==0) {
								snakeBods[i].y = snake.y+b;
								snakeBods[i].x = xTurn;
								snakeBods[i].rotation = 0;
							}
							
							if (i>0) {
								snakeBods[i].visible = false;
								//snakeBods[i].y = yTurn+b;
							}
							
						}
						else if (snake.y>yTurn-b*3) {
							if(i==1) {
								snakeBods[i].y = snake.y+b*(i+1);
								snakeBods[i].x = xTurn;
								snakeBods[i].rotation = 0;
								snakeBods[i].visible = true;
							}
							
						}
						else if (snake.y>yTurn-b*4) {
							if(i==2) {
								snakeBods[i].y = snake.y+b*(i+1);
								snakeBods[i].x = xTurn;
								snakeBods[i].rotation = 0;
								snakeBods[i].visible = true;
								
							}
							
						}
						else if (snake.y>yTurn-b*5) {
							if(i==3) {
								snakeBods[i].y = snake.y+b*(i+1);
								snakeBods[i].x = xTurn;
								snakeBods[i].rotation = 0;
								snakeBods[i].visible = true;
								
							}
							bounce = false;
						}
						
					}
					if (dir == "d") { //trying this out
						
						if (snake.y<yTurn+b*2) {
							if(i==0) {
								snakeBods[i].y = snake.y-b;
								snakeBods[i].x = xTurn;
								snakeBods[i].rotation = 180;
							}
							
							if (i>0) {
								snakeBods[i].visible = false;
								//snakeBods[i].y = yTurn+b;
							}
							
						}
						else if (snake.y<yTurn+b*3) {
							if(i==1) {
								snakeBods[i].y = snake.y-b*(i+1);
								snakeBods[i].x = xTurn;
								snakeBods[i].rotation = 180;
								snakeBods[i].visible = true;
							}
							
						}
						else if (snake.y<yTurn+b*4) {
							if(i==2) {
								snakeBods[i].y = snake.y-b*(i+1);
								snakeBods[i].x = xTurn;
								snakeBods[i].rotation = 180;
								snakeBods[i].visible = true;
								
							}
							
						}
						else if (snake.y<yTurn+b*5) {
							if(i==3) {
								snakeBods[i].y = snake.y-b*(i+1);
								snakeBods[i].x = xTurn;
								snakeBods[i].rotation = 180;
								snakeBods[i].visible = true;
								
							}
							bounce = false;
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
				vx=5;
				vy=0;				
				if (dir!='r') {
					turn = true;
					xTurn = snake.x;
					
					
					if (dir=='u') {snake.x+=50;}
					else {snake.y-=50;}
					yTurn = snake.y;
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
					
					
					if (dir=='d') {snake.x-=50;}
					else {snake.y+=50;}
					yTurn = snake.y;
					snake.rotation = 180;					
					dir='l';
				}
			}
			else if(event.keyCode == Keyboard.UP) {
				vy=-5;
				vx=0;
				if (dir!='u') {
					turn = true;
					
					yTurn = snake.y;
					if (dir=='l') {snake.y-=50;}
					else {snake.x-=50;}
					xTurn = snake.x;
					snake.rotation = -90;					
					dir='u';
				}
			}
			else if(event.keyCode == Keyboard.DOWN) {				
				vy=5;
				vx=0;
				if (dir!='d') {
					turn = true;
					
					yTurn = snake.y;
					if (dir=='r') {snake.y+=50;}
					else {snake.x+=50;}
					xTurn = snake.x;
					snake.rotation = 90;					
					dir='d';
				}
			}
			
		}
		public function reverse(d:String, snake:Snake): void {
			bounce = true;
			if(d == "right"){
				vx *= -1;
				vy=0;
				snake.y-=50;
				snake.x+=50;
				xTurn = snake.x;
				yTurn = snake.y;
				
				snake.rotation = 0;
				dir="r";
			}
			if (d == "left") {
				vx *= -1;
				vy=0;
				snake.y+=50;
				snake.x-=50;
				xTurn = snake.x;
				yTurn = snake.y;
				
				snake.rotation = 180;
				dir="l";
			}
			if (d == "up") {
				vy *= -1;
				vx=0;
				snake.x-=50;
				snake.y-=50;
				xTurn = snake.x;
				yTurn = snake.y;
				
				snake.rotation = -90;
				dir="u";
			}
			if (d == "down") {
				vy *= -1;
				vx=0;
				snake.x+=50;
				snake.y+=50;
				xTurn = snake.x;
				yTurn = snake.y;
				
				snake.rotation = 90;
				dir="d";
			}
			
		}
		//all this needs to be fixed again to go along with being added to the stage instead of the snake.
		//now I am cutting out the use of this method to turn the snake bodies a different way.
		/*old turn snake
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
		*/
	}
		
}