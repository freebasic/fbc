' SDL.h header ported to freeBasic by Edmond Leung (leung.edmond@gmail.com)

'$inclib: "SDL"

#ifndef SDL_BI_
#define SDL_BI_

'$include: "SDL/SDL_main.bi"
'$include: "SDL/SDL_types.bi"
'$include: "SDL/SDL_getenv.bi"
'$include: "SDL/SDL_rwops.bi"
'$include: "SDL/SDL_timer.bi"
'$include: "SDL/SDL_audio.bi"
'$include: "SDL/SDL_cdrom.bi"
'$include: "SDL/SDL_joystick.bi"
'$include: "SDL/SDL_events.bi"
'$include: "SDL/SDL_video.bi"
'$include: "SDL/SDL_byteorder.bi"
'$include: "SDL/SDL_version.bi"

'$include: "SDL/begin_code.bi"

#define SDL_INIT_TIMER &h00000001
#define SDL_INIT_AUDIO &h00000010
#define SDL_INIT_VIDEO &h00000020
#define SDL_INIT_CDROM &h00000100
#define SDL_INIT_JOYSTICK &h00000200
#define SDL_INIT_NOPARACHUTE &h00100000
#define SDL_INIT_EVENTTHREAD &h01000000
#define SDL_INIT_EVERYTHING &h0000FFFF

declare function SDL_Init SDLCALL alias "SDL_Init" _
   (byval flags as Uint32) as integer

declare function SDL_InitSubSystem SDLCALL alias "SDL_InitSubSystem" _
   (byval flags as Uint32) as integer

declare sub SDL_QuitSubSystem SDLCALL alias "SDL_QuitSubSystem" _
   (byval flags as Uint32)

declare function SDL_WasInit SDLCALL alias "SDL_WasInit" _
   (byval flags as Uint32) as Uint32

declare sub SDL_Quit SDLCALL alias "SDL_Quit" ()

'$include: "SDL/close_code.bi"

#endif