package;


import openfl.display.Sprite;
import openfl.display.Shape;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFieldAutoSize;
import controllers.Generator;
import haxe.Timer;
import openfl.display.SimpleButton;

import controllers.MyClick;
import models.Triangle;

class Main extends Sprite {

    var canvas:Shape;
    var maskShape:Shape;
    public var shapes:Array<Shape>;
    var timer:Timer;
    var numShapesTextField:TextField;
    var areaTextField:TextField;

    var increaseButton:SimpleButton;
    var decreaseButton:SimpleButton;

    public function new() {
        super();

        Config.init(stage);

        createCanvas();

        shapes = new Array<Shape>();

        addEventListener(Event.ENTER_FRAME, update);

        timer = new Timer(1000);
        timer.run = createTriangle;
        MyClick.mainInstance = this;
        
        stage.addEventListener(MouseEvent.CLICK, function(event:MouseEvent):Void {
            MyClick.onClickStage(event);
        });

        // Been trying to figure out the mask, but can't figure out how it works in openFl. 
        // So the data output fields are there, but I couldn't get them up.
        numShapesTextField = createTextField("Number of figures: 0", Config.centerX, Config.centerY - 20);
        areaTextField = createTextField("Surface area: 0 px^2", Config.centerX + 125, Config.centerY - 20);

        createMask();
    }

    function createCanvas():Void {
        canvas = new Shape();

        canvas.graphics.beginFill(0x433281);
        canvas.graphics.drawRect(Config.centerX, Config.centerY, Config.canvasWidth, Config.canvasHeight);
        canvas.graphics.endFill();

        addChild(canvas);
    } 

    function createMask():Void {
        maskShape = new Shape();
        maskShape.graphics.beginFill(0xFFFFFF);
        maskShape.graphics.drawRect(Config.centerX, Config.centerY, Config.canvasWidth, Config.canvasHeight);
        maskShape.graphics.endFill();

        addChild(maskShape);

        addChild(numShapesTextField);
        addChild(areaTextField);

        stage.mask = maskShape;
    }

    function createTextField(text:String, x:Float, y:Float):TextField {
        var textField:TextField = new TextField();
        textField.selectable = false;
        textField.autoSize = TextFieldAutoSize.LEFT;
        textField.defaultTextFormat = new TextFormat("_sans", 12, 0x0C0101);
        textField.text = text;
        textField.x = x;
        textField.y = y;
        textField.border = true;
        textField.borderColor = 0x000000;

        addChild(textField);
        return textField;
    }

    public function updateTextFields():Void {
        numShapesTextField.text = "Number of figures: " + shapes.length;
        areaTextField.text = "Surface area: " + calculateSurfaceArea() + " px^2";
    }

    function calculateSurfaceArea():Float {
        var totalArea:Float = 0;
        for (shape in shapes) {
            totalArea += shape.width * shape.height;
        }
        return totalArea;
    }

    function createTriangle():Void {
        var triangle:Shape = Generator.createRandomShape(Config.centerX, Config.centerY);
        shapes.push(triangle);
        addChild(triangle);

        updateTextFields();
    }

    function update(event:Event):Void {
        updateShapes(1 / stage.frameRate);
        removeOutOfRangeShapes();
    }

    function updateShapes(elapsedTime:Float):Void {
        for (shape in shapes) {
            shape.y += Config.shapeSpeed * elapsedTime;
        }
    }

    function removeOutOfRangeShapes():Void {
        var shapesToRemove:Array<Shape> = [];

        for (shape in shapes) {
            if (shape.y > (Config.centerY + 100) + Config.canvasHeight) {
                shapesToRemove.push(shape);
                removeChild(shape);
            }
        }

        for (shape in shapesToRemove) {
            shapes.remove(shape);
        }

        updateTextFields();
    }
}



