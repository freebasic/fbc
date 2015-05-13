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
