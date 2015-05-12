''
'' simple rgb test using the GRX 2D graphics library (DOS, Windows and Linux)
''



#include once "grx/grx20.bi"
#include once "grx/grxkeys.bi"

#define SCR_X 320
#define SCR_Y 240
#define SCR_C 16

sub rgbtest
	dim as integer x
	dim as integer y
	dim as integer ww
	dim as integer wh
	dim as integer ii,jj

	x = GrSizeX()
	y = GrSizeY()
	ww = (x-10)\32
	wh = (y-10)\8

	GrSetRGBcolorMode()
	for ii = 0 to 7
	    for jj = 0 to 31
			GrFilledBox(5+jj*ww, 5+ii*wh, 5+jj*ww+ww-1, 5+ii*wh+wh-1, ii*32+jj)
	    next
	next
	
	GrKeyRead()

end sub

'' main

	'GrSetMode(GR_width_height_color_graphics, SCR_X, SCR_Y, SCR_C)
	GrSetMode(GR_width_height_graphics, SCR_X, SCR_Y)
		
	rgbtest( )
	
	GrSetMode(GR_default_text)
