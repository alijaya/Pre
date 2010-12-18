Pre
===

Pre is a preloader library that will make preloader in a swf application easily.

Workflow
========

We have a swf application name it `TestMain.swf`
We want to add preloader in the begining of the main application running.

And we create another swf that handle the preloading logic, it handle how the representation of percent bytes loaded.
It is simply subclass the "Pre" class, and override the progress function and complete function.
And we compile it to for example `Preloader.swf`

And the main part of this library is the `tools/Pre.n` file, it will combine the preloader part with main part.
It will warp all the TestMain.swf file to a binary (so, all the assets and code into a binary) and embed it on second frame.
It creates symbol class and class stub for it.
Make the header of the result swf match with TestMain.swf (include width, height, fps, and version).
And the output is a swf with preloader :D

Benefit
=======

Okay... first we don't have to recompile our main application... or say if we don't have the source code, but we have a swf, and we want to add preloader to it.

And then... reusable preloader, so the preloader is reuseable and no need to recompile the preloader, so we can share the preloader (the swf file) on internet and we can reuse again.

It's simple ;).

Example
=======

So we can use the sample folder for example...

First check on `sample/Main.hx`, as you see the code does like this:

1. make a Loader instance
2. get tronImage data from resource and load it
3. scale the image (because the image too big :p)
4. add it to the stage

And check `sample/compile.hxml`, it compiles the `sample/Main.hx` to `sample/TestSwf.swf`, with 640 width and 480 height, and add the image resource.

So we get the `sample/TestSwf.swf` file, you can check it to see if it is works or not.

And we make preloader part, check `sample/Preloader.hx`, it extends pre.SimplePre class.
pre.SimplePre class is a simple preloader that extends pre.Pre, to make advanced preloader, extends pre.Pre instead :D.
And in the constructor, it calls super with argument `TestSwf`, the `TestSwf` refers to the our main swf name.

And just compile it with compilePreloader.hxml to get `Preloader.swf`, no magic is in here... so no explanation :p.

You can check the `Preloader.swf`, because there is no class `TestSwf` / failing to search class named `TestSwf`, it's start simulating the preloader, the loaded time plus by a hundred every enter frame.

So... the last... we combine them, open your terminal, and write like this
cd path/to/Pre/sample

    neko ../tools/Pre.n Preloader.swf TestSwf.swf

And you will get `TestSwf(Preloader).swf`, try it, you will see no progress if you open it on desktop, try to upload it somewhere and see if it works.


To check it how it works, you can see it [here](http://spamtheweb.com/ul/s18112010115_Pre.html)

