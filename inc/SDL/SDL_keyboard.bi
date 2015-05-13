''
''
'' SDL_keyboard -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __SDL_keyboard_bi__
#define __SDL_keyboard_bi__

#include once "SDL_types.bi"
#include once "SDL_keysym.bi"
#include once "begin_code.bi"

type SDL_keysym
	scancode as Uint8
	sym as SDLKey
	mod_ as SDLMod
	unicode_ as Uint16
end type

#define SDL_ALL_HOTKEYS &hFFFFFFFF

declare function SDL_EnableUNICODE cdecl alias "SDL_EnableUNICODE" (byval enable as integer) as integer

#define SDL_DEFAULT_REPEAT_DELAY 500
#define SDL_DEFAULT_REPEAT_INTERVAL 30

declare function SDL_EnableKeyRepeat cdecl alias "SDL_EnableKeyRepeat" (byval delay as integer, byval interval as integer) as integer
declare function SDL_GetKeyState cdecl alias "SDL_GetKeyState" (byval numkeys as integer ptr) as Uint8 ptr
declare function SDL_GetModState cdecl alias "SDL_GetModState" () as SDLMod
declare sub SDL_SetModState cdecl alias "SDL_SetModState" (byval modstate as SDLMod)
declare function SDL_GetKeyName cdecl alias "SDL_GetKeyName" (byval key as SDLKey) as zstring ptr

#include once "close_code.bi"

#endif
