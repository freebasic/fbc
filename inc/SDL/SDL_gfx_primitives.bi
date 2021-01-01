'' FreeBASIC binding for SDL_gfx-2.0.26
''
'' based on the C header files:
''   Copyright (C) 2001-2013  Andreas Schiffler
''
''   This software is provided 'as-is', without any express or implied
''   warranty. In no event will the authors be held liable for any damages
''   arising from the use of this software.
''
''   Permission is granted to anyone to use this software for any purpose,
''   including commercial applications, and to alter it and redistribute it
''   freely, subject to the following restrictions:
''
''   1. The origin of this software must not be misrepresented; you must not
''   claim that you wrote the original software. If you use this software
''   in a product, an acknowledgment in the product documentation would be
''   appreciated but is not required.
''
''   2. Altered source versions must be plainly marked as such, and must not be
''   misrepresented as being the original software.
''
''   3. This notice may not be removed or altered from any source
''   distribution.
''
''   Andreas Schiffler -- aschiffler at ferzkopp dot net
''
'' translated to FreeBASIC by:
''   Copyright © 2020 FreeBASIC development team

#pragma once

#inclib "SDL_gfx"

#include once "crt/math.bi"
#include once "SDL.bi"

extern "C"

#define _SDL_gfxPrimitives_h
const SDL_GFXPRIMITIVES_MAJOR = 2
const SDL_GFXPRIMITIVES_MINOR = 0
const SDL_GFXPRIMITIVES_MICRO = 26

