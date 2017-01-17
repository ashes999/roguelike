package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	private var texts:Array<Array<FlxText>>;
	private static inline var FONT_SIZE:Int = 24;
	
	private var draws:Int = 0;
	private var lastFpsCheck = Date.now().getTime();

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

	override public function update(elapsed:Float):Void
	{
		this.draws++;
		
		// Redraw everything
		var validCharacters = "abcdefghijklmnopqrstuvwxyz!@#$%^&*()-=+";

		for (row in this.texts)
		{
			for (text in row)
			{
				var len:Int = text.text.length;
				for (i in 0 ... len)
				{
					var r = Std.int(Math.random() * validCharacters.length);
					var char = validCharacters.charAt(r);
					text.text = setChar(text.text, i, char);
				}
			}
		}	

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

	private function setChar(str:String, pos:Int, char:String):String
	{
		var pre = str.substring(0, pos);
		var post = str.substring(pos + 1);
		return '${pre}${char}${post}';
	}
}