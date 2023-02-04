package;

import ceramic.Entity;
import ceramic.Color;
import ceramic.InitSettings;

class Project extends Entity {

    function new(settings:InitSettings) {

        super();

        settings.antialiasing = 0;
        settings.background = Color.BLACK;
        settings.targetWidth = 640; //640
        settings.targetHeight = 480; //480
        settings.scaling = FIT_RESIZE;
        settings.resizable = true;

        app.onceReady(this, ready);

    }

    function ready() {

        // Set MainScene as the current scene (see MainScene.hx)
        app.scenes.main = new StartScreen();

    }

}
