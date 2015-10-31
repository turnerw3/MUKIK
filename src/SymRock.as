package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class SymRock extends Sprite
	{
		
		//public properties
		
		public var bSize: int = 45;
		
		public var type:int;  //for the type of Rock.  0=triangle, 1=square, 2=cross
		//size of the snake
		public var Symbol:Sprite;
		
		public function SymRock(t:int)
		{			
			type = t;
			
			//decide which symbol to put on
			if (type==0) {
				Symbol = new Triangle();
				
			}
			else if(type==1) {
				Symbol = new Square();
				
			}
			else if(type==2) {
				Symbol = new Cross();
				
			}
			else {
				Symbol = new Skull();
			}
			this.addChild(Symbol);			
		}		
	}
}