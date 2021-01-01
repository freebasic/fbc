'' FreeBASIC binding for SDL2_gfx-1.0.4
''
'' based on the C header files:
''   Copyright (C) 2012-2014  Andreas Schiffler
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

#inclib "SDL2_gfx"

#include once "crt/math.bi"
#include once "SDL.bi"

extern "C"

#define _SDL2_gfxPrimitives_h
const SDL2_GFXPRIMITIVES_MAJOR = 1
const SDL2_GFXPRIMITIVES_MINOR = 0
const SDL2_GFXPRIMITIVES_MICRO = 4

declare function pixelColor(byval renderer as SDL_Renderer ptr, byval x as Sint16, byval y as Sint16, byval color as Uint32) as long
declare function pixelRGBA(byval renderer as SDL_Renderer ptr, byval x as Sint16, byval y as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as long
declare function hlineColor(byval renderer as SDL_Renderer ptr, byval x1 as Sint16, byval x2 as Sint16, byval y as Sint16, byval color as Uint32) as long
declare function hlineRGBA(byval renderer as SDL_Renderer ptr, byval x1 as Sint16, byval x2 as Sint16, byval y as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as long
declare function vlineColor(byval renderer as SDL_Renderer ptr, byval x as Sint16, byval y1 as Sint16, byval y2 as Sint16, byval color as Uint32) as long
declare function vlineRGBA(byval renderer as SDL_Renderer ptr, byval x as Sint16, byval y1 as Sint16, byval y2 as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as long
declare function rectangleColor(byval renderer as SDL_Renderer ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval color as Uint32) as long
declare function rectangleRGBA(byval renderer as SDL_Renderer ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as long
declare function roundedRectangleColor(byval renderer as SDL_Renderer ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval rad as Sint16, byval color as Uint32) as long
declare function roundedRectangleRGBA(byval renderer as SDL_Renderer ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval rad as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as long
declare function boxColor(byval renderer as SDL_Renderer ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval color as Uint32) as long
declare function boxRGBA(byval renderer as SDL_Renderer ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as long
declare function roundedBoxColor(byval renderer as SDL_Renderer ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval rad as Sint16, byval color as Uint32) as long
declare function roundedBoxRGBA(byval renderer as SDL_Renderer ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval rad as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as long
declare function lineColor(byval renderer as SDL_Renderer ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval color as Uint32) as long
declare function lineRGBA(byval renderer as SDL_Renderer ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as long
declare function aalineColor(byval renderer as SDL_Renderer ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval color as Uint32) as long
declare function aalineRGBA(byval renderer as SDL_Renderer ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as long
declare function thickLineColor(byval renderer as SDL_Renderer ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval width as Uint8, byval color as Uint32) as long
declare function thickLineRGBA(byval renderer as SDL_Renderer ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval width as Uint8, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as long
declare function circleColor(byval renderer as SDL_Renderer ptr, byval x as Sint16, byval y as Sint16, byval rad as Sint16, byval color as Uint32) as long
declare function circleRGBA(byval renderer as SDL_Renderer ptr, byval x as Sint16, byval y as Sint16, byval rad as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as long
declare function arcColor(byval renderer as SDL_Renderer ptr, byval x as Sint16, byval y as Sint16, byval rad as Sint16, byval start as Sint16, byval end as Sint16, byval color as Uint32) as long
declare function arcRGBA(byval renderer as SDL_Renderer ptr, byval x as Sint16, byval y as Sint16, byval rad as Sint16, byval start as Sint16, byval end as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as long
declare function aacircleColor(byval renderer as SDL_Renderer ptr, byval x as Sint16, byval y as Sint16, byval rad as Sint16, byval color as Uint32) as long
declare function aacircleRGBA(byval renderer as SDL_Renderer ptr, byval x as Sint16, byval y as Sint16, byval rad as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as long
declare function filledCircleColor(byval renderer as SDL_Renderer ptr, byval x as Sint16, byval y as Sint16, byval r as Sint16, byval color as Uint32) as long
declare function filledCircleRGBA(byval renderer as SDL_Renderer ptr, byval x as Sint16, byval y as Sint16, byval rad as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as long
declare function ellipseColor(byval renderer as SDL_Renderer ptr, byval x as Sint16, byval y as Sint16, byval rx as Sint16, byval ry as Sint16, byval color as Uint32) as long
declare function ellipseRGBA(byval renderer as SDL_Renderer ptr, byval x as Sint16, byval y as Sint16, byval rx as Sint16, byval ry as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as long
declare function aaellipseColor(byval renderer as SDL_Renderer ptr, byval x as Sint16, byval y as Sint16, byval rx as Sint16, byval ry as Sint16, byval color as Uint32) as long
declare function aaellipseRGBA(byval renderer as SDL_Renderer ptr, byval x as Sint16, byval y as Sint16, byval rx as Sint16, byval ry as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as long
declare function filledEllipseColor(byval renderer as SDL_Renderer ptr, byval x as Sint16, byval y as Sint16, byval rx as Sint16, byval ry as Sint16, byval color as Uint32) as long
declare function filledEllipseRGBA(byval renderer as SDL_Renderer ptr, byval x as Sint16, byval y as Sint16, byval rx as Sint16, byval ry as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as long
declare function pieColor(byval renderer as SDL_Renderer ptr, byval x as Sint16, byval y as Sint16, byval rad as Sint16, byval start as Sint16, byval end as Sint16, byval color as Uint32) as long
declare function pieRGBA(byval renderer as SDL_Renderer ptr, byval x as Sint16, byval y as Sint16, byval rad as Sint16, byval start as Sint16, byval end as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as long
declare function filledPieColor(byval renderer as SDL_Renderer ptr, byval x as Sint16, byval y as Sint16, byval rad as Sint16, byval start as Sint16, byval end as Sint16, byval color as Uint32) as long
declare function filledPieRGBA(byval renderer as SDL_Renderer ptr, byval x as Sint16, byval y as Sint16, byval rad as Sint16, byval start as Sint16, byval end as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as long
declare function trigonColor(byval renderer as SDL_Renderer ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval x3 as Sint16, byval y3 as Sint16, byval color as Uint32) as long
declare function trigonRGBA(byval renderer as SDL_Renderer ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval x3 as Sint16, byval y3 as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as long
declare function aatrigonColor(byval renderer as SDL_Renderer ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval x3 as Sint16, byval y3 as Sint16, byval color as Uint32) as long
declare function aatrigonRGBA(byval renderer as SDL_Renderer ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval x3 as Sint16, byval y3 as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as long
declare function filledTrigonColor(byval renderer as SDL_Renderer ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval x3 as Sint16, byval y3 as Sint16, byval color as Uint32) as long
declare function filledTrigonRGBA(byval renderer as SDL_Renderer ptr, byval x1 as Sint16, byval y1 as Sint16, byval x2 as Sint16, byval y2 as Sint16, byval x3 as Sint16, byval y3 as Sint16, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as long
declare function polygonColor(byval renderer as SDL_Renderer ptr, byval vx as const Sint16 ptr, byval vy as const Sint16 ptr, byval n as long, byval color as Uint32) as long
declare function polygonRGBA(byval renderer as SDL_Renderer ptr, byval vx as const Sint16 ptr, byval vy as const Sint16 ptr, byval n as long, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as long
declare function aapolygonColor(byval renderer as SDL_Renderer ptr, byval vx as const Sint16 ptr, byval vy as const Sint16 ptr, byval n as long, byval color as Uint32) as long
declare function aapolygonRGBA(byval renderer as SDL_Renderer ptr, byval vx as const Sint16 ptr, byval vy as const Sint16 ptr, byval n as long, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as long
declare function filledPolygonColor(byval renderer as SDL_Renderer ptr, byval vx as const Sint16 ptr, byval vy as const Sint16 ptr, byval n as long, byval color as Uint32) as long
declare function filledPolygonRGBA(byval renderer as SDL_Renderer ptr, byval vx as const Sint16 ptr, byval vy as const Sint16 ptr, byval n as long, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as long
declare function texturedPolygon(byval renderer as SDL_Renderer ptr, byval vx as const Sint16 ptr, byval vy as const Sint16 ptr, byval n as long, byval texture as SDL_Surface ptr, byval texture_dx as long, byval texture_dy as long) as long
declare function bezierColor(byval renderer as SDL_Renderer ptr, byval vx as const Sint16 ptr, byval vy as const Sint16 ptr, byval n as long, byval s as long, byval color as Uint32) as long
declare function bezierRGBA(byval renderer as SDL_Renderer ptr, byval vx as const Sint16 ptr, byval vy as const Sint16 ptr, byval n as long, byval s as long, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as long
declare sub gfxPrimitivesSetFont(byval fontdata as const any ptr, byval cw as Uint32, byval ch as Uint32)
declare sub gfxPrimitivesSetFontRotation(byval rotation as Uint32)
declare function characterColor(byval renderer as SDL_Renderer ptr, byval x as Sint16, byval y as Sint16, byval c as byte, byval color as Uint32) as long
declare function characterRGBA(byval renderer as SDL_Renderer ptr, byval x as Sint16, byval y as Sint16, byval c as byte, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as long
declare function stringColor(byval renderer as SDL_Renderer ptr, byval x as Sint16, byval y as Sint16, byval s as const zstring ptr, byval color as Uint32) as long
declare function stringRGBA(byval renderer as SDL_Renderer ptr, byval x as Sint16, byval y as Sint16, byval s as const zstring ptr, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as long

end extern
