import ceramic.ScanCode;
import ceramic.Scene;
import ceramic.Key;
import ceramic.Text;
import ceramic.Quad;

class MainScene extends Scene {
    var plr: Player;
    var pipes: Array<Pipe>;
    override function preload() {
        assets.add(Images.PLAYERSHEET);
        assets.add(Images.FLAPUS_BACKGROUND);
        assets.add(Images.PIPE_HEAD);
        assets.add(Images.PIPE_TAIL);
    }
    override function create() {
        var bg = new Quad();
        bg.texture = assets.texture(Images.FLAPUS_BACKGROUND);
        bg.width = width;
        bg.height = height;
        bg.depth = -100;
        add(bg);

        pipes = new Array<Pipe>();

        plr = new Player();
        plr.pos(width/4, height/2);
        add(plr);

        var pipe = new Pipe(assets.texture(Images.PIPE_HEAD), assets.texture(Images.PIPE_TAIL), UP);
        pipe.pos(width/2, 0);
        pipes.push(pipe);
        add(pipe);
        
        input.onKeyDown(this, onDown);
        input.onKeyUp(this, onUp);
    }
    override function update(d: Float) {
        //if flapus goes out of bounds, pauses all motion and shows score
        if (plr.y <= 0 || plr.y >= height) {
            app.arcade.world.isPaused = true;
            app.scenes.main = new DeathScreen(this); //?maybe add scene transition
        }
        //rotates bird based on state
        if (plr.smach.state == FLYING && plr.rotation > -30) {
            plr.rotation -= 50 * d;
        } else if (plr.smach.state == FALLING && plr.rotation < 30) {
            plr.rotation += 60 * d;
        }
        
        //moves the pipes, destroys them if theyre at the edge of the screen
        for (v in pipes) {
            if (v.x <= 0) { //needs a bit more logic
                pipes.remove(v);
                v.destroy();
            } else {
                v.x -= 50 * d;
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