package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	public class Skull extends Sprite
	{
		[Embed(source="../swf/rock_skull.swf"]
		private var RockImage:Class;		
		
		private var Skull:DisplayObject = new RockImage();
		public function Skull()
		{
			this.addChild(Skull);
		}
	}
}