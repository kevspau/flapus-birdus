import ceramic.ScanCode;
import ceramic.Scene;
import ceramic.Key;
import ceramic.Text;
import ceramic.Quad;
import Player;

class MainScene extends Scene {
    var plr: Player;
    override function preload() {
        assets.add(Images.PLAYERSHEET);
        assets.add(Images.FLAPUS_BACKGROUND);
    }
    override function create() {
        var bg = new Quad();
        bg.texture = assets.texture(Images.FLAPUS_BACKGROUND);
        bg.width = width;
        bg.height = height;
        add(bg);

        plr = new Player();
        plr.pos(width/4, height/2);
        add(plr);

        input.onKeyDown(this, onDown);
        input.onKeyUp(this, onUp);
    }
    override function update(d: Float) {
        //if flapus goes out of bounds, pauses all motion and shows score
        if (plr.y <= 0 || plr.y >= height) {
            app.arcade.world.isPaused = true;
            app.scenes.main = new DeathScreen(this);
        }
        //rotates bird based on state
        if (plr.smach.state == FLYING && plr.rotation > -20) {
            plr.rotation -= 50 * d;
        } else if (plr.smach.state == FALLING && plr.rotation < 20) {
            plr.rotation += 50 * d;
        }
    }
    function onDown(key:Key) {
        //if space is pressed then flapus starts going up
        if (key.scanCode == ScanCode.SPACE) {
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