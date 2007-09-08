''
'' anti-aliased line example
''
'' to compile, build fbgl.bas first (fbc fbgl.bas -lib)
''

#include once "fbgl.bi" 

const XRES = 320
const YRES = 240

	var win = fbgl( XRES, YRES )
	
	'' change to anti-aliased mode
	win.blendMode = fbgl.ANTIALISED
	win.lineSmooth = TRUE
	
	do 
		'' clear the working page
		win.cls
		
		'' draw the contents
		for i as integer = 1 to 1000
			'' use 255 (100%) for alpha 
			win.color = rgba(rnd * 255, rnd * 255, rnd * 255, 255) 
	   		
	   		'' line x1, y2, x2, y2
	   		win.line rnd * XRES, rnd * YRES, rnd * XRES, rnd * YRES
		next
	   	
	   '' copy the working page to the visible one
	   win.flip
	   
	loop while len( inkey ) = 0