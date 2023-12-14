package models;

import openfl.display.Shape;

class Square extends Shape {

    public function new(centerX:Float, centerY:Float, size:Float, color:Int) {
        super();

        this.graphics.beginFill(color);

        this.graphics.drawRect(0, 0, size, size);

        this.graphics.endFill();

        this.x = centerX;
        this.y = centerY;
    }
}
