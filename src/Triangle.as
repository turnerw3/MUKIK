package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	public class Triangle extends Sprite
	{
		[Embed(source="../swf/rock_triangle.swf"]
		private var RockImage:Class;		
		
		private var Triangle:DisplayObject = new RockImage();
		public function Triangle()
		{
			this.addChild(Triangle);
		}
	}
}