declare function pixelColor(byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval color as Uint32) as long
declare function pixelRGBA(byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as long
declare function hlineColor(byval dst as SDL_Surface ptr, byval x1 as Sint16, byval x2 as Sint16, byval y as Sint16, byval color as Uint32) as long
declare function hlineRGBA(byval dst as SDL_Surface ptr, byval x1 as Sint16, byval x2 as Sint16, byval y as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as long
declare function vlineColor(byval dst as SDL_Surface ptr, byval x as Sint16, byval y1 as Sint16, byval y2 as Sint16, byval color as Uint32) as long
declare function vlineRGBA(byval dst as SDL_Surface ptr, byval x as Sint16, byval y1 as Sint16, byval y2 as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as long
declare function rectangleColor(byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval color as Uint32) as long
declare function rectangleRGBA(byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as long
declare function roundedRectangleColor(byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval rad as Sint16, byval color as Uint32) as long
declare function roundedRectangleRGBA(byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval rad as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as long
declare function boxColor(byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval color as Uint32) as long
declare function boxRGBA(byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as long
declare function roundedBoxColor(byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval rad as Sint16, byval color as Uint32) as long
declare function roundedBoxRGBA(byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval rad as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as long
declare function lineColor(byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval color as Uint32) as long
declare function lineRGBA(byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as long
declare function aalineColor(byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval color as Uint32) as long
declare function aalineRGBA(byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as long
declare function thickLineColor(byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval width as Uint8, byval color as Uint32) as long
declare function thickLineRGBA(byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval width as Uint8, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as long
declare function circleColor(byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval rad as Sint16, byval color as Uint32) as long
declare function circleRGBA(byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval rad as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as long
declare function arcColor(byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval rad as Sint16, byval start as Sint16, byval end as Sint16, byval color as Uint32) as long
declare function arcRGBA(byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval rad as Sint16, byval start as Sint16, byval end as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as long
declare function aacircleColor(byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval rad as Sint16, byval color as Uint32) as long
declare function aacircleRGBA(byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval rad as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as long
declare function filledCircleColor(byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval r as Sint16, byval color as Uint32) as long
declare function filledCircleRGBA(byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval rad as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as long
declare function ellipseColor(byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval rx as Sint16, byval ry as Sint16, byval color as Uint32) as long
declare function ellipseRGBA(byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval rx as Sint16, byval ry as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as long
declare function aaellipseColor(byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval rx as Sint16, byval ry as Sint16, byval color as Uint32) as long
declare function aaellipseRGBA(byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval rx as Sint16, byval ry as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as long
declare function filledEllipseColor(byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval rx as Sint16, byval ry as Sint16, byval color as Uint32) as long
declare function filledEllipseRGBA(byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval rx as Sint16, byval ry as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as long
declare function pieColor(byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval rad as Sint16, byval start as Sint16, byval end as Sint16, byval color as Uint32) as long
declare function pieRGBA(byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval rad as Sint16, byval start as Sint16, byval end as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as long
declare function filledPieColor(byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval rad as Sint16, byval start as Sint16, byval end as Sint16, byval color as Uint32) as long
declare function filledPieRGBA(byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval rad as Sint16, byval start as Sint16, byval end as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as long
declare function trigonColor(byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval x3 as Sint16, byval y3 as Sint16, byval color as Uint32) as long
declare function trigonRGBA(byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval x3 as Sint16, byval y3 as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as long
declare function aatrigonColor(byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval x3 as Sint16, byval y3 as Sint16, byval color as Uint32) as long
declare function aatrigonRGBA(byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval x3 as Sint16, byval y3 as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as long
declare function filledTrigonColor(byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval x3 as Sint16, byval y3 as Sint16, byval color as Uint32) as long
declare function filledTrigonRGBA(byval dst as SDL_Surface ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval x3 as Sint16, byval y3 as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as long
declare function polygonColor(byval dst as SDL_Surface ptr, byval vx as const Sint16 ptr, byval vy as const Sint16 ptr, byval n as long, byval color as Uint32) as long
declare function polygonRGBA(byval dst as SDL_Surface ptr, byval vx as const Sint16 ptr, byval vy as const Sint16 ptr, byval n as long, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as long
declare function aapolygonColor(byval dst as SDL_Surface ptr, byval vx as const Sint16 ptr, byval vy as const Sint16 ptr, byval n as long, byval color as Uint32) as long
declare function aapolygonRGBA(byval dst as SDL_Surface ptr, byval vx as const Sint16 ptr, byval vy as const Sint16 ptr, byval n as long, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as long
declare function filledPolygonColor(byval dst as SDL_Surface ptr, byval vx as const Sint16 ptr, byval vy as const Sint16 ptr, byval n as long, byval color as Uint32) as long
declare function filledPolygonRGBA(byval dst as SDL_Surface ptr, byval vx as const Sint16 ptr, byval vy as const Sint16 ptr, byval n as long, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as long
declare function texturedPolygon(byval dst as SDL_Surface ptr, byval vx as const Sint16 ptr, byval vy as const Sint16 ptr, byval n as long, byval texture as SDL_Surface ptr, byval texture_dx as long, byval texture_dy as long) as long
declare function filledPolygonColorMT(byval dst as SDL_Surface ptr, byval vx as const Sint16 ptr, byval vy as const Sint16 ptr, byval n as long, byval color as Uint32, byval polyInts as long ptr ptr, byval polyAllocated as long ptr) as long
declare function filledPolygonRGBAMT(byval dst as SDL_Surface ptr, byval vx as const Sint16 ptr, byval vy as const Sint16 ptr, byval n as long, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8, byval polyInts as long ptr ptr, byval polyAllocated as long ptr) as long
declare function texturedPolygonMT(byval dst as SDL_Surface ptr, byval vx as const Sint16 ptr, byval vy as const Sint16 ptr, byval n as long, byval texture as SDL_Surface ptr, byval texture_dx as long, byval texture_dy as long, byval polyInts as long ptr ptr, byval polyAllocated as long ptr) as long
declare function bezierColor(byval dst as SDL_Surface ptr, byval vx as const Sint16 ptr, byval vy as const Sint16 ptr, byval n as long, byval s as long, byval color as Uint32) as long
declare function bezierRGBA(byval dst as SDL_Surface ptr, byval vx as const Sint16 ptr, byval vy as const Sint16 ptr, byval n as long, byval s as long, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as long
declare sub gfxPrimitivesSetFont(byval fontdata as const any ptr, byval cw as Uint32, byval ch as Uint32)
declare sub gfxPrimitivesSetFontRotation(byval rotation as Uint32)
declare function characterColor(byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval c as byte, byval color as Uint32) as long
declare function characterRGBA(byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval c as byte, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as long
declare function stringColor(byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval s as const zstring ptr, byval color as Uint32) as long
declare function stringRGBA(byval dst as SDL_Surface ptr, byval x as Sint16, byval y as Sint16, byval s as const zstring ptr, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as long

end extern
