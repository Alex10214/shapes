package models;

import openfl.display.Shape;

class Polygon extends Shape {

    public function new(centerX:Float, centerY:Float, size:Float, angles, color:Int) {
        super();

        this.graphics.beginFill(color);

        var angle:Float = -Math.PI / 2;

        for (i in 0...angles) {
            var x:Float = centerX + size * Math.cos(angle);
            var y:Float = centerY + size * Math.sin(angle);
            if (i == 0) {
                this.graphics.moveTo(x, y);
            } else {
                this.graphics.lineTo(x, y);
            }
            angle += (2 * Math.PI) / angles;
        }
        this.graphics.endFill();
    
        this.x = 0;
        this.y = 0;

    }
}
