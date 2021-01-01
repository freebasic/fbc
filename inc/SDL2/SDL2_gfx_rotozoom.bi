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

#define _SDL2_rotozoom_h
const SMOOTHING_OFF = 0
const SMOOTHING_ON = 1

declare function rotozoomSurface(byval src as SDL_Surface ptr, byval angle as double, byval zoom as double, byval smooth as long) as SDL_Surface ptr
declare function rotozoomSurfaceXY(byval src as SDL_Surface ptr, byval angle as double, byval zoomx as double, byval zoomy as double, byval smooth as long) as SDL_Surface ptr
declare sub rotozoomSurfaceSize(byval width as long, byval height as long, byval angle as double, byval zoom as double, byval dstwidth as long ptr, byval dstheight as long ptr)
declare sub rotozoomSurfaceSizeXY(byval width as long, byval height as long, byval angle as double, byval zoomx as double, byval zoomy as double, byval dstwidth as long ptr, byval dstheight as long ptr)
declare function zoomSurface(byval src as SDL_Surface ptr, byval zoomx as double, byval zoomy as double, byval smooth as long) as SDL_Surface ptr
declare sub zoomSurfaceSize(byval width as long, byval height as long, byval zoomx as double, byval zoomy as double, byval dstwidth as long ptr, byval dstheight as long ptr)
declare function shrinkSurface(byval src as SDL_Surface ptr, byval factorx as long, byval factory as long) as SDL_Surface ptr
declare function rotateSurface90Degrees(byval src as SDL_Surface ptr, byval numClockwiseTurns as long) as SDL_Surface ptr

end extern
