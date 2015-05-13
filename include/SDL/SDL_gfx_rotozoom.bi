
''
''
'' SDL_rotozoom - rotozoomer
''
'' LGPL (c) A. Schiffler
''
''

#ifndef SDL_rotozoom_h
#define SDL_rotozoom_h

#inclib "SDL_gfx"

#include once "SDL.bi"

#define SMOOTHING_OFF		0
#define SMOOTHING_ON		1

type tColorRGBA
	r as Uint8 
	g as Uint8 
	b as Uint8 
	a as Uint8 
end type

type tColorY
	y as Uint8 
end type


'' 
''  
''  rotozoomSurface()
'' 
''  Rotates and zoomes a 32bit or 8bit 'src' surface to newly created 'dst' surface.
''  'angle' is the rotation in degrees. 'zoom' a scaling factor. If 'smooth' is 1
''  then the destination 32bit surface is anti aliased. If the surface is not 8bit
''  or 32bit RGBA/ABGR it will be converted into a 32bit RGBA format on the fly.
'' 
'' 

    declare function rotozoomSurface cdecl alias "rotozoomSurface" (byval src as SDL_Surface ptr, byval angle as double, byval zoom as double, byval smooth as integer) as SDL_Surface ptr

    declare function rotozoomSurfaceXY cdecl alias "rotozoomSurfaceXY"  (byval src as SDL_Surface ptr, byval angle as double, byval zoomx as double, byval zoomy as double, byval smooth as integer) as SDL_Surface ptr

''  Returns the size of the target surface for a rotozoomSurface() call

    declare sub rotozoomSurfaceSize cdecl alias "rotozoomSurfaceSize" (byval width as integer, byval height as integer, byval angle as double, byval zoom as double, byval dstwidth as integer ptr, byval dstheight as integer ptr)

    declare sub rotozoomSurfaceSizeXY cdecl alias "rotozoomSurfaceSizeXY" (byval width as integer, byval height as integer, byval angle as double, byval zoomx as double, byval zoomy as double, byval dstwidth as integer ptr, byval dstheight as integer ptr)

'' 
''  
''  zoomSurface()
'' 
''  Zoomes a 32bit or 8bit 'src' surface to newly created 'dst' surface.
''  'zoomx' and 'zoomy' are scaling factors for width and height. If 'smooth' is 1
''  then the destination 32bit surface is anti aliased. If the surface is not 8bit
''  or 32bit RGBA/ABGR it will be converted into a 32bit RGBA format on the fly.
'' 
'' 

    declare function zoomSurface cdecl alias "zoomSurface" (byval src as SDL_Surface ptr, byval zoomx as double, byval zoomy as double, byval smooth as integer) as SDL_Surface ptr

'' Returns the size of the target surface for a zoomSurface() call

    declare sub zoomSurfaceSize cdecl alias "zoomSurfaceSize" (byval width as integer, byval height as integer, byval zoomx as double, byval zoomy as double, byval dstwidth as integer ptr, byval dstheight as integer ptr)



#endif				'' _SDL_rotozoom_h
