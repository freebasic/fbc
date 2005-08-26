''
''
'' SDL_gfxPrimitives: graphics primitives for SDL
''
'' LGPL (c) A. Schiffler
'' 
''

#ifndef SDL_gfxPrimitives_h
#define SDL_gfxPrimitives_h

#inclib "SDL_gfx"

#include once "SDL/SDL.bi"

#define SDL_GFXPRIMITIVES_MAJOR	2
#define SDL_GFXPRIMITIVES_MINOR	0
#define SDL_GFXPRIMITIVES_MICRO	13

'' Note: all ___Color routines expect the color to be in format 0xRRGGBBAA

'' Pixel

    declare function pixelColor cdecl alias "pixelColor" (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval color as Uint32) as integer
    declare function pixelRGBA cdecl alias "pixelRGBA" (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer

'' Horizontal line

    declare function hlineColor cdecl alias "hlineColor" (byval dst as SDL_Surface ptr, byval x1 as Sint16, byval x2 as Sint16, byval y as Sint16, byval color as Uint32) as integer
    declare function hlineRGBA cdecl alias "hlineRGBA" (byval dst as SDL_Surface ptr, byval x1 as Sint16, byval x2 as Sint16, byval y as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer

'' Vertical line

    declare function vlineColor cdecl alias "vlineColor" (byval dst as SDL_Surface ptr, byval x as Sint16, byval y1 as Sint16, byval y2 as Sint16, byval color as Uint32) as integer
    declare function vlineRGBA cdecl alias "vlineRGBA" (byval dst as SDL_Surface ptr, byval x as Sint16, byval y1 as Sint16, byval y2 as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer

'' Rectangle

    declare function rectangleColor cdecl alias "rectangleColor" (byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval color as Uint32) as integer
    declare function rectangleRGBA cdecl alias "rectangleRGBA" (byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, _
	 byval x2 as Sint16, byval y2 as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer

'' Filled rectangle (Box)

    declare function boxColor cdecl alias "boxColor" (byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval color as Uint32) as integer
    declare function boxRGBA cdecl alias "boxRGBA" (byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, _
	 byval y2 as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer

'' Line

    declare function lineColor cdecl alias "lineColor" (byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval color as Uint32) as integer
    declare function lineRGBA cdecl alias "lineRGBA" (byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, _
	 byval x2 as Sint16, byval y2 as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer

'' AA Line
    declare function aalineColor cdecl alias "aalineColor" (byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval color as Uint32) as integer
    declare function aalineRGBA cdecl alias "aalineRGBA" (byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, _
	 byval x2 as Sint16, byval y2 as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer

'' Circle

    declare function circleColor cdecl alias "circleColor" (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval r as Sint16, byval color as Uint32) as integer
    declare function circleRGBA cdecl alias "circleRGBA" (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval rad as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer

'' AA Circle

    declare function aacircleColor cdecl alias "aacircleColor" (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval r as Sint16, byval color as Uint32) as integer
    declare function aacircleRGBA cdecl alias "aacircleRGBA" (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, _
	 byval rad as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer

'' Filled Circle

    declare function filledCircleColor cdecl alias "filledCircleColor" (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval r as Sint16, byval color as Uint32) as integer
    declare function filledCircleRGBA cdecl alias "filledCircleRGBA" (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, _
	 byval rad as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer

'' Ellipse

    declare function ellipseColor cdecl alias "ellipseColor" (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval rx as Sint16, byval ry as Sint16, byval color as Uint32) as integer
    declare function ellipseRGBA cdecl alias "ellipseRGBA" (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, _
	 byval rx as Sint16, byval ry as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer

'' AA Ellipse

    declare function aaellipseColor cdecl alias "aaellipseColor" (byval dst as SDL_Surface ptr, byval xc as Sint16, byval yc as Sint16, byval rx as Sint16, byval ry as Sint16, byval color as Uint32) as integer
    declare function aaellipseRGBA cdecl alias "aaellipseRGBA" (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, _
	 byval rx as Sint16, byval ry as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer

'' Filled Ellipse

    declare function filledEllipseColor cdecl alias "filledEllipseColor" (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval rx as Sint16, byval ry as Sint16, byval color as Uint32) as integer
    declare function filledEllipseRGBA cdecl alias "filledEllipseRGBA" (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, _
	 byval rx as Sint16, byval ry as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer

#define CLOCKWISE

'' Pie

    declare function pieColor cdecl alias "pieColor" (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval rad as Sint16, _
	 byval start as Sint16, byval end as Sint16, byval color as Uint32) as integer
    declare function pieRGBA cdecl alias "pieRGBA" (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval rad as Sint16, _
	 byval start as Sint16, byval end as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer

'' Filled Pie

    declare function filledPieColor cdecl alias "filledPieColor" (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval rad as Sint16, _
	 byval start as Sint16, byval end as Sint16, byval color as Uint32) as integer
    declare function filledPieRGBA cdecl alias "filledPieRGBA" (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval rad as Sint16, _
	 byval start as Sint16, byval end as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer

'' Trigon

    declare function trigonColor cdecl alias "trigonColor" (byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval x3 as Sint16, byval y3 as Sint16, byval color as Uint32) as integer
    declare function trigonRGBA cdecl alias "trigonRGBA" (byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval x3 as Sint16, byval y3 as Sint16, _
	 byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer

'' AA-Trigon

    declare function aatrigonColor cdecl alias "aatrigonColor" (byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval x3 as Sint16, byval y3 as Sint16, byval color as Uint32) as integer
    declare function aatrigonRGBA cdecl alias "aatrigonRGBA" (byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval x3 as Sint16, byval y3 as Sint16, _
	 byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer

'' Filled Trigon

    declare function filledTrigonColor cdecl alias "filledTrigonColor" (byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval x3 as Sint16, byval y3 as Sint16, byval color as Uint32) as integer
    declare function filledTrigonRGBA cdecl alias "filledTrigonRGBA" (byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval x3 as Sint16, byval y3 as Sint16, _
	 byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer

'' Polygon

    declare function polygonColor cdecl alias "polygonColor" (byval dst as SDL_Surface ptr, byval vx as Sint16 ptr, byval vy as Sint16 ptr, byval n as integer, byval color as Uint32) as integer
    declare function polygonRGBA cdecl alias "polygonRGBA" (byval dst as SDL_Surface ptr, byval vx as Sint16 ptr, byval vy as Sint16 ptr, _
	 byval n as integer, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer 

'' AA-Polygon

    declare function aapolygonColor cdecl alias "aapolygonColor" (byval dst as SDL_Surface ptr, byval vx as Sint16 ptr, byval vy as Sint16 ptr, byval n as integer, byval color as Uint32) as integer
    declare function aapolygonRGBA cdecl alias "aapolygonRGBA" (byval dst as SDL_Surface ptr, byval vx as Sint16 ptr, byval vy as Sint16 ptr, _
	 byval n as integer, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer

'' Filled Polygon

    declare function filledPolygonColor cdecl alias "filledPolygonColor" (byval dst as SDL_Surface ptr, byval vx as Sint16 ptr, byval vy as Sint16 ptr, byval n as integer, byval color as Uint32) as integer
    declare function filledPolygonRGBA cdecl alias "filledPolygonRGBA" (byval dst as SDL_Surface ptr, byval vx as Sint16 ptr, _
				       byval vy as Sint16 ptr, byval n as integer, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer

'' Bezier
'' s = number of steps

    declare function bezierColor cdecl alias "bezierColor" (byval dst as SDL_Surface ptr, byval vx as Sint16 ptr, byval vy as Sint16 ptr, byval n as integer, byval s as integer, byval color as Uint32) as integer
    declare function bezierRGBA cdecl alias "bezierRGBA" (byval dst as SDL_Surface ptr, byval vx as Sint16 ptr, byval vy as Sint16 ptr, _
	 byval n as integer, byval s as integer, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer


'' Characters/Strings

    declare function characterColor cdecl alias "characterColor" (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval c as byte, byval color as Uint32) as integer
    declare function characterRGBA cdecl alias "characterRGBA" (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval c as byte, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer
    declare function stringColor cdecl alias "stringColor" (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval c as zstring ptr, byval color as Uint32) as integer
    declare function stringRGBA cdecl alias "stringRGBA" (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval c as zstring ptr, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer

    declare sub gfxPrimitivesSetFont cdecl alias "gfxPrimitivesSetFont" (byval fontdata as any ptr, byval cw as integer, byval ch as integer)


#endif				'' SDL_gfxPrimitives_h
