'' examples/manual/gfx/rgb.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'RGB'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgRgb
'' --------

ScreenRes 640,480,32  '32 bit color
Line(0,0)-(319,479), RGB(255,0,0) 'draws a bright red box on the left side of the window
Line(639,0)-(320,479), RGB(0,0,255) 'draws a bright blue box on the right side of the window

Sleep 'wait before exiting
	
