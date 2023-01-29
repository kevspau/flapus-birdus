import ceramic.StateMachine;
import ceramic.Sprite;
import ceramic.SpriteSheet;


enum abstract State(Int) {
    var FALLING;
    var FLYING;
}
class Player extends Sprite {
    var scene = app.scenes.main;
    @component public var smach = new StateMachine<State>();
    public function new() {
        super();
        initArcadePhysics();
        sheet = new SpriteSheet();
        sheet.texture = scene.assets.texture(Images.PLAYERSHEET);
        sheet.grid(64, 64);
        sheet.addGridAnimation("falling", [0], 0);
        sheet.addGridAnimation("flying", [1], 0);
        quad.anchor(1, 0.5);
        animation = "falling";
        smach.state = FALLING;
    }
}