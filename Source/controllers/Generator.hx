package controllers;
import models.Triangle;
import models.Circle;
import models.Polygon;
import models.Square;
import models.Star;
import openfl.display.Shape;

class Generator {

    public static function createRandomShape(centerX:Float, centerY:Float, ?onClick:Bool):Shape {

        var randomShape:Shape = null;
    
        var randomNum:Int = Std.random(6);

        var randomValue: Float;
        if (!onClick) {
            centerX = Math.floor(Math.random() * (2070 - 1350) + 1350);
            centerY = Math.floor(Math.random() * (952 - 352) + 352);
            centerY = 352 - 100;
        }
        
        switch (randomNum) {
            
            case 0: randomShape = new Triangle(centerX, centerY, randomColor());
            case 1: randomShape = new Circle(centerX, centerY, randomColor());
            case 2: randomShape = new Square(centerX, centerY, 50, randomColor());
            case 3: randomShape = new Star(centerX, centerY, 50, randomColor());
            case 4: randomShape = new Polygon(centerX, centerY, 50, 5, randomColor());
            case 5: randomShape = new Polygon(centerX, centerY, 50, 6, randomColor());
           
        }
    
        return randomShape;
    }

    private static function randomColor():Int {
        return Std.random(0xFFFFFF);
    }
}