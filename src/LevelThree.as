package
{//old version still on github if this gets too screwed up
	//import flash.display.DisplayObject;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.ui.Keyboard;
	import flash.ui.Mouse;
	
	
	public class LevelThree extends Sprite
	{
		//embed the bg music
		[Embed(source="../mp3/levelTwoTheme.mp3")]
		private var BgMusic:Class;
		private var music:Sound = new BgMusic();
		private var musicChannel:SoundChannel = new SoundChannel();
		//embed any sound effects
		[Embed(source="../mp3/rockExplosion.mp3")]
		private var RockSound:Class;
		private var rockFx:Sound = new RockSound();
		private var rockFxChannel:SoundChannel = new SoundChannel();
		[Embed(source="../mp3/bump.mp3")]
		private var BumpSound:Class;
		private var bump:Sound = new BumpSound();
		private var bumpChannel:SoundChannel = new SoundChannel();
		[Embed(source="../mp3/ting.mp3")]
		private var TingSound:Class;
		private var ting:Sound = new TingSound();
		private var tingChannel:SoundChannel = new SoundChannel();
		[Embed(source="../mp3/gameOver.mp3")]
		private var GOSound:Class;
		private var gameOver:Sound = new GOSound();
		private var GOChannel:SoundChannel = new SoundChannel();
		//load the background
		[Embed(source="../swf/stoneTexture.swf")]
		private var TextureImage:Class;			
		private var texture:DisplayObject = new TextureImage();	
		[Embed(source="../swf/levelThree.swf")]
		private var BackgroundImage:Class;			
		private var background:DisplayObject = new BackgroundImage();	
		[Embed(source="../swf/gameOverLOSE.swf")]
		private var LoseImage:Class;			
		private var lose:DisplayObject = new LoseImage();
		[Embed(source="../swf/gameOverWIN.swf")]
		private var WinImage:Class;			
		private var win:DisplayObject = new WinImage();
		[Embed(source="../swf/retryNext.swf")]
		private var RetryNextImage:Class;			
		private var retryNext:DisplayObject = new RetryNextImage();
		[Embed(source="../swf/retry.swf")]
		private var RetryImage:Class;			
		private var retry:DisplayObject = new RetryImage();
		//add explosion image
		[Embed(source = "../swf/rock_explosion.swf")]
		private var Explosion:Class;			
		private var explosion:Sprite = new Explosion();
		[Embed(source = "../swf/gem.swf")]
		private var Gem:Class;			
		private var gem:Sprite;
		[Embed(source = "../swf/cosmicGem.swf")]
		private var CosmicGem:Class;			
		private var cosmicGem:Sprite = new CosmicGem();	
		
		public var snake:Snake;
		public var b:int = 20;//variable for the box size of the game... the size of the square of the snake's body parts.
		//private var raider:Raider = new Raider()
		private var board: Array = new Array();
		private var rock:Rock;
		private var rocks:Array = new Array();
		public var symbol:SymRock;
		private var symRocks:Array = new Array();
		private var gems:Array = new Array();
		public var size:int = 7;//length of the snake
		public var snakeBods:Array = new Array();
		public var bod:SnakeBod;
		private var tail:SnakeTail = new SnakeTail();
		public var vx:int = 0;
		public var vy:int = 2;
		public var bvx:int;
		public var bvy:int;
		//public var path:Array = new Array(size);//idk
		public var dir:String; //l,r,u,d for the direction the snake is going.
		
		private var path: Array = new Array(size+1);  //this three dimensional array holds the number of snake body segments (including the tail) of path[i][x,y,r] = [x position, y position, and rotation being 0,1,2,3] for 0=vertical 1=90 degrees clockwise 2=180 and 3=270!  This will be stored 10 times for each segment to follow the path of the snake head.
		private var pCount:int = 0; //path counter
		private var pathMax:int = b/2;  // maximum paths needed to remember = the width of a body divided by the pixels moved per frame... or b/vx. if vx/y changes you must change 2 to match.
		private var bodyCount:int = path.length-1;
		private var headRand:int;
		private var rockRand:int;
		private var winlose:Boolean = false;
		private var _stage:Object;
		public function LevelThree(stage:Object)
		{
			_stage = stage;
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		private function addedToStageHandler(event:Event): void {
			createGame();
			this.removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			
		}
		
		
		public function createGame():void {
			musicChannel = music.play(0, int.MAX_VALUE);
			headRand = Math.floor(Math.random()*3);
			board = 
				[
					[0,1,0,0,2,1,0,0,1,0,0,1,0,0,1,0,0,1,0],
					[0,1,1,1,1,1,2,0,1,0,0,1,0,0,1,0,2,1,0],
					[0,1,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,0],
					[0,1,0,2,0,1,0,0,0,1,0,0,2,0,0,0,0,1,0],
					[2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0],
					[0,1,0,0,0,1,2,0,0,1,0,0,0,0,1,0,0,1,1],
					[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,0,1,0],
					[0,1,0,0,0,1,0,0,1,0,1,0,1,0,0,0,0,1,0],
					[0,1,0,2,0,1,1,1,1,0,1,0,1,1,1,1,1,1,1],
					[0,1,1,1,1,1,2,0,1,1,1,1,1,0,0,1,0,1,0],
					[0,1,0,1,0,1,0,0,1,0,2,0,0,0,0,1,0,1,0],
					[2,1,0,1,0,1,0,1,1,1,1,1,1,1,0,1,2,1,0],
					[1,1,1,1,1,1,1,1,0,0,0,0,0,1,1,1,1,1,0],
					[0,1,0,0,0,1,2,0,0,1,1,1,1,1,0,0,1,1,1],
					[0,1,1,1,1,1,1,1,1,1,2,0,0,1,1,1,1,0,0],
					[2,1,0,0,0,1,0,0,1,0,0,0,0,1,0,0,1,0,0]
				];
			snake = new Snake(headRand);
			_stage.addChild(texture);
			_stage.addChild(background);
			//addObject(raider, 750, 550);
			addObject(cosmicGem, stage.stageWidth - 110, stage.stageHeight - 100);
			
			setupListeners();
			
			
			for (var i:int=0;i<board.length;i++) {
				for (var j:int=0;j<board[0].length;j++) {
					if (board[i][j] == 1) {       //if the board has something other than zero put a rock there.
						rock = new Rock();
						addObject(rock, j*50 + 50, i*50 + 50);
						rocks.push(rock);
						rockRand = Math.floor(Math.random() * 7);
						if (rockRand <= 1) {
							symbol = new SymRock(0);
							
						}
						else if (rockRand <= 3) {
							symbol = new SymRock(1);
							
						}
						else if (rockRand <= 5) {
							symbol = new SymRock(2);
							
						}
						else if (rockRand == 6) {
							symbol = new SymRock(3);
							
						}
						addObject(symbol, j*50 + 50, i*50 + 50);
						symRocks.push(symbol);
						symbol.visible = false;
					}
					if (board[i][j] == 2) {
						
						gem = new Gem();
						addObject(gem, j*50 + 60, i*50 + 60);
						gems.push(gem);
					}
				}
			}
			
			for (var i:int = 0; i<path.length; i++) {
				path[i] = new Array(pathMax); 
			}
			for (var i:int = 0; i<path.length; i++) {
				for (var j:int = 0; j<pathMax; j++) {
					path[i][j] = [56, (130-i*b) + (j+1)*2, 0];
				}
			}
			
			addBody(size);
			//raider.visible = false;
			
		}
		public function addObject(object:Sprite, xpos:int, ypos:int):void {			
			_stage.addChild(object);
			object.x = xpos;
			object.y = ypos;
		}
		public function setupListeners():void {
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			//stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);  //not needed for constant movement.
			_stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
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
			addObject(snake, 75, 150);
			snake.rotation = 180;
			dir = 'd';
			/*
			addObject(tail,path[size][0][0], path[size][0][1]);
			tail.rotation = path[size][0][2];
			//tail.visible = false;
			snakeBods.push(tail);
			*/
		}
		//addPath is the soul of the snake body movement.
		private function addPath(x:int, y:int, r:int):void {
			
			
			
			path[bodyCount][pCount] = [x,y,r];
			pCount++;
			
			if (pCount == pathMax) {
				
				bodyCount--;
				pCount = 0;	
				
				
				trace("bodyCount: "+bodyCount);
				if (bodyCount <= 0) {
					bodyCount = path.length-1;
				}
				for (var i:int=0; i < path.length; i++) {
					trace ("path" + i);
					trace ("x: " + path[i][0][0] + ", y: " + path[i][0][1]);
					
				}
				
				
			}	
			
			
		}
		
		//trying to make the body removal more smooth looking by moving the path down the line.
		private function movePath(count:int):void {
			
		}
		
		public function enterFrameHandler(event:Event):void {
			//var p:int = 0;
			snake.x += vx;
			snake.y += vy;
			//raider.x += raider.vx;
			//raider.y += raider.vy;
			for(var i:int = 0; i<snakeBods.length; i++) {
				//if (path[i+1][0][0] != 0) {
				//snakeBods[i].visible = true;
				snakeBods[i].x = path[i+1][pCount][0];
				snakeBods[i].y = path[i+1][pCount][1];
				snakeBods[i].rotation = path[i+1][pCount][2];
				//}				
				
			}
			addPath(snake.x, snake.y, snake.rotation);
			//win condition
			if (snake.hitTestObject(cosmicGem)) {
				tingChannel = ting.play();
				_stage.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
				_stage.addChild(win);
				_stage.addChild(retry);				
				_stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
				winlose = true;
			}
			//loop through all the rocks
			for (var i:int = 0; i<rocks.length; i++) {
				//set the vision
				if (Math.abs(snake.x-rocks[i].x) < 100 && Math.abs(snake.y-rocks[i].y) < 100 && !snake.hitTestObject(rocks[i]) && symRocks[i].type != 4) {
					symRocks[i].visible = true;
				}
				else {symRocks[i].visible = false;}
				//checking for collision type and direction 
				if (snake.hitTestObject(rocks[i])) {
					//if it's a match
					if( snake.type == symRocks[i].type) {
						addObject(explosion, symRocks[i].x, symRocks[i].y);
						rocks[i].visible = false;
						//symRocks[i] = new RockExplosion();
						symRocks[i].visible = false;
						symRocks[i].type = 4;
						rockFxChannel = rockFx.play();
						
						//symRocks[i] = null;
						//rocks[i] = null;
						//this.removeChild(symRocks[i]);
					}
						//if it's a skull
					else if (symRocks[i].type == 3) {
						bumpChannel = bump.play();
						
						_stage.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
						_stage.addChild(lose);
						_stage.addChild(retry);
						musicChannel.stop();
						GOChannel = gameOver.play();
						_stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
						
					}
						
					else if (symRocks[i].type != 4) {
						bumpChannel = bump.play();
						removeBod();
						//snake.switchHead();
						if (dir=="d") {		
							snake.y-=2; //fixes it so he bounces back when he hits more than one block
							reverse("up", snake);
							
						}
						else if (dir =="u") {
							snake.y+=2;
							reverse("down", snake);
						}
						else if (dir=="r") {
							snake.x-=2;
							reverse("left", snake);
						}
						else if (dir=="l") {
							snake.x+=2;
							reverse("right", snake);
						}
						
					}
					
					
				}			
			}	
			//pickup gems
			for (var i:int = 0; i < gems.length; i++) {
				if (snake.hitTestObject(gems[i])) {
					tingChannel = ting.play();
					snake.switchHead();
					_stage.removeChild(gems[i]);
					gems.splice(i, 1);
					
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
			if(event.keyCode == Keyboard.SPACE) {
				snake.switchHead();
			}
			if(event.keyCode == Keyboard.RIGHT) {				
				vx=2;
				vy=0;				
				if (dir!='r') {
					
					
					
					
					if (dir=='u') {snake.x+=b;}
					else {snake.y-=b;}
					snake.rotation = 90;
					if (dir == 'l') {snake.x+=b;}					
					dir='r';
				}
				
			}
			else if(event.keyCode == Keyboard.LEFT) {
				vx=-2;
				vy=0;
				if (dir!='l') {
					
					
					
					if (dir=='d') {snake.x-=b;}					
					else {snake.y+=b;}
					snake.rotation = -90;
					if (dir == 'r') {snake.x-=b;}
					dir='l';
				}
			}
			else if(event.keyCode == Keyboard.UP) {
				vy=-2;
				vx=0;
				if (dir!='u') {
					
					
					if (dir=='l') {snake.y-=b;}
					else {snake.x-=b;}
					snake.rotation = 0;	
					if (dir == 'd') {snake.y-=b;}	
					dir='u';
				}
			}
			else if(event.keyCode == Keyboard.DOWN) {				
				vy=2;
				vx=0;
				if (dir!='d') {
					
					
					if (dir=='r') {snake.y+=b;}
					else {snake.x+=b;}
					snake.rotation = 180;	
					if (dir == 'u') {snake.y+=b;}	
					dir='d';
				}
			}
			
		}
		private function mouseDownHandler(event:MouseEvent):void {
			
				if (_stage.mouseY > 700) {
					dispatchEvent(new Event("levelThreeRestart", true));
					musicChannel.stop();
				}
				
			
			
			
		}
		public function reverse(d:String, snake:Snake): void {
			
			if(d == "right"){
				
				vx *= -1;
				vy=0;
				snake.y-=b;
				snake.x+=b;
				
				snake.rotation = 90;
				dir="r";
			}
			if (d == "left") {
				vx *= -1;
				vy=0;
				snake.y+=b;
				snake.x-=b;
				
				snake.rotation = -90;
				dir="l";
			}
			if (d == "up") {
				vy *= -1;
				vx=0;
				snake.x-=b;
				snake.y-=b;
				
				snake.rotation = 0;
				dir="u";
			}
			if (d == "down") {
				vy *= -1;
				vx=0;
				snake.x+=b;
				snake.y+=b;
				
				snake.rotation = 180;
				dir="d";
			}
			
		}
		public function reverseRaider(raider:Raider): void {
			var d:String = raider.dir;
			if(d == "r"){
				
				raider.vx *= -1;
				raider.vy=0;
				
				
				raider.rotation = 180;
				raider.dir="l";
			}
			
			if(d == "l"){
				
				raider.vx *= -1;
				
				
				
				raider.rotation = 0;
				raider.dir="r";
			}
			
		}
		public function removeBod():void {
			
			if (size == 0) {
				_stage.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
				_stage.addChild(lose);
				_stage.addChild(retry);
				musicChannel.stop();
				GOChannel = gameOver.play();
			}
			else {
				_stage.removeChild(snakeBods[snakeBods.length-1]);
				snakeBods[snakeBods.length-1] = null;
				path.pop();
				snakeBods.pop();
				bodyCount = path.length-1;
				
				size--;
			}
			
			
		}
	}
	
}