//
//  Pre.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 6/11/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package pre;
import flash.Lib;
import flash.events.Event;
import flash.display.Sprite;
import flash.display.MovieClip;
import flash.display.Loader;

class Pre 
{
	var mainClass:String;
	
	var loader:Loader;
	
	var sprite:Sprite;
	
	var current:MovieClip;

	var simulation:Bool;
	var simulationLoaded:Int;
	
	public function new(mainClass:String)
	{
		this.mainClass = mainClass;

		simulation = false;
		simulationLoaded = 0;
		
		current = Lib.current;
		
		sprite = new Sprite();

		loader = new Loader();
		
		current.addChild(sprite);
		
		current.addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}
	
	function onEnterFrame(e:Event)
	{
		if(!simulation)
		{
			var total = current.root.loaderInfo.bytesTotal;
			var loaded = current.root.loaderInfo.bytesLoaded;
			
			progress(loaded, total);
			
			if(loaded == total)
			{
				var c = Type.resolveClass(mainClass);
				if(c != null)
				{
					current.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
					loader.loadBytes(Type.createInstance(c,[]), new flash.system.LoaderContext(new flash.system.ApplicationDomain()));
					loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
				} else
				{
					simulation = true;
					simulationLoaded = 0;
					trace("Simulation Begin");
				}
			}
		} else
		{
			var total = current.root.loaderInfo.bytesTotal;
			var loaded = simulationLoaded;

			progress(loaded, total);

			if(loaded == total)
			{
				current.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				complete();
				trace("Simulation Complete");
			}
			
			simulationLoaded += 100;
			if(simulationLoaded > total) simulationLoaded = total;
		}
	}
	
	function onComplete(e:Event)
	{
		loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onComplete);
		
		complete();
	}

	function progress(loaded:Int, total:Int) // progressing here
	{
		
	}
	
	function complete()
	{
		change();
	}

	function change()
	{
		current.removeChild(sprite);
		
		current.addChild(loader);
	}
}
