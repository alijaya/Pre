package ;

import flash.display.Loader;
import flash.events.Event;

import haxe.Resource;

import flash.Lib;


class Main 
{
	var loader : Loader;
	
	public function new() : Void
	{
		loader = new Loader();
		loader.loadBytes(Resource.getBytes("tronImage").getData());
		loader.scaleX = 0.5;
		loader.scaleY = 0.5;
		Lib.current.addChild(loader);
	}
	
	
	static function main()
	{
		new Main();
	}
}
