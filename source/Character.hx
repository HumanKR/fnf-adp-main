package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.animation.FlxAnimationController;

using StringTools;

class Character extends FlxSprite
{
	public var animOffsets:Map<String, Array<Dynamic>>;
	public var debugMode:Bool = false;

	public var isPlayer:Bool = false;
	public var curCharacter:String = 'bf';

	public var holdTimer:Float = 0;

	public var animations:Array<FlxAnimationController> = [];

	public var otherFrames:Array<Character>;

	public function new(x:Float, y:Float, ?character:String = "bf", ?isPlayer:Bool = false)
	{
		super(x, y);

		animOffsets = new Map<String, Array<Dynamic>>();
		curCharacter = character;
		this.isPlayer = isPlayer;

		var tex:FlxAtlasFrames;
		antialiasing = true;

		switch (curCharacter)
		{
			case 'gf':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('characters/GF_assets');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('sad', -2, -2);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');

			case 'gf-car':
				tex = Paths.getSparrowAtlas('characters/gfCar');
				frames = tex;
				animation.addByIndices('singUP', 'GF Dancing Beat Hair blowing CAR', [0], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat Hair blowing CAR', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat Hair blowing CAR', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24,
					false);

				addOffset('danceLeft', 0);
				addOffset('danceRight', 0);

				playAnim('danceRight');


			case 'bf':
				var tex = Paths.getSparrowAtlas('characters/BOYFRIEND', 'shared');
				frames = tex;

				trace(tex.frames.length);

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);
				animation.addByPrefix('stun', 'BF hit', 24, false);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				addOffset('scared', -4);
				addOffset('stun', -5);

				playAnim('idle');

				flipX = true;

			case 'bf-car':
				var tex = Paths.getSparrowAtlas('characters/bfCar');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				playAnim('idle');

				flipX = true;

			case 'belem':
				frames = Paths.getSparrowAtlas('adp/belem_asset');
				animation.addByPrefix('idle', 'belem idle', 24, false);
				animation.addByPrefix('singUP', 'belem up', 24, false);
				animation.addByPrefix('singDOWN', 'belem down', 24, false);
				animation.addByPrefix('singLEFT', 'belem left', 24, false);
				animation.addByPrefix('singRIGHT', 'belem right', 24, false);
	
				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");
	
				playAnim('idle');
	
			case 'ammo':
				frames = Paths.getSparrowAtlas('adp/ammo_asset');
				animation.addByPrefix('idle', 'ammo idle', 24, false);
				animation.addByPrefix('singUP', 'ammo up', 24, false);
				animation.addByPrefix('singDOWN', 'ammo down', 24, false);
				animation.addByPrefix('singLEFT', 'ammo left', 24, false);
				animation.addByPrefix('singRIGHT', 'ammo right', 24, false);
	
				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");
	
				playAnim('idle');
	
			/*case 'nite':
				frames = Paths.getSparrowAtlas('adp/nite_asset_old');
				animation.addByPrefix('idle', 'nite idle', 24, false);
				animation.addByPrefix('singUP', 'nite up', 24, false);
				animation.addByPrefix('singDOWN', 'nite down', 24, false);
				animation.addByPrefix('singLEFT', 'nite left', 24, false);
				animation.addByPrefix('singRIGHT', 'nite right', 24, false);
	
				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");
				
				playAnim('idle');*/

			case 'nite':
				//tex = CachedFrames.cachedInstance.fromSparrow('idle','adp/nite/Idle');
				tex = Paths.getSparrowAtlas('adp/nite/Idle');
				trace('tex loaded');

				frames = tex;

				graphic.persist = true;
				graphic.destroyOnNoUse = false;

				animation.addByPrefix('idle','nite idle', 24);
				trace('animation prefix loaded');

				// they have to be left right up down, in that order.
				// cuz im too lazy to dynamicly get these names
				// cry about it

				otherFrames = new Array<Character>();


				otherFrames.push(new Character(100, 100, 'niteLeft'));
				otherFrames.push(new Character(100, 100, 'niteRight'));
				otherFrames.push(new Character(100, 100, 'niteUp'));
				otherFrames.push(new Character(100, 100, 'niteDown'));
				otherFrames.push(new Character(100, 100, 'niteRock'));

				animations.push(animation);
				for (i in otherFrames)
					animations.push(animation);
				
				trace('poggers');

				addOffset("idle");
				playAnim('idle');

			case 'niteDown':
				//tex = CachedFrames.cachedInstance.fromSparrow('down','adp/nite/Down');
				tex = Paths.getSparrowAtlas('adp/nite/Down');

				frames = tex;

				graphic.persist = true;
				graphic.destroyOnNoUse = false;

				animation.addByPrefix('idle','nite down', 24);

				addOffset("idle");

				playAnim('idle');
				
			case 'niteUp':
				//tex = CachedFrames.cachedInstance.fromSparrow('up','adp/nite/Up');
				tex = Paths.getSparrowAtlas('adp/nite/Up');

				frames = tex;

				graphic.persist = true;
				graphic.destroyOnNoUse = false;

				animation.addByPrefix('idle','nite up', 24);

				addOffset("idle");

				playAnim('idle');

			case 'niteRight':
				//tex = CachedFrames.cachedInstance.fromSparrow('right','adp/nite/Right');
				tex = Paths.getSparrowAtlas('adp/nite/Right');

				frames = tex;

				graphic.persist = true;
				graphic.destroyOnNoUse = false;

				animation.addByPrefix('idle','nite right', 24);

				addOffset("idle");

				playAnim('idle');

			case 'niteLeft':
				//tex = CachedFrames.cachedInstance.fromSparrow('left','adp/nite/Left');
				tex = Paths.getSparrowAtlas('adp/nite/Left');

				frames = tex;

				graphic.persist = true;
				graphic.destroyOnNoUse = false;

				animation.addByPrefix('idle','nite left', 24);

				addOffset("idle");

				playAnim('idle');

			case 'niteRock':
				//tex = CachedFrames.cachedInstance.fromSparrow('rock','adp/nite/Rock');
				tex = Paths.getSparrowAtlas('adp/nite/Rock');

				frames = tex;

				graphic.persist = true;
				graphic.destroyOnNoUse = false;

				animation.addByPrefix('idle','nite rock', 24);

				addOffset("idle");

				playAnim('idle');

			case 'nite-old':
				frames = Paths.getSparrowAtlas('adp/nite_asset_old');
				animation.addByPrefix('idle', 'nite idle', 24, false);
				animation.addByPrefix('singUP', 'nite up', 24, false);
				animation.addByPrefix('singDOWN', 'nite down', 24, false);
				animation.addByPrefix('singLEFT', 'nite left', 24, false);
				animation.addByPrefix('singRIGHT', 'nite right', 24, false);
		
				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");
				
				playAnim('idle');
			/*case 'ammo-change':
				frames = Paths.getSparrowAtlas('adp/ammo_change');
				animation.addByPrefix('idle', 'ammo change');

				addOffset('idle');*/
			/*case 'nite-change':
				frames = Paths.getSparrowAtlas('adp/nite_change');
				animation.addByPrefix('idle', 'nite change');
	
				addOffset('idle');*/
		}

