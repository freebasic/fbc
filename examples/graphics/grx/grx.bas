''
'' simple rgb test using the GRX 2D graphics library (DOS, Windows and Linux)
''

#include once "grx/grx20.bi"
#include once "grx/grxkeys.bi"

'GrSetMode(GR_width_height_color_graphics, 320, 240, 16)
GrSetMode(GR_width_height_graphics, 320, 240)

dim as integer x = GrSizeX()
dim as integer y = GrSizeY()
dim as integer ww = (x-10)\32
dim as integer wh = (y-10)\8

GrSetRGBcolorMode()
for i as integer = 0 to 7
	for j as integer = 0 to 31
		GrFilledBox(5+j*ww, 5+i*wh, 5+j*ww+ww-1, 5+i*wh+wh-1, i*32+j)
	next
next

GrKeyRead()

GrSetMode(GR_default_text)
