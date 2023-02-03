import ceramic.Scene;
import ceramic.Text;
import ceramic.Color;
import ceramic.Quad;

class DeathScreen extends Scene {
    var score: Int;

    override public function preload() {
        assets.add(Images.BACKGROUND_COLOR_FOREST);
        assets.add(Fonts.KA_1);
    }
    public function new(s: Int) {
        super();
    }
    override public function create() {

        var bg = new Quad();
        bg.texture = assets.texture(Images.BACKGROUND_COLOR_FOREST);
        bg.width = width;
        bg.height = height;
        bg.depth = -100;
        add(bg);

        //width = app.settings.targetWidth;
        //height = app.settings.targetHeight;
        var go = new Text();
        go.font = assets.font(Fonts.KA_1);
        go.content = "Game Over";
        go.anchor(0.5, 0.5);
        go.pointSize = 50;
        go.pos(width/2, height/2);
        go.color = Color.BLACK;
        add(go);

        var score = new Text();
        score.font = assets.font(Fonts.KA_1);
        score.content = "Score: " + MainScene.score;
        score.anchor(0.5 , 0.5);
        score.pointSize = 30;
        score.pos(width/2, height*0.7);
        score.color = Color.BLACK;
        add(score);

        var h = new Text();
        h.font = assets.font(Fonts.KA_1);
        h.content = "Enter - Home\nSpace - Restart";
        h.anchor(0.5, 0.5);
        h.pos(width/2, height * 0.9);
        h.color = Color.BLACK;
        h.align = ceramic.TextAlign.CENTER;
        add(h);

        input.onceKeyDown(this, keyDown);
    }
    function keyDown(key: ceramic.Key) {
        if (key.scanCode == ceramic.ScanCode.ENTER) {
            //reset the score
            MainScene.score = 0;
            app.scenes.main = new StartScreen();
        } else if (key.scanCode == ceramic.ScanCode.SPACE) {
            MainScene.score = 0;
            app.scenes.main = new MainScene();
        } else {
            input.onceKeyDown(this, keyDown);
        }
    }
}