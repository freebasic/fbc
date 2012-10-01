'' examples/manual/gfx/get.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgGetgraphics
'' --------

#include once "fbgfx.bi"

'' Setup a 400x300 32bit screen
ScreenRes 400, 300, 32

'' First draw funny stuff...
Line (10,10)-(140,30), RGB(255,255,0), bf
Draw String (20, 20), "Hello there!", RGB(255,0,0)

'' Now capture a 150x50 block from the top-left of the screen into an image
'' buffer with GET...
Dim As fb.Image Ptr image = ImageCreate(150, 50)
Get (1,1)-(150,50), image

'' And duplicate it all over the place!
Put (1,50), image
Put (1,100), image
Put (1,150), image
Put (1,200), image
Put (1,250), image
Put (150,1), image
Put (150,50), image
Put (150,100), image
Put (150,150), image
Put (150,200), image
Put (150,250), image

'' And a frame around a whole screen..
Line (1,1)-(400-1,300-1), RGB(255,255,0), b

'' Now get the whole screen...
Dim As fb.Image Ptr big = ImageCreate(400, 300)
Get (1,1)-(400-1,300-1), big

'' And display that "screenshot" as if it was scrolling by...
Dim As Integer x = -350
While ((Inkey() = "") And (x < 350))
	ScreenLock
		Cls
		Put (x,1), big
	ScreenUnlock

	Sleep 100, 1

	x += 10
Wend
