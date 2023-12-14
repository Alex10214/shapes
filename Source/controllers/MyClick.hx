package controllers;

import openfl.events.MouseEvent;
import openfl.display.Shape;
import controllers.Generator;

class MyClick {
    public static var mainInstance:Main;

    public static function onClickStage(event:MouseEvent):Void {

        var clickX:Float = event.stageX;
        var clickY:Float = event.stageY;


        if (clickX >= Config.centerX && clickX <= Config.centerX + Config.canvasWidth &&
            clickY >= Config.centerY && clickY <= Config.centerY + Config.canvasHeight) {
                
            if (mainInstance != null && mainInstance.shapes.length > 0) {
                var triangleFound:Bool = false;
                for (shape in mainInstance.shapes) {
                    if (shape.hitTestPoint(event.stageX, event.stageY, true)) {
                    
                        mainInstance.removeChild(shape);

                        mainInstance.shapes.remove(shape);
                        triangleFound = true;
                        break;
                    }
                }

                if (!triangleFound) {
                    var newTriangle:Shape = Generator.createRandomShape(clickX, clickY, true);
                    mainInstance.shapes.push(newTriangle);
                    mainInstance.addChild(newTriangle);
                }
            }

        }
        
    }
}
