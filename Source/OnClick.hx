import openfl.events.MouseEvent;
import openfl.display.Shape;
import figures.TriangleGenerator;

class OnClick {
    public static var mainInstance:Main;
    
    public static function onClickStage(event:openfl.events.MouseEvent, shapes:Array<openfl.display.Shape>, updateTextFields:Void->Void):Void {
        // получаю координаты клика
        var clickX:Float = event.stageX;
        var clickY:Float = event.stageY;

        
        if (clickX >= Config.centerX && clickX <= Config.centerX + Config.canvasWidth &&
            clickY >= Config.centerY && clickY <= Config.centerY + Config.canvasHeight) {
            // переменная для отслеживания наличия треугольника
            var triangleFound:Bool = false;

            // проверяю, попали ли мы по треугольнику
            for (triangle in shapes) {
                if (isPointInTriangle(clickX, clickY, triangle)) {
                    // если попал по треугольнику, то удаляем его
                    shapes.remove(triangle);
                    triangle.parent.removeChild(triangle);
                    updateTextFields();
                    triangleFound = true;
                    break;
                }
            }

            // если треугольник не найден, то добавляю новый
            if (!triangleFound) {
                var newTriangle:Shape = TriangleGenerator.createTrianglefromCLick(clickX, clickY);
                shapes.push(newTriangle);
                mainInstance.addChild(newTriangle);
            }
        }

    }

    private static function isPointInTriangle(x:Float, y:Float, triangle:openfl.display.Shape):Bool {
        // получаю вершины треугольника (думаю можно сделать проще, но пока как есть)
        var p1:Array<Float> = [triangle.x, triangle.y];
        var p2:Array<Float> = [triangle.x + triangle.width, triangle.y];
        var p3:Array<Float> = [triangle.x, triangle.y + triangle.height];

        // проверяю, лежит ли точка (x, y) внутри треугольника
        var b1:Bool = sign(x, y, p1[0], p1[1], p2[0], p2[1]) < 0.0;
        var b2:Bool = sign(x, y, p2[0], p2[1], p3[0], p3[1]) < 0.0;
        var b3:Bool = sign(x, y, p3[0], p3[1], p1[0], p1[1]) < 0.0;

        //trace(((b1 == b2) && (b2 == b3)));

        return ((b1 == b2) && (b2 == b3));
    }

    private static function sign(px:Float, py:Float, qx:Float, qy:Float, rx:Float, ry:Float):Float {
        return (px - rx) * (qy - ry) - (qx - rx) * (py - ry);
    }
}
