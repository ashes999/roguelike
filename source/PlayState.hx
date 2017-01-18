package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	//private var texts:Array<Array<FlxText>>; // 4FPS
	//private var texts:Array<FlxText>; // 19FPS
	private var text:FlxText;
	private static inline var FONT_SIZE:Int = 24;
	
	private var draws:Int = 0;
	private var lastFpsCheck = Date.now().getTime();

	private var columns:Int = 0;
	private var rows:Int = 0;

	override public function create():Void
	{
		super.create();
		this.columns = Math.floor(Main.GAME_WIDTH / (FONT_SIZE / 2)); // X
		this.rows = Math.floor(Main.GAME_HEIGHT / FONT_SIZE); // Y
		//this.texts = [for (x in 0...columns) [for (y in 0...rows) createText(x, y, ".")]];
		this.text = createText(0, 0, "hi");
		trace('Created a ${columns}x${rows} grid');
	}
	
	function createText(x:Float, y:Float, char:String)
	{
		var text = new FlxText(x * FONT_SIZE / 2, y * FONT_SIZE, 0, char);
		text.setFormat("assets/Inconsolata_Regular.ttf", FONT_SIZE, FlxColor.WHITE);
		add(text);
		return text;
	}

	override public function update(elapsed:Float):Void
	{
		this.draws++;
		
		// Redraw everything
		var validCharacters = "abcdefghijklmnopqrstuvwxyz!@#$%^&*()-=+";
		var final = "";

		for (y in 0 ... rows)
		{
			var line = "";
			for (x in 0 ... columns)
			{
				var r = Std.int(Math.random() * validCharacters.length);
				var char = validCharacters.charAt(r);
				line += char;
			}
			final += line + "\n";
		}

		this.text.text = final;

		super.update(elapsed);

		var now = Date.now().getTime();
		var t = now - this.lastFpsCheck;
		if (t >= 1000)
		{
			t = t / 1000.0;
			var fps:Int = Std.int(this.draws / t);
			this.lastFpsCheck = now;			
			this.draws = 0;
			trace('${fps} FPS');
		}
	}
}