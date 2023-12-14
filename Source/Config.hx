class Config {
    public static var canvasWidth:Float = 800;
    public static var canvasHeight:Float = 600;
    public static var shapeSpeed:Float = 50;
    public static var centerX:Float;
    public static var centerY:Float;

    public static function updateCenterCoordinates(stage:openfl.display.Stage):Void {
        Config.centerX = (stage.stageWidth - Config.canvasWidth) / 2;
        Config.centerY = (stage.stageHeight - Config.canvasHeight) / 2;
    }

    public static function init(stage:openfl.display.Stage):Void {
        updateCenterCoordinates(stage);
    }
}
