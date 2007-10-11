TinyPTC by Gaffer - A tiny framebuffer library for 64k intros


All executables have been compressed with UPX and built from test.c

When stripped down to bare minimum tinyptc adds roughly 0.5k to your executable,
as you add features by turning on defines in tinyptc the size gets larger.
Watch out for icons as they add a new section to your executable making your
compressed EXE a few kb larger.

The sample executables included here have been built to demonstrate features,
not size - you can cut the EXE size down lower by tweaking the options in
"tinyptc.h". Personally, unless you really need the space, you are better
off leaving most of the features on (except for icons, thats personal taste...)

You can choose between DirectDraw output and GDI output in this release, plus
a set of basic pixel format converters have been added 32->32/24/16/"15". I am
confident that TinyPTC should work correctly on just about any Win32 box now,
TinyPTc is now ready for use in productions - go for it!

Big thanks to zoon for the GDI support, excellent work dude - also, an excellent
idea from zoon was the addition of zoom control to the system menu, take a look
in the system menu, you can now zoom 1x1, 2x2, or 4x4. nice stuff.

Also, thanks to raster for adding support for VFW based on the GDI support,
on many systems VFW is faster than GDI.

And remember, look in tinyptc.h for a whole set of nifty defines you can play
around with - lots of cool stuff you can control in there.

By the way, I have developed this under Visual C++ 6.0 but it should work under
pretty much any win32 C complier with a little tweaking.

Please tell us if you port TinyPTC to another compiler, send us the code and we
can incorporate support for that compiler back into the main source.

TinyPTC has been tested under Windows 2000, NT4, 98 and 95. If you have any
problems with a specific platform let us know so we can fix it!

We are looking to port TinyPTC to other platforms such as Amiga, BeOS, MacOS.
Email us me you are interested in helping out with the ports.

Send all patches, feature requests and bug reports to ptc@gaffer.org


cheers dudes >B)


Links:

http://www.gaffer.org/tinyptc    -   tinyptc homepage

http://www.web-sites.co.uk/nasm/ -   install nasm to compile the mmx blitters

http://www.fmod.org	         -   minifmod for your sound needs

http://upx.tsx.org               -   UPX executable compressor utility
