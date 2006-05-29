''
''	Test app for console mode
''
''	Draws the first 127 ascii characters on the screen

option explicit

#include once "common.bi"


'':::::
	dim as integer w, h, x, y, c

	w = loword(width())
	h = hiword(width())

	cls
	locate ,,0
	
	draw_rect 1, 1, w, h
	
	for y = 0 to 7
		for x = 0 to 15
			locate ((h - 16) / 2) + y + 1, ((w - 16) / 2) + x + 1
			print chr((x * 16) + y);
		next x
	next y
	
	sleep 1000
	

