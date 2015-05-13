#pragma once

#inclib "SDL_gfx"

#include once "SDL.bi"

extern "C"

#define _SDL_framerate_h
const FPS_UPPER_LIMIT = 200
const FPS_LOWER_LIMIT = 1
const FPS_DEFAULT = 30

type FPSmanager
	framecount as Uint32
	rateticks as single
	lastticks as Uint32
	rate as Uint32
end type

declare sub SDL_initFramerate(byval manager as FPSmanager ptr)
declare function SDL_setFramerate(byval manager as FPSmanager ptr, byval rate as long) as long
declare function SDL_getFramerate(byval manager as FPSmanager ptr) as long
declare sub SDL_framerateDelay(byval manager as FPSmanager ptr)

end extern
