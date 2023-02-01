import ceramic.Scene;
import ceramic.Text;
import ceramic.Color;

class DeathScreen extends Scene {
    var score: Text;
    public function new(s: Int) {
        super();

        width = app.settings.targetWidth;
        height = app.settings.targetHeight;
        var go = new Text();
        go.content = "Game Over";
        go.anchor(0.5, 0.5);
        go.pointSize = 80;
        go.pos(width/2, height/2);
        go.color = Color.WHITE;
        add(go);

        score = new Text();
        score.content = "Score: " + s;
        score.anchor(0.5 , 0.5);
        score.pointSize = 40;
        score.pos(width/2, height*0.7);
        score.color = Color.WHITE;
        add(score);
    }
}