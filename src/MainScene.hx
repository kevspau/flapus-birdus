import ceramic.ScanCode;
import ceramic.Scene;
import ceramic.Key;
import ceramic.Text;
import ceramic.Quad;

class MainScene extends Scene {
    var plr: Player;
    var pipes: Array<Pipe>;
    var interval = 3.0;
    var pipePos: Pipe.Pos = DOWN;
    var pipeSpeed = 80;
    var pipeWaitSpawn = 3.0;
    var isDead = false;
    static public var score = 0;
    override function preload() {
        assets.add(Images.PLAYERSHEET);
        assets.add(Images.BACKGROUND_COLOR_FOREST);
        assets.add(Images.PIPE_HEAD);
        assets.add(Images.PIPE_TAIL);
    }
    override function create() {
        var bg = new Quad();
        bg.texture = assets.texture(Images.BACKGROUND_COLOR_FOREST);
        bg.width = width;
        bg.height = height;
        bg.depth = -100;
        add(bg);

        pipes = new Array<Pipe>();

        plr = new Player();
        plr.pos(width/4, height/2);
        add(plr);
        
        /*var p = new Pipe(assets.texture(Images.PIPE_HEAD), assets.texture(Images.PIPE_TAIL), pipePos);
        p.pos(width/4, height);
        add(p);
        pipes.push(p);*/
        
        input.onKeyDown(this, onDown);
        input.onKeyUp(this, onUp);

        app.arcade.onUpdate(this, (d: Float) -> {
            for (v in pipes) {
                app.arcade.world.collide(plr, v, (b1, b2) -> {
                    isDead = true;
                    trace("yo");
                }); //DONE TODO1 finish pipe collisions
            }
        });
    }
    override function update(d: Float) {
        if (isDead) {
            app.arcade.world.isPaused = true;
            app.scenes.main = new DeathScreen(score);
        }
        //if flapus goes out of bounds, pauses all motion and shows score
        if (plr.y <= 0 || plr.y >= height) {
            isDead = true; //?maybe add scene transition
        }
        //rotates bird based on state
        if (plr.smach.state == FLYING && plr.rotation > -30) {
            plr.rotation -= 50 * d;
        } else if (plr.smach.state == FALLING && plr.rotation < 30) {
            plr.rotation += 60 * d;
        }
        
        //moves the pipes, destroys them if theyre at the edge of the screen
        for (v in pipes) {
            if (v.x - v.width/2 <= 0) { //needs a bit more logic
                pipes.remove(v);
                v.destroy();
                score += 1;
            } else {
                v.x -= pipeSpeed * d; //how fast the pipes move
            }
        }

        //adds new pipes
        interval += d;
        if (interval >= pipeWaitSpawn) { //increase number to make space between pipes larger
            interval -= pipeWaitSpawn;
            
            var p = new Pipe(assets.texture(Images.PIPE_HEAD), assets.texture(Images.PIPE_TAIL), pipePos);
            p.pos(width + p.width/2, (pipePos == UP ? 0 : height));
            add(p);

            pipes.push(p);

            pipePos = (pipePos == DOWN ? UP : DOWN);
            pipeSpeed += 3;
            if (pipeWaitSpawn > 1.3) { //min wait time is 1.3 seconds
                pipeWaitSpawn -= 0.1;
            }
        }
    }
    function onDown(key:Key) {
        //if space is pressed then flapus starts going up
        if (key.scanCode == ScanCode.SPACE) { //TODO2 add low pitched beep when space pressed and high pitched beep when space released
            if (plr.smach.state == FALLING) {
                plr.animation = "flying";
                plr.gravityY = 0;
                plr.accelerationY = -500;
                plr.smach.state = FLYING;
            }
        }
    }
    function onUp(key:Key) {
        //once space is released then gravity is reset for flapus
        if (key.scanCode == ScanCode.SPACE) {
            if (plr.smach.state == FLYING) {
                plr.animation = "falling";
                plr.gravityY = 600;
                plr.accelerationY = 0;
                plr.smach.state = FALLING;
            }
        }
    }
}