
''
''
'' SDL_framerate: framerate manager
'' 
'' LGPL (c) A. Schiffler
'' 
''

#ifndef SDL_framerate_h
#define SDL_framerate_h

#inclib "SDL_gfx"

#include once "SDL/SDL.bi"

#define FPS_UPPER_LIMIT		200
#define FPS_LOWER_LIMIT		1
#define FPS_DEFAULT		30

type FPSmanager
	framecount as Uint32 
	rateticks as single
	lastticks as Uint32 
	rate as Uint32 
end type

declare sub SDL_initFramerate alias "SDL_initFramerate" (byval manager as FPSmanager ptr)
declare function SDL_setFramerate alias "SDL_setFramerate" (byval manager as FPSmanager ptr, byval rate as integer) as integer
declare function SDL_getFramerate alias "SDL_getFramerate" (byval manager as FPSmanager ptr) as integer
declare sub SDL_framerateDelay alias "SDL_framerateDelay" (byval manager as FPSmanager ptr)


#endif
