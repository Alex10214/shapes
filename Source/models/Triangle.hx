package models;

import openfl.display.Shape;

class Triangle extends Shape {

    public function new(centerX:Float, centerY:Float, color:Int) {
        super();

        this.graphics.beginFill(color);

        // Создание треугольника
        this.graphics.moveTo(0, -50);
        this.graphics.lineTo(50, 50);
        this.graphics.lineTo(-50, 50);
        this.graphics.lineTo(0, -50);

        this.graphics.endFill();
        
        this.x = centerX;
        this.y = centerY;

    }
}






