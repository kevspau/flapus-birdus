import ceramic.Scene;
import ceramic.Text;
import ceramic.Quad;
import ceramic.Color;
import ceramic.ScanCode;

class StartScreen extends Scene {
    override function preload() {
        assets.add(Fonts.KA_1);
        assets.add(Images.BACKGROUND_COLOR_FOREST);
        assets.add(Images.CURSOR);
    }
    override function create() {
        var bg = new Quad();
        bg.texture = assets.texture(Images.BACKGROUND_COLOR_FOREST);
        bg.width = width;
        bg.height = height;
        bg.depth = -100;
        add(bg);

        var title = new Text();
        title.font = assets.font(Fonts.KA_1);
        title.content = "Flapus-Birdus";
        title.anchor(0, 0.5);
        title.pos(30, height * 0.3);
        title.pointSize = 35;
        title.color = Color.BLACK;
        add(title);

        var cursor = new Quad();
        cursor.texture = assets.texture(Images.CURSOR);
        cursor.anchor(0, 0.5);
        cursor.pos(30, height * 0.5);
        cursor.scale(0.5);
        add(cursor);

        var start = new Text();
        start.font = assets.font(Fonts.KA_1);
        start.content = "Start!";
        start.anchor(0, 0.5);
        start.pos(30 + cursor.texture.width * 0.6, height * 0.5);
        start.pointSize = 20;
        start.color = Color.BLACK;
        add(start);

        input.onKeyDown(this, (key) -> {
            if (key.scanCode == ScanCode.ENTER) {
                app.scenes.main = new MainScene();
            }
        });
    }
}