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

#include once "SDL.bi"

#define SDL_GFXPRIMITIVES_MAJOR	2
#define SDL_GFXPRIMITIVES_MINOR	0
#define SDL_GFXPRIMITIVES_MICRO	13

'' Note: all ___Color routines expect the color to be in format 0xRRGGBBAA

extern "c"
    declare function pixelColor (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval color as Uint32) as integer
    declare function pixelRGBA (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer
    declare function hlineColor (byval dst as SDL_Surface ptr, byval x1 as Sint16, byval x2 as Sint16, byval y as Sint16, byval color as Uint32) as integer
    declare function hlineRGBA (byval dst as SDL_Surface ptr, byval x1 as Sint16, byval x2 as Sint16, byval y as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer
    declare function vlineColor (byval dst as SDL_Surface ptr, byval x as Sint16, byval y1 as Sint16, byval y2 as Sint16, byval color as Uint32) as integer
    declare function vlineRGBA (byval dst as SDL_Surface ptr, byval x as Sint16, byval y1 as Sint16, byval y2 as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer
    declare function rectangleColor (byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval color as Uint32) as integer
    declare function rectangleRGBA (byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer
    declare function boxColor (byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval color as Uint32) as integer
    declare function boxRGBA (byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer
    declare function lineColor (byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval color as Uint32) as integer
    declare function lineRGBA (byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer
    declare function aalineColor (byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval color as Uint32) as integer
    declare function aalineRGBA (byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer
    declare function circleColor (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval r as Sint16, byval color as Uint32) as integer
    declare function circleRGBA (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval rad as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer
    declare function aacircleColor (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval r as Sint16, byval color as Uint32) as integer
    declare function aacircleRGBA (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval rad as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer
    declare function filledCircleColor (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval r as Sint16, byval color as Uint32) as integer
    declare function filledCircleRGBA (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval rad as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer
    declare function ellipseColor (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval rx as Sint16, byval ry as Sint16, byval color as Uint32) as integer
    declare function ellipseRGBA (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval rx as Sint16, byval ry as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer
    declare function aaellipseColor (byval dst as SDL_Surface ptr, byval xc as Sint16, byval yc as Sint16, byval rx as Sint16, byval ry as Sint16, byval color as Uint32) as integer
    declare function aaellipseRGBA (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval rx as Sint16, byval ry as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer
    declare function filledEllipseColor (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval rx as Sint16, byval ry as Sint16, byval color as Uint32) as integer
    declare function filledEllipseRGBA (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval rx as Sint16, byval ry as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer
#define CLOCKWISE
    declare function pieColor (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval rad as Sint16, byval start as Sint16, byval end as Sint16, byval color as Uint32) as integer
    declare function pieRGBA (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval rad as Sint16, byval start as Sint16, byval end as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer
    declare function filledPieColor (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval rad as Sint16, byval start as Sint16, byval end as Sint16, byval color as Uint32) as integer
    declare function filledPieRGBA (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval rad as Sint16, byval start as Sint16, byval end as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer
    declare function trigonColor (byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval x3 as Sint16, byval y3 as Sint16, byval color as Uint32) as integer
    declare function trigonRGBA (byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval x3 as Sint16, byval y3 as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer
    declare function aatrigonColor (byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval x3 as Sint16, byval y3 as Sint16, byval color as Uint32) as integer
    declare function aatrigonRGBA (byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval x3 as Sint16, byval y3 as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer
    declare function filledTrigonColor (byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval x3 as Sint16, byval y3 as Sint16, byval color as Uint32) as integer
    declare function filledTrigonRGBA (byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval x3 as Sint16, byval y3 as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer
    declare function polygonColor (byval dst as SDL_Surface ptr, byval vx as Sint16 ptr, byval vy as Sint16 ptr, byval n as integer, byval color as Uint32) as integer
    declare function polygonRGBA (byval dst as SDL_Surface ptr, byval vx as Sint16 ptr, byval vy as Sint16 ptr, byval n as integer, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer 
    declare function aapolygonColor (byval dst as SDL_Surface ptr, byval vx as Sint16 ptr, byval vy as Sint16 ptr, byval n as integer, byval color as Uint32) as integer
    declare function aapolygonRGBA (byval dst as SDL_Surface ptr, byval vx as Sint16 ptr, byval vy as Sint16 ptr, byval n as integer, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer
    declare function filledPolygonColor (byval dst as SDL_Surface ptr, byval vx as Sint16 ptr, byval vy as Sint16 ptr, byval n as integer, byval color as Uint32) as integer
    declare function filledPolygonRGBA (byval dst as SDL_Surface ptr, byval vx as Sint16 ptr, byval vy as Sint16 ptr, byval n as integer, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer
    declare function bezierColor (byval dst as SDL_Surface ptr, byval vx as Sint16 ptr, byval vy as Sint16 ptr, byval n as integer, byval s as integer, byval color as Uint32) as integer
    declare function bezierRGBA (byval dst as SDL_Surface ptr, byval vx as Sint16 ptr, byval vy as Sint16 ptr, byval n as integer, byval s as integer, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer
    declare function characterColor (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval c as byte, byval color as Uint32) as integer
    declare function characterRGBA (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval c as byte, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer
    declare function stringColor (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval c as zstring ptr, byval color as Uint32) as integer
    declare function stringRGBA (byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval c as zstring ptr, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as integer
    declare sub gfxPrimitivesSetFont (byval fontdata as any ptr, byval cw as integer, byval ch as integer)
end extern

#endif				'' SDL_gfxPrimitives_h
