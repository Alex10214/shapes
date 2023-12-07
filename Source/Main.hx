import openfl.display.Sprite;
import openfl.display.Shape;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFieldAutoSize;
import figures.TriangleGenerator;
import haxe.Timer;
import openfl.display.SimpleButton;

class Main extends Sprite {

    var canvas:Shape;
    public var shapes:Array<Shape>;
    var timer:Timer;
    var numShapesTextField:TextField;
    var areaTextField:TextField;

    var increaseButton:SimpleButton;
    var decreaseButton:SimpleButton;

    public function new() {
        super();

        Config.init(stage);

        // функцию создания канваса
        createCanvas();

        // массив хранения форм
        shapes = new Array<Shape>();

        // обработчик события ENTER_FRAME
        addEventListener(Event.ENTER_FRAME, update);

        // таймер для генерации треугольников каждую секунду
        timer = new Timer(1000);
        timer.run = createTriangle;
        OnClick.mainInstance = this;
       // обработчик события CLICK для создания фигуры при клике
        stage.addEventListener(MouseEvent.CLICK, function(event:MouseEvent):Void {
            OnClick.onClickStage(event, shapes, updateTextFields);
        });

        // текстовые поля
        numShapesTextField = createTextField("Количество фигур: 0", Config.centerX, Config.centerY - 20);
        areaTextField = createTextField("Площадь поверхности: 0 px^2", Config.centerX + 125, Config.centerY - 20);
    }

    function createCanvas():Void {
        canvas = new Shape();

        canvas.graphics.beginFill(0x813232);
        canvas.graphics.drawRect(Config.centerX, Config.centerY, Config.canvasWidth, Config.canvasHeight);
        canvas.graphics.endFill();

        // Добавляю канвас
        addChild(canvas);
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
        // обновляю поля
        numShapesTextField.text = "Количество фигур: " + shapes.length;
        areaTextField.text = "Площадь поверхности: " + calculateSurfaceArea() + " px^2";
    }

    function calculateSurfaceArea():Float {
        // рассчитываю площадь поверхности (не факт что точно)
        var totalArea:Float = 0;
        for (shape in shapes) {
            totalArea += shape.width * shape.height;
        }
        return totalArea;
    }

    function createTriangle():Void {
        var triangle:Shape = TriangleGenerator.createTriangle(Config.centerX, Config.centerY, Config.canvasWidth);
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
            // обновляю позицию на каждом кадре
            shape.y += Config.shapeSpeed * elapsedTime;
        }
    }

    function removeOutOfRangeShapes():Void {
        var shapesToRemove:Array<Shape> = [];

        for (shape in shapes) {
            // проверяю, находится ли треугольник за пределами области канваса
            if (shape.y > Config.centerY + Config.canvasHeight) {
                shapesToRemove.push(shape);
                removeChild(shape);
            }
        }

        // удаляю треугольник из массива
        for (shape in shapesToRemove) {
            shapes.remove(shape);
        }

        updateTextFields();
    }
}