		dance();

		if (isPlayer)
		{
			flipX = !flipX;

			// Doesn't flip for BF, since his are already in the right place???
			if (!curCharacter.startsWith('bf'))
			{
				// var animArray
				var oldRight = animation.getByName('singRIGHT').frames;
				animation.getByName('singRIGHT').frames = animation.getByName('singLEFT').frames;
				animation.getByName('singLEFT').frames = oldRight;

				// IF THEY HAVE MISS ANIMATIONS??
				if (animation.getByName('singRIGHTmiss') != null)
				{
					var oldMiss = animation.getByName('singRIGHTmiss').frames;
					animation.getByName('singRIGHTmiss').frames = animation.getByName('singLEFTmiss').frames;
					animation.getByName('singLEFTmiss').frames = oldMiss;
				}
			}
		}
	}

	public function addOtherFrames()
	{
		
		for (i in otherFrames)
			{
				PlayState.staticVar.add(i);
				i.visible = false;
			}
	}

	override function update(elapsed:Float)
	{
		if (!curCharacter.startsWith('bf'))
		{
			if (animation.curAnim.name.startsWith('sing'))
			{
				holdTimer += elapsed;
			}

			var dadVar:Float = 4;

			if (curCharacter == 'dad')
				dadVar = 6.1;
			if (holdTimer >= Conductor.stepCrochet * dadVar * 0.001)
			{
				if (curCharacter != 'niteLeft' && curCharacter != 'niteRight' && curCharacter != 'niteDown' && curCharacter != 'niteUp' && curCharacter != 'niteRock')
				{
					trace('dance');
					dance();
					holdTimer = 0;
				}
			}
		}

		switch (curCharacter)
		{
			case 'gf':
				if (animation.curAnim.name == 'hairFall' && animation.curAnim.finished)
					playAnim('danceRight');
		}

		super.update(elapsed);
	}

	private var danced:Bool = false;

	/**
	 * FOR GF DANCING SHIT
	 */
	public function dance()
	{
		if (!debugMode)
		{
			switch (curCharacter)
			{
				case 'gf':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'gf-car':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				default:
					playAnim('idle');
			}
		}
	}

	public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
	{
		if (debugMode && otherFrames != null)
		{
		}
		else if (otherFrames != null && PlayState.dad != null && PlayState.generatedMusic)
		{
			visible = false;
			for(i in otherFrames)
			{
				i.visible = false;
				i.x = x;
				i.y = y;
			}

			switch(AnimName)
			{
				case 'singLEFT':
					otherFrames[0].visible = true;
					otherFrames[0].playAnim('idle', Force, Reversed, Frame);
				case 'singRIGHT':
					otherFrames[1].visible = true;
					otherFrames[1].playAnim('idle', Force, Reversed, Frame);
				case 'singUP':
					otherFrames[2].visible = true;
					otherFrames[2].playAnim('idle', Force, Reversed, Frame);
				case 'singDOWN':
					otherFrames[3].visible = true;
					otherFrames[3].playAnim('idle', Force, Reversed, Frame);
				case 'ROCK':
					otherFrames[4].visible = true;
					otherFrames[4].playAnim('idle', Force, Reversed, Frame);
				default:
					visible = true;

					animation.play(AnimName, Force, Reversed, Frame);

					var daOffset = animOffsets.get(AnimName);
					if (animOffsets.exists(AnimName))
						offset.set(daOffset[0], daOffset[1]);
					else
						offset.set(0, 0);
			}
		}
		else if (otherFrames != null && PlayState.dad != null)
		{
			visible = true;
			animation.play('idle', Force, Reversed, Frame);
			
			var daOffset = animOffsets.get('idle');
			if (animOffsets.exists('idle'))
				offset.set(daOffset[0], daOffset[1]);
			else
				offset.set(0, 0);
		}
		else
		{
			animation.play(AnimName, Force, Reversed, Frame);

			var daOffset = animOffsets.get(AnimName);
			if (animOffsets.exists(AnimName))
			{
				offset.set(daOffset[0], daOffset[1]);
			}
			else
				offset.set(0, 0);

			if (curCharacter == 'gf')
			{
				if (AnimName == 'singLEFT')
				{
					danced = true;
				}
				else if (AnimName == 'singRIGHT')
				{
					danced = false;
				}

				if (AnimName == 'singUP' || AnimName == 'singDOWN')
				{
					danced = !danced;
				}
			}
		}
	}

	public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		animOffsets[name] = [x, y];
	}
}
