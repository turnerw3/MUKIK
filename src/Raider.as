package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	public class Raider extends Sprite
	{
		[Embed(source="../swf/raider.swf"]
		private var RaiderImage:Class;		
		
		private var raider:DisplayObject = new RaiderImage();
		public var vx:int = 1;
		public var vy:int = 0;
		public var dir:String = 'r';
		public function Raider()
		{
			this.addChild(raider);
			
		}
	}
}