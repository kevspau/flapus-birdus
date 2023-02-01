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
        tailLength += 5; //increase by 5 so that the pipe size is always at least 5
        log.debug(tailLength);

        head = new Quad();
        head.texture = headtex;
        head.size(headtex.width, headtex.height);
        head.scale(1.5);
        head.anchor(0.5, 1);

        tail = new Quad();
        tail.texture = tailtex;
        tail.size(tailtex.width, tailtex.height);
        tail.scale(1.5, tailLength); //makes it the random height
        tail.anchor(0.5, 1);

        var tailHeight = tail.height * tailLength; //makes it easier to read

        anchor(0.5, 1);
        size(head.width, tailHeight + head.height);

        head.pos(width/2, height - tailHeight);
        tail.pos(width/2, height);

        add(head);
        add(tail);
        //body.updateSize(width, height);

        log.debug('width: $width, height: $height');
        log.debug('head.width: ${head.width}, head.height: ${head.height}\ntail.width: ${tail.width}, tail.height: ${tail.height}');
        log.debug('tailtex w & h: ${tailtex.width}, ${tailtex.height}\nheadtex w & h: ${headtex.width}, ${headtex.height}\n\n\n');
        log.debug('collision body x & y: ${body.x}, ${body.y}\ncollision body width & height: ${body.width}, ${body.height}');

        /*var q = new Quad(); //pipe hitbox visual
        q.color = ceramic.Color.LIME;
        q.size(width, height);
        q.anchor(0.5, 1);
        q.pos(width/2, height);
        q.depth = 100;
        add(q);*/

        if (p == UP) {
            rotation = 180;
        }
    }
}
//(DONE)TODO1 get size of scene, make random pipe height that leaves room for birdus + another pipe (start with only one)