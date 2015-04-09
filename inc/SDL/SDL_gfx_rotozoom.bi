'' FreeBASIC binding for SDL_gfx-2.0.13

#pragma once

#inclib "SDL_gfx"

#include once "crt/math.bi"
#include once "SDL.bi"

extern "C"

#define _SDL_rotozoom_h
const SMOOTHING_OFF = 0
const SMOOTHING_ON = 1

type tColorRGBA
	r as Uint8
	g as Uint8
	b as Uint8
	a as Uint8
end type

type tColorY
	y as Uint8
end type

declare function rotozoomSurface(byval src as SDL_Surface ptr, byval angle as double, byval zoom as double, byval smooth as long) as SDL_Surface ptr
declare function rotozoomSurfaceXY(byval src as SDL_Surface ptr, byval angle as double, byval zoomx as double, byval zoomy as double, byval smooth as long) as SDL_Surface ptr
declare sub rotozoomSurfaceSize(byval width as long, byval height as long, byval angle as double, byval zoom as double, byval dstwidth as long ptr, byval dstheight as long ptr)
declare sub rotozoomSurfaceSizeXY(byval width as long, byval height as long, byval angle as double, byval zoomx as double, byval zoomy as double, byval dstwidth as long ptr, byval dstheight as long ptr)
declare function zoomSurface(byval src as SDL_Surface ptr, byval zoomx as double, byval zoomy as double, byval smooth as long) as SDL_Surface ptr
declare sub zoomSurfaceSize(byval width as long, byval height as long, byval zoomx as double, byval zoomy as double, byval dstwidth as long ptr, byval dstheight as long ptr)

end extern
