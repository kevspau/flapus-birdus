import ceramic.Scene;
import ceramic.Text;
import ceramic.Color;
import ceramic.Quad;

class DeathScreen extends Scene {
    var score: Int;

    override public function preload() {
        assets.add(Images.BACKGROUND_COLOR_FOREST);
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
        go.content = "Game Over";
        go.anchor(0.5, 0.5);
        go.pointSize = 80;
        go.pos(width/2, height/2);
        go.color = Color.BLACK;
        add(go);

        var score = new Text();
        score.content = "Score: " + MainScene.score;
        score.anchor(0.5 , 0.5);
        score.pointSize = 40;
        score.pos(width/2, height*0.7);
        score.color = Color.BLACK;
        add(score);
    }
}