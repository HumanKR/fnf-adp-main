package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;

	var curCharacter:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	public var finishThing:Void->Void;

	var portraitLeft:FlxSprite;
	var portraitRight:FlxSprite;
	var portraitB:FlxSprite; //belem
	var portraitA:FlxSprite; //ammo
	var portraitN:FlxSprite; //nite
	var portraitG:FlxSprite; //gf and bf maybe

	var handSelect:FlxSprite;
	var bgFade:FlxSprite;

	var cutscene:FlxSprite;
	public var curCutscene:Int = 1;
	var inject:Bool = false;
	var curTxtLine:Int = 1;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>, ?injectCutscene:Bool)
	{
		super();
		inject = injectCutscene;

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				FlxG.sound.playMusic(Paths.music('Lunchbox'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'thorns':
				FlxG.sound.playMusic(Paths.music('LunchboxScary'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'encounter' | 'enhanced':
				//FlxG.sound.playMusic(Paths.music('Lunchbox'), 0);
				//FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'evolution':
				//FlxG.sound.playMusic(Paths.music('LunchboxScary'), 0);
				//FlxG.sound.music.fadeIn(1, 0, 0.8);
		}

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai' | 'thorns' | 'roses':
			{
				bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFFB3DFd8);
				bgFade.scrollFactor.set();
				bgFade.alpha = 0;
				add(bgFade);

				new FlxTimer().start(0.83, function(tmr:FlxTimer)
				{
					bgFade.alpha += (1 / 5) * 0.7;
					if (bgFade.alpha > 0.7)
						bgFade.alpha = 0.7;
				}, 5);
			}
		}

		box = new FlxSprite(-20, 45);
		
		var hasDialog = false;
		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
			case 'roses':
				hasDialog = true;
				FlxG.sound.play(Paths.sound('ANGRY_TEXT_BOX'));

				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-senpaiMad');
				box.animation.addByPrefix('normalOpen', 'SENPAI ANGRY IMPACT SPEECH', 24, false);
				box.animation.addByIndices('normal', 'SENPAI ANGRY IMPACT SPEECH', [4], "", 24);

			case 'thorns':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-evil');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);

				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.image('weeb/spiritFaceForward'));
				face.setGraphicSize(Std.int(face.width * 6));
				add(face);

			case 'encounter' | 'enhanced' | 'evolution':
				if (injectCutscene){
					switch (PlayState.SONG.song.toLowerCase())
					{
						case 'enhanced':
							curCutscene = 6;
						case 'evolution':
							curCutscene = 11;
					}
				}
				else
				{
					switch (PlayState.SONG.song.toLowerCase())
					{
						case 'enhanced':
							curCutscene = 7;
						case 'evolution':
							curCutscene = 12;
					}
				}
				cutscene = new FlxSprite(0, 0).loadGraphic(Paths.image('adp/cut/$curCutscene'));
				add(cutscene);
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('adp/dia');
				box.animation.addByIndices('normalOpen', 'dia', [0,1,2,3,4,5,6,7,8,9,10], "", 24,false);
				box.animation.addByIndices('normal', 'dia', [11], "", 24);
				box.setPosition();
		}

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return;
		
		portraitLeft = new FlxSprite(-20, 40);
		portraitLeft.frames = Paths.getSparrowAtlas('weeb/senpaiPortrait');
		portraitLeft.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		portraitLeft.visible = false;

		portraitRight = new FlxSprite(226.55, 463).loadGraphic(Paths.image('adp/bfport'));
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		portraitRight.visible = false;

		portraitB = new FlxSprite(226.55, 463).loadGraphic(Paths.image('adp/belemport'));
		portraitB.updateHitbox();
		portraitB.scrollFactor.set();
		portraitB.visible = false;

		portraitA = new FlxSprite(226.55, 463).loadGraphic(Paths.image('adp/ammoport'));
		portraitA.updateHitbox();
		portraitA.scrollFactor.set();
		portraitA.visible = false;

		portraitN = new FlxSprite(226.55, 463).loadGraphic(Paths.image('adp/niteport'));
		portraitN.updateHitbox();
		portraitN.scrollFactor.set();
		portraitN.visible = false;

		portraitG = new FlxSprite(226.55, 463).loadGraphic(Paths.image('adp/gfport'));
		portraitG.updateHitbox();
		portraitG.scrollFactor.set();
		portraitG.visible = false;
		
		box.animation.play('normalOpen');
		//box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.9));
		box.updateHitbox();
		add(box);
		add(portraitLeft);
		add(portraitRight);
		add(portraitB);
		add(portraitA);
		add(portraitN);
		add(portraitG);

		box.screenCenter(X);
		//portraitLeft.screenCenter(X);

		//handSelect = new FlxSprite(FlxG.width * 0.9, FlxG.height * 0.9).loadGraphic(Paths.image('weeb/pixelUI/hand_textbox'));
		//add(handSelect);


		if (!talkingRight)
		{
			// box.flipX = true;
		}

		dropText = new FlxText(203, 524.75, Std.int(FlxG.width * 0.6), "", 32);
		dropText.font = 'Gotham Rounded Bold';
		dropText.color = 0xFF000000;
		add(dropText);

		swagDialogue = new FlxTypeText(201, 522.75, Std.int(FlxG.width * 0.6), "", 32);
		swagDialogue.font = 'Gotham Rounded Bold';
		swagDialogue.color = 0xFFFFFFFF;
		swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		add(swagDialogue);

		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
		// HARD CODING CUZ IM STUPDI
		if (PlayState.SONG.song.toLowerCase() == 'roses')
			portraitLeft.visible = false;
		if (PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft.color = FlxColor.BLACK;
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.BLACK;
		}

		dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normal');
				dialogueOpened = true;
			}
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		if (FlxG.keys.justPressed.ANY  && dialogueStarted == true)
		{
			remove(dialogue);
				
			FlxG.sound.play(Paths.sound('clickText'), 0.8);
			if (PlayState.storyWeek == 0)
			{
				curTxtLine++;
				switch (PlayState.SONG.song.toLowerCase())
				{
					case 'encounter':
					{
						if (curTxtLine == 14 || curTxtLine == 16 || curTxtLine == 18 || curTxtLine == 20)
							changeCutscene();
					}
					case 'enhanced':
					{
						if (curTxtLine == 9 || curTxtLine == 17 || curTxtLine == 19)
							changeCutscene();
					}
					case 'evolution':
					{
						if (curTxtLine == 8)
							changeCutscene();
					}
				}
			}

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;

					if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns')
						FlxG.sound.music.fadeOut(2.2, 0);

					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						switch (PlayState.SONG.song.toLowerCase())
						{
							case 'senpai' | 'thorns' | 'roses':
							{
								bgFade.alpha -= 1 / 5 * 0.7;
							}
						}
						portraitLeft.visible = false;
						portraitRight.visible = false;
						swagDialogue.alpha -= 1 / 5;
						dropText.alpha = swagDialogue.alpha;
					}, 5);

					new FlxTimer().start(1.2, function(tmr:FlxTimer)
					{
						finishThing();
						kill();
					});
				}
			}
			else
			{
				dialogueList.remove(dialogueList[0]);
				startDialogue();
			}
		}
		
		super.update(elapsed);
	}

	var isEnding:Bool = false;

	function changeCutscene():Void
	{
		if (!inject)
		{
			remove(cutscene);
			trace('cutscene remove');
			curCutscene++;
			trace('curcutscene = ' + curCutscene);
			cutscene = new FlxSprite(0, 0).loadGraphic(Paths.image('adp/cut/$curCutscene'));
			add(cutscene);
			trace('cutscene add');
		}
	}

	function startDialogue():Void
	{
		cleanDialog();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);

		switch (curCharacter)
		{
			case 'dad':
				portraitRight.visible = false;
				portraitB.visible = false;
				portraitA.visible = false;
				portraitN.visible = false;
				portraitG.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
				}
					portraitLeft.animation.play('enter',true);
			case 'nite':
				portraitRight.visible = false;
				portraitB.visible = false;
				portraitA.visible = false;
				portraitG.visible = false;
				if (!portraitN.visible)
				{
					portraitN.visible = true;
					//portraitN.animation.play('enter',true);
				}
			case 'ammo':
				portraitRight.visible = false;
				portraitB.visible = false;
				portraitN.visible = false;
				portraitG.visible = false;
				if (!portraitA.visible)
				{
					portraitA.visible = true;
					//portraitA.animation.play('enter',true);
				}
			case 'belem':
				portraitRight.visible = false;
				portraitA.visible = false;
				portraitN.visible = false;
				portraitG.visible = false;
				if (!portraitB.visible)
				{
					portraitB.visible = true;
					//portraitB.animation.play('enter',true);
				}
			/*case 'both':
				portraitLeft.visible = false;
				portraitRight.visible = false;
				portraitN.visible = false;
				portraitG.visible = false;
				if (!portraitB.visible)
				{
					portraitB.visible = true;
				}
				if (!portraitA.visible)
				{
					portraitA.visible = true;
					portraitB.x = 165;
					portraitA.x = 371;
					portraitB.animation.play('enter',true);
					portraitA.animation.play('enter',true);
				}*/
			case 'bf':
				portraitLeft.visible = false;
				portraitB.visible = false;
				portraitA.visible = false;
				portraitN.visible = false;
				portraitG.visible = false;
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					//portraitRight.animation.play('enter',true);
				}
			case 'gf':
				portraitLeft.visible = false;
				portraitB.visible = false;
				portraitA.visible = false;
				portraitN.visible = false;
				portraitRight.visible = false;
				if (!portraitG.visible)
				{
					portraitG.visible = true;
					//portraitG.animation.play('enter',true);
				}
		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
	}
}
