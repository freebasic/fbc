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

    declare function pixelColor alias "pixelColor" (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval color as Uint32) as integer
    declare function pixelRGBA alias "pixelRGBA" (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer

'' Horizontal line

    declare function hlineColor alias "hlineColor" (byval dst as SDL_Surface ptr, byval x1 as Sint16, byval x2 as Sint16, byval y as Sint16, byval color as Uint32) as integer
    declare function hlineRGBA alias "hlineRGBA" (byval dst as SDL_Surface ptr, byval x1 as Sint16, byval x2 as Sint16, byval y as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer

'' Vertical line

    declare function vlineColor alias "vlineColor" (byval dst as SDL_Surface ptr, byval x as Sint16, byval y1 as Sint16, byval y2 as Sint16, byval color as Uint32) as integer
    declare function vlineRGBA alias "vlineRGBA" (byval dst as SDL_Surface ptr, byval x as Sint16, byval y1 as Sint16, byval y2 as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer

'' Rectangle

    declare function rectangleColor alias "rectangleColor" (byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval color as Uint32) as integer
    declare function rectangleRGBA alias "rectangleRGBA" (byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, _
	 byval x2 as Sint16, byval y2 as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer

'' Filled rectangle (Box)

    declare function boxColor alias "boxColor" (byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval color as Uint32) as integer
    declare function boxRGBA alias "boxRGBA" (byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, _
	 byval y2 as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer

'' Line

    declare function lineColor alias "lineColor" (byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval color as Uint32) as integer
    declare function lineRGBA alias "lineRGBA" (byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, _
	 byval x2 as Sint16, byval y2 as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer

'' AA Line
    declare function aalineColor alias "aalineColor" (byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval color as Uint32) as integer
    declare function aalineRGBA alias "aalineRGBA" (byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, _
	 byval x2 as Sint16, byval y2 as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer

'' Circle

    declare function circleColor alias "circleColor" (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval r as Sint16, byval color as Uint32) as integer
    declare function circleRGBA alias "circleRGBA" (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval rad as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer

'' AA Circle

    declare function aacircleColor alias "aacircleColor" (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval r as Sint16, byval color as Uint32) as integer
    declare function aacircleRGBA alias "aacircleRGBA" (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, _
	 byval rad as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer

'' Filled Circle

    declare function filledCircleColor alias "filledCircleColor" (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval r as Sint16, byval color as Uint32) as integer
    declare function filledCircleRGBA alias "filledCircleRGBA" (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, _
	 byval rad as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer

'' Ellipse

    declare function ellipseColor alias "ellipseColor" (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval rx as Sint16, byval ry as Sint16, byval color as Uint32) as integer
    declare function ellipseRGBA alias "ellipseRGBA" (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, _
	 byval rx as Sint16, byval ry as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer

'' AA Ellipse

    declare function aaellipseColor alias "aaellipseColor" (byval dst as SDL_Surface ptr, byval xc as Sint16, byval yc as Sint16, byval rx as Sint16, byval ry as Sint16, byval color as Uint32) as integer
    declare function aaellipseRGBA alias "aaellipseRGBA" (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, _
	 byval rx as Sint16, byval ry as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer

'' Filled Ellipse

    declare function filledEllipseColor alias "filledEllipseColor" (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval rx as Sint16, byval ry as Sint16, byval color as Uint32) as integer
    declare function filledEllipseRGBA alias "filledEllipseRGBA" (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, _
	 byval rx as Sint16, byval ry as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer

#define CLOCKWISE

'' Pie

    declare function pieColor alias "pieColor" (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval rad as Sint16, _
	 byval start as Sint16, byval end as Sint16, byval color as Uint32) as integer
    declare function pieRGBA alias "pieRGBA" (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval rad as Sint16, _
	 byval start as Sint16, byval end as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer

'' Filled Pie

    declare function filledPieColor alias "filledPieColor" (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval rad as Sint16, _
	 byval start as Sint16, byval end as Sint16, byval color as Uint32) as integer
    declare function filledPieRGBA alias "filledPieRGBA" (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval rad as Sint16, _
	 byval start as Sint16, byval end as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer

'' Trigon

    declare function trigonColor alias "trigonColor" (byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval x3 as Sint16, byval y3 as Sint16, byval color as Uint32) as integer
    declare function trigonRGBA alias "trigonRGBA" (byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval x3 as Sint16, byval y3 as Sint16, _
	 byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer

'' AA-Trigon

    declare function aatrigonColor alias "aatrigonColor" (byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval x3 as Sint16, byval y3 as Sint16, byval color as Uint32) as integer
    declare function aatrigonRGBA alias "aatrigonRGBA" (byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval x3 as Sint16, byval y3 as Sint16, _
	 byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer

'' Filled Trigon

    declare function filledTrigonColor alias "filledTrigonColor" (byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval x3 as Sint16, byval y3 as Sint16, byval color as Uint32) as integer
    declare function filledTrigonRGBA alias "filledTrigonRGBA" (byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval x3 as Sint16, byval y3 as Sint16, _
	 byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer

'' Polygon

    declare function polygonColor alias "polygonColor" (byval dst as SDL_Surface ptr, byval vx as Sint16 ptr, byval vy as Sint16 ptr, byval n as integer, byval color as Uint32) as integer
    declare function polygonRGBA alias "polygonRGBA" (byval dst as SDL_Surface ptr, byval vx as Sint16 ptr, byval vy as Sint16 ptr, _
	 byval n as integer, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer 

'' AA-Polygon

    declare function aapolygonColor alias "aapolygonColor" (byval dst as SDL_Surface ptr, byval vx as Sint16 ptr, byval vy as Sint16 ptr, byval n as integer, byval color as Uint32) as integer
    declare function aapolygonRGBA alias "aapolygonRGBA" (byval dst as SDL_Surface ptr, byval vx as Sint16 ptr, byval vy as Sint16 ptr, _
	 byval n as integer, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer

'' Filled Polygon

    declare function filledPolygonColor alias "filledPolygonColor" (byval dst as SDL_Surface ptr, byval vx as Sint16 ptr, byval vy as Sint16 ptr, byval n as integer, byval color as Uint32) as integer
    declare function filledPolygonRGBA alias "filledPolygonRGBA" (byval dst as SDL_Surface ptr, byval vx as Sint16 ptr, _
				       byval vy as Sint16 ptr, byval n as integer, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer

'' Bezier
'' s = number of steps

    declare function bezierColor alias "bezierColor" (byval dst as SDL_Surface ptr, byval vx as Sint16 ptr, byval vy as Sint16 ptr, byval n as integer, byval s as integer, byval color as Uint32) as integer
    declare function bezierRGBA alias "bezierRGBA" (byval dst as SDL_Surface ptr, byval vx as Sint16 ptr, byval vy as Sint16 ptr, _
	 byval n as integer, byval s as integer, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer


'' Characters/Strings

    declare function characterColor alias "characterColor" (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval c as byte, byval color as Uint32) as integer
    declare function characterRGBA alias "characterRGBA" (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval c as byte, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer
    declare function stringColor alias "stringColor" (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval c as string, byval color as Uint32) as integer
    declare function stringRGBA alias "stringRGBA" (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval c as string, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer

    declare sub gfxPrimitivesSetFont alias "gfxPrimitivesSetFont" (byval fontdata as any ptr, byval cw as integer, byval ch as integer)


#endif				'' SDL_gfxPrimitives_h
