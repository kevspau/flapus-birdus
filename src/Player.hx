import ceramic.Quad;
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

        size(34, 35);
        anchor(0.5, 0.5);

        quad.anchor(0.5, 0.5);
        quad.pos(width/2, height/2);

        animation = "falling";
        smach.state = FALLING;

        /*var hb = new Quad(); //player hitbox visual
        hb.color = ceramic.Color.LIME;
        hb.size(width, height);
        hb.anchor(0.5, 0.5);
        hb.pos(width/2, height/2);
        hb.depth = -5;
        add(hb);*/

        log.debug('width, height: $width, $height');
        log.debug('quad.width, quad.height: ${quad.width}, ${quad.height}');
    }
}