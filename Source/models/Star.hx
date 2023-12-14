package models;

import openfl.display.Shape;

class Star extends Shape {

    public function new(centerX:Float, centerY:Float, size:Float, color:Int) {
        super();

        this.graphics.beginFill(color);
    
        var angle:Float = -Math.PI / 2;

        for (i in 0...10) {
            var radius:Float = (i % 2 == 0) ? size * 0.5 : size;
            var x:Float = centerX + radius * Math.cos(angle);
            var y:Float = centerY + radius * Math.sin(angle);
            if (i == 0) {
                this.graphics.moveTo(x, y);
            } else {
                this.graphics.lineTo(x, y);
            }
            angle += (Math.PI) / 5;
        }

        this.graphics.endFill();

        this.x = 0;
        this.y = 0;
    }
}
