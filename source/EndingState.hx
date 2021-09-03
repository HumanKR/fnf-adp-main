package;
import flixel.*;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

/**
 * ...
 * @author bbpanzu
 * Thank you so much bbpanzu XD -Human_KR
 */
class EndingState extends FlxState
{

	var _goodEnding:Bool = false;
	var _isHidden:Bool = false;
	
	public function new(goodEnding:Bool = false, hiddenEnding:Bool = false) 
	{
		super();
		_goodEnding = goodEnding;
		_isHidden = hiddenEnding;
	}
	
	override public function create():Void 
	{
		super.create();
		var end:FlxSprite = new FlxSprite(0, 0);
		if (!_isHidden && _goodEnding){
			end.loadGraphic(Paths.image("adp/end/good"));
			FlxG.sound.playMusic(Paths.music("goodEnding"),1,false);
		}else{
			end.loadGraphic(Paths.image("adp/end/bad"));
			FlxG.sound.playMusic(Paths.music("badEnding"),1,false);
		}
		if (_isHidden)
		{
			end.loadGraphic(Paths.image("adp/end/hentai"));
			FlxG.sound.playMusic(Paths.music("hiddenEnding"),1,false);
		}
		add(end);
		FlxG.camera.fade(FlxColor.BLACK, 0.8, true);
		
		
		new FlxTimer().start(8, endIt);
		
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		if (FlxG.keys.pressed.ENTER){
			endIt();
		}
		
	}
	
	
	public function endIt(e:FlxTimer=null){
		trace("ENDING");
		//FlxG.switchState(new StoryMenuState());
		openSubState(new ResultsScreen());
	}
	
}