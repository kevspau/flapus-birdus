import ceramic.Sprite;
import ceramic.SpriteSheet;

class Player extends Sprite {
    var scene = app.scenes.main;
    public function new() {
        super();
        initArcadePhysics();
        gravityY = 600;
        sheet = new SpriteSheet();
        sheet.texture = scene.assets.texture(Images.PLAYERSHEET);
        sheet.grid(64, 64);
        sheet.addGridAnimation("falling", [0], 0);
        sheet.addGridAnimation("flying", [1], 0);
        quad.anchor(1, 0.5);
        animation = "falling";

    }
}