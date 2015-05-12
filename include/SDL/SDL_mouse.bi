''
''
'' SDL_mouse -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __SDL_mouse_bi__
#define __SDL_mouse_bi__

#include once "SDL_types.bi"
#include once "SDL_video.bi"
#include once "begin_code.bi"

type WMcursor as _WMcursor

type SDL_Cursor
	area as SDL_Rect
	hot_x as Sint16
	hot_y as Sint16
	data as Uint8 ptr
	mask as Uint8 ptr
	save(0 to 2-1) as Uint8 ptr
	wm_cursor as WMcursor ptr
end type

declare function SDL_GetMouseState cdecl alias "SDL_GetMouseState" (byval x as integer ptr, byval y as integer ptr) as Uint8
declare function SDL_GetRelativeMouseState cdecl alias "SDL_GetRelativeMouseState" (byval x as integer ptr, byval y as integer ptr) as Uint8
declare sub SDL_WarpMouse cdecl alias "SDL_WarpMouse" (byval x as Uint16, byval y as Uint16)
declare function SDL_CreateCursor cdecl alias "SDL_CreateCursor" (byval data as Uint8 ptr, byval mask as Uint8 ptr, byval w as integer, byval h as integer, byval hot_x as integer, byval hot_y as integer) as SDL_Cursor ptr
declare sub SDL_SetCursor cdecl alias "SDL_SetCursor" (byval cursor as SDL_Cursor ptr)
declare function SDL_GetCursor cdecl alias "SDL_GetCursor" () as SDL_Cursor ptr
declare sub SDL_FreeCursor cdecl alias "SDL_FreeCursor" (byval cursor as SDL_Cursor ptr)
declare function SDL_ShowCursor cdecl alias "SDL_ShowCursor" (byval toggle as integer) as integer

#define SDL_BUTTON(X) (SDL_PRESSED shl ((X)-1))

#define SDL_BUTTON_LEFT 1
#define SDL_BUTTON_MIDDLE 2
#define SDL_BUTTON_RIGHT 3
#define SDL_BUTTON_WHEELUP 4
#define SDL_BUTTON_WHEELDOWN 5

#include once "close_code.bi"

#endif
