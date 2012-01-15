''
''
'' SDL_syswm -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __SDL_syswm_bi__
#define __SDL_syswm_bi__

#include once "SDL_version.bi"
#include once "begin_code.bi"

#ifdef SDL_PROTOTYPES_ONLY
type SDL_SysWMmsg as _SDL_SysWMmsg
type SDL_SysWMinfo as _SDL_SysWMinfo

#else

# ifdef __FB_WIN32__

#  include once "windows.bi"

type SDL_SysWMmsg
	version as SDL_version
	hwnd as HWND
	msg as UINT
	wParam as WPARAM
	lParam as LPARAM
end type

type SDL_SysWMinfo
	version as SDL_version
	window as HWND
	hglrc as HGLRC
end type

# else '' __FB_WIN32__
type SDL_SysWMmsg
	version as SDL_version 
	data as integer
end type

type SDL_SysWMinfo
	version as SDL_version 
	data as integer
end type
# endif ''__FB_WIN32__

#endif '' SDL_PROTOTYPES_ONLY

declare function SDL_GetWMInfo cdecl alias "SDL_GetWMInfo" (byval info as SDL_SysWMinfo ptr) as integer

#include once "close_code.bi"

#endif
