package pre;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.display.BlendMode;
import flash.display.Sprite;
import flash.geom.ColorTransform;
import flash.events.MouseEvent;

import flash.Lib;

class SimplePre extends Pre
{
	var bar : Sprite;
	var playText : TextField;
	var text : TextField;
	var color : Int;
	
	public function new(mainClass:String, ?color:Int=0xFF0000)
	{
		super(mainClass);
		this.color = color;

		var h = Lib.current.stage.stageHeight;

		bar = new Sprite();
		bar.graphics.beginFill(color);
		bar.graphics.drawRect(0, 0, 1, 1);
		bar.height = 20;
		bar.width = 0;
		bar.y = h - 20;
		
		text = new TextField();
		text.textColor = 0x000000;
		text.text = "0 / 0 (0%)";
		text.autoSize = TextFieldAutoSize.LEFT;
		text.selectable = false;
		text.y = h - 0.5*text.height - 10;

		sprite.addChild(bar);
		sprite.addChild(text);
	}

	override function progress(loaded:Int, total:Int)
	{
		var w = Lib.current.stage.stageWidth;
		var h = Lib.current.stage.stageHeight;
		var g = sprite.graphics;
		
		bar.width = w*loaded/total;

		text.text = loaded + " / " + total + " (" + Std.int(loaded/total*100) + "%)";
	}

	override function complete()
	{
		var w = Lib.current.stage.stageWidth;
		var h = Lib.current.stage.stageHeight;

		text.text = text.text + " (Click Here To Play)";

		var b = bar;
		var s = this;
		bar.addEventListener(MouseEvent.ROLL_OVER, function(e)
		{
			var ct = b.transform.colorTransform;
			ct.redOffset = 128;
			ct.greenOffset = 128;
			ct.blueOffset = 128;
			b.transform.colorTransform = ct;
		});

		bar.addEventListener(MouseEvent.ROLL_OUT, function(e)
		{
			var ct = b.transform.colorTransform;
			ct.redOffset = 0;
			ct.greenOffset = 0;
			ct.blueOffset = 0;
			b.transform.colorTransform = ct;
		});

		bar.addEventListener(MouseEvent.MOUSE_DOWN, function(e)
		{
			var ct = b.transform.colorTransform;
			ct.redOffset = -128;
			ct.greenOffset = -128;
			ct.blueOffset = -128;
			b.transform.colorTransform = ct;
		});

		bar.addEventListener(MouseEvent.CLICK, function(e)
		{
			s.change();
		});
	}
}
