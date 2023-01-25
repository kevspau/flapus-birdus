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
        tail = new Array<Quad>();
        head.texture = headtex;
        anchor(0.5, 0.5);
        head.anchor(0.5, 1);

        var tailLength = Std.random(cast scene.height / tailtex.height - 3);
        log.debug(scene.height / tailtex.height);
        log.debug(tailLength);

        for (i in 0...tailLength) {
            var q = new Quad();
            q.texture = tailtex;
            q.pos(width/2, height/2 - i * tailtex.height); //TODO1 remove spaces between pipe tails
            q.anchor(0.5, 1);
            tail.push(q);
        }
        /*tail.texture = tailtex;
        tail.anchor(0.5, 1); //(DONE)TODO2 set texture of each tail part, set anchor, and set pos to increase height each time
        tail.pos(width/2, height);*/

        if (p == UP) {
            rotation = 180;
        }

        for (v in tail) {
            add(v);
        }

        head.pos(width/2, tail[tail.length-1].y - tail[tail.length-1].height);
        add(head);
    }
}
//(DONE)TODO1 get size of scene, make random pipe height that leaves room for birdus + another pipe (start with only one)