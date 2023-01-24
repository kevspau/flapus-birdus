import ceramic.Visual;
import ceramic.Quad;

enum Pos {
    UP;
    DOWN;
}
class Pipe extends Visual {
    var head: Quad;
    var tail: Array<Quad>;
    var scene = app.scenes.main;
    public function new(headtex, tailtex: ceramic.Texture, p: Pos) {
        super();
        head = new Quad();
        head.texture = headtex;
        anchor(0.5, 0.5);
        head.anchor(0.5, 1);
        head.pos(width/2, height - tail[tail.length-1].height);

        tail.push(new Quad());
        tail.texture = tailtex;
        tail.anchor(0.5, 1); //TODO2 set texture of each tail part, set anchor, and set pos to increase height each time
        tail.pos(width/2, height);

        if (p == UP) {
            rotation = 180;
        }

        for (v in tail) {
            add(v);
        }
        add(head);
    }
}
//TODO1 get size of scene, make random pipe height that leaves room for birdus + another pipe (start with only one)