package figures;

import openfl.display.Shape;
import openfl.Vector;

class TriangleGenerator {

    public static function createTriangle(centerX:Float, centerY:Float, canvasWidth:Float):Shape {
        var triangle:Shape = new Shape();
        triangle.graphics.beginFill(randomColor());
        triangle.graphics.drawTriangles(new Vector<Float>([0, 0, 50, 100, 100, 0]));
        triangle.graphics.endFill();
        triangle.x = centerX + Math.random() * (canvasWidth -100); 
        triangle.y = centerY - 100;

        return triangle;
    }

    public static function createTrianglefromCLick(centerX:Float, centerY:Float):Shape {
        var triangle:Shape = new Shape();
        triangle.graphics.beginFill(randomColor());
        triangle.graphics.drawTriangles(new Vector<Float>([0, 0, 50, 100, 100, 0]));
        triangle.graphics.endFill();
        triangle.x = centerX;
        triangle.y = centerY;
    
        return triangle;
    }

    private static function randomColor():Int {
        return Std.random(0xFFFFFF);
    }
}