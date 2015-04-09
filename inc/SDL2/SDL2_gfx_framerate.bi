'' FreeBASIC binding for SDL2_gfx-1.0.1

#pragma once

#inclib "SDL2_gfx"

#include once "SDL.bi"

extern "C"

#define _SDL2_framerate_h
const FPS_UPPER_LIMIT = 200
const FPS_LOWER_LIMIT = 1
const FPS_DEFAULT = 30

type FPSmanager
	framecount as Uint32
	rateticks as single
	baseticks as Uint32
	lastticks as Uint32
	rate as Uint32
end type

declare sub SDL_initFramerate(byval manager as FPSmanager ptr)
declare function SDL_setFramerate(byval manager as FPSmanager ptr, byval rate as Uint32) as long
declare function SDL_getFramerate(byval manager as FPSmanager ptr) as long
declare function SDL_getFramecount(byval manager as FPSmanager ptr) as long
declare function SDL_framerateDelay(byval manager as FPSmanager ptr) as Uint32

end extern
