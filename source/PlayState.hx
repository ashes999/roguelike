package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	private var texts:Array<Array<FlxText>>;
	private static inline var FONT_SIZE:Int = 24;

	override public function create():Void
	{
		super.create();
		var columns:Int = Math.floor(Main.GAME_WIDTH / (FONT_SIZE / 2)); // X
		var rows:Int = Math.floor(Main.GAME_HEIGHT / FONT_SIZE); // Y
		this.texts = [for (x in 0...columns) [for (y in 0...rows) createText(x, y, ".")]];
		trace('Created a ${columns}x${rows} grid');
		this.texts[20][5].text = "@";
	}
	
	function createText(x:Float, y:Float, char:String)
	{
		var text = new FlxText(x * FONT_SIZE / 2, y * FONT_SIZE, char);
		text.setFormat("assets/Inconsolata_Regular.ttf", FONT_SIZE, FlxColor.WHITE);
		add(text);
		return text;
	}
}