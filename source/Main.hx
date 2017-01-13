package;

import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	public static inline var GAME_WIDTH:Int = 804;
	public static inline var GAME_HEIGHT:Int = 600;

	public function new()
	{
		super();
		addChild(new FlxGame(Main.GAME_WIDTH, Main.GAME_HEIGHT, PlayState, 1, 60, 60, true));
	}
}