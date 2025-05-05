import funkin.gameplay.character.Character;

var bfStar:Character;
var redStar:Character;
var orange:FlxSprite;
var green:FlxSprite;
var redCutscene:FlxSprite;
var gunshot:FlxSprite;

function newBGSprite(img:String, ?x:Float, ?y:Float) {
    var spr:FlxSprite = new FlxSprite(x ?? 0.0, y ?? 0.0);
    if(img != null)
        spr.loadGraphic(Paths.image(img));
    
    return {
        spr: spr,
        loadFromSheet: function(img2:String, anim:String, fps:Int) {
            spr.frames = Paths.getSparrowAtlas(img2);
            spr.animation.addByPrefix(anim, anim, fps);
            spr.animation.play(anim);

            if(spr.animation.curAnim == null || spr.animation.curAnim.numFrames == 1)
                spr.active = false;

            return spr;
        },
        loadSparrowFrames: function(img2:String) {
            spr.frames = Paths.getSparrowAtlas(img2);
            return spr;
        }
    }
}

function onCreate() {
    bfStar = new Character('bfStar', true);
    bfStar.setPosition(1500, -1150);
	bfStar.scrollFactor.set(1.2, 1.2);
	bfStar.alpha = 0;
    bfStar.footOffset.y = 0;
    bfStar.dance();
	stage.layers[1].add(bfStar);
	
	redStar = new Character('redStar', false);
    redStar.setPosition(-100, -1200);
	redStar.flipX = false;
	redStar.scrollFactor.set(1.2, 1.2);
	redStar.alpha = 0;
    redStar.footOffset.y = 0;
    redStar.dance();
	stage.layers[1].add(redStar);

    orange = newBGSprite(null, -800, 440).loadSparrowFrames('gameplay/stages/polus/images/orange');
	orange.animation.addByPrefix('idle', 'orange_idle instance 1', 24, true);
	orange.animation.addByPrefix('wave', 'wave instance 1', 24, true);
	orange.animation.addByPrefix('walk', 'frolicking instance 1', 24, true);
	orange.animation.addByPrefix('die', 'death instance 1', 24, false);
	orange.animation.play('walk');
	orange.scale.set(0.8, 0.8);
	orange.alpha = 0;
	stage.layers[0].add(orange);
	
	// Set different offsets for each animation
	green = newBGSprite(null, -800, 450).loadSparrowFrames('gameplay/stages/polus/images/orange');
	green.animation.addByPrefix('idle', 'stand instance 1', 24, true);
	green.animation.addByPrefix('kill', 'kill instance 1', 24, false);
	green.animation.addByPrefix('walk', 'sneak instance 1', 24, true);
	green.animation.addByPrefix('carry', 'pulling instance 1', 24, true);
	green.animation.play('walk');
	green.scale.set(0.8, 0.8);
	green.alpha = 0;
	stage.layers[0].add(green);

    stage.props.set('bfStar', bfStar);
    stage.props.set('redStar', redStar);
    stage.props.set('orange', orange);
    stage.props.set('green', green);

    // force this shit into vram Now so lag spikes don't happen Later
    bfStar.drawComplex(game.camGame);
    redStar.drawComplex(game.camGame);
    game.graphicCache.cache(Paths.image('gameplay/stages/polus/images/orange'));
}

function onOpponentHit(e) {
    if(redStar.alpha != 0)
        e.characters.push(redStar);
}

function onPlayerHit(e) {
    if(bfStar.alpha != 0)
        e.characters.push(bfStar);
}