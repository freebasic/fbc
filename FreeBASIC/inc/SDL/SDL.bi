''
''
'' SDL -- Simple DirectMedia Layer
''		  (header translated with help of SWIG FB wrapper)
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __SDL_bi__
#define __SDL_bi__

#include once "SDL_main.bi"
#include once "SDL_types.bi"
#include once "SDL_getenv.bi"
#include once "SDL_error.bi"
#include once "SDL_rwops.bi"
#include once "SDL_timer.bi"
#include once "SDL_audio.bi"
#include once "SDL_cdrom.bi"
#include once "SDL_joystick.bi"
#include once "SDL_events.bi"
#include once "SDL_video.bi"
#include once "SDL_byteorder.bi"
#include once "SDL_version.bi"
#include once "begin_code.bi"

#define SDL_INIT_TIMER &h00000001
#define SDL_INIT_AUDIO &h00000010
#define SDL_INIT_VIDEO &h00000020
#define SDL_INIT_CDROM &h00000100
#define SDL_INIT_JOYSTICK &h00000200
#define SDL_INIT_NOPARACHUTE &h00100000
#define SDL_INIT_EVENTTHREAD &h01000000
#define SDL_INIT_EVERYTHING &h0000FFFF

extern "c"
declare function SDL_Init (byval flags as Uint32) as integer
declare function SDL_InitSubSystem (byval flags as Uint32) as integer
declare sub SDL_QuitSubSystem (byval flags as Uint32)
declare function SDL_WasInit (byval flags as Uint32) as Uint32
declare sub SDL_Quit ()
end extern

#include once "close_code.bi"

#endif
