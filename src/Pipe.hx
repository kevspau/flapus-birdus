import ceramic.Visual;
import ceramic.Quad;

enum Pos {
    UP;
    DOWN;
}
class Pipe extends Visual {
    public var head: Quad;
    public var tail: Quad;
    var scene = app.scenes.main;
    public function new(headtex, tailtex: ceramic.Texture, p: Pos) {
        super();

        initArcadePhysics();
        immovable = true;
        allowGravity = false;

        var tailLength = Std.random(cast scene.height / tailtex.height - 10);
        size(headtex.width, tailtex.height * (tailLength + 5) + headtex.height);

        var q = new Quad();
        q.color = ceramic.Color.RED;
        q.size(arcade.body.width, arcade.body.height);
        q.pos(arcade.body.x, arcade.body.y);
        q.depth = 100;
        add(q);
        
        tail = new Quad();
        tail.anchor(0.5, 1);
        tail.pos(width/2, height);
        tail.scaleY = tailLength + 5;
        tail.texture = tailtex;
        add(tail);

        head = new Quad();
        head.anchor(0.5, 1);
        head.pos(width/2, height - tailtex.height * (tailLength + 5));
        head.texture = headtex;
        add(head);
        
        anchor(0.5, 1);
        /*head.anchor(0.5, 1);
        tail.anchor(0.5, 1);

        tail.scaleY = tailLength + 5; //+ 5 keeps the minimum length at 5 in case tailLength = 0
        tail.x = width/2;
        head.pos(width/2, height - tailtex.height * (tailLength + 5)); //puts it at the end of the tail

        
        add(head);
        add(tail);*/

        //log.debug(tailLength);

        if (p == UP) {
            rotation = 180;
        }
    }
}
//(DONE)TODO1 get size of scene, make random pipe height that leaves room for birdus + another pipe (start with only one)