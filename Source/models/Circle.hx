package models;

import openfl.display.Shape;

class Circle extends Shape {

    public function new(centerX:Float, centerY:Float, color:Int) {
        super();

        this.graphics.beginFill(color);

        this.graphics.drawCircle(0, 0, 50);

        this.graphics.endFill();

        this.x = centerX;
        this.y = centerY;
    }
}
