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
