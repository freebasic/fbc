''
''
'' SDL_joystick -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __SDL_joystick_bi__
#define __SDL_joystick_bi__

#include once "SDL_types.bi"
#include once "begin_code.bi"

type SDL_Joystick as _SDL_Joystick

declare function SDL_NumJoysticks cdecl alias "SDL_NumJoysticks" () as integer
declare function SDL_JoystickName cdecl alias "SDL_JoystickName" (byval device_index as integer) as zstring ptr
declare function SDL_JoystickOpen cdecl alias "SDL_JoystickOpen" (byval device_index as integer) as SDL_Joystick ptr
declare function SDL_JoystickOpened cdecl alias "SDL_JoystickOpened" (byval device_index as integer) as integer
declare function SDL_JoystickIndex cdecl alias "SDL_JoystickIndex" (byval joystick as SDL_Joystick ptr) as integer
declare function SDL_JoystickNumAxes cdecl alias "SDL_JoystickNumAxes" (byval joystick as SDL_Joystick ptr) as integer
declare function SDL_JoystickNumBalls cdecl alias "SDL_JoystickNumBalls" (byval joystick as SDL_Joystick ptr) as integer
declare function SDL_JoystickNumHats cdecl alias "SDL_JoystickNumHats" (byval joystick as SDL_Joystick ptr) as integer
declare function SDL_JoystickNumButtons cdecl alias "SDL_JoystickNumButtons" (byval joystick as SDL_Joystick ptr) as integer
declare sub SDL_JoystickUpdate cdecl alias "SDL_JoystickUpdate" ()
declare function SDL_JoystickEventState cdecl alias "SDL_JoystickEventState" (byval state as integer) as integer
declare function SDL_JoystickGetAxis cdecl alias "SDL_JoystickGetAxis" (byval joystick as SDL_Joystick ptr, byval axis as integer) as Sint16

#define SDL_HAT_CENTERED &h00
#define SDL_HAT_UP &h01
#define SDL_HAT_RIGHT &h02
#define SDL_HAT_DOWN &h04
#define SDL_HAT_LEFT &h08
#define SDL_HAT_RIGHTUP (&h02 or &h01)
#define SDL_HAT_RIGHTDOWN (&h02 or &h04)
#define SDL_HAT_LEFTUP (&h08 or &h01)
#define SDL_HAT_LEFTDOWN (&h08 or &h04)

declare function SDL_JoystickGetHat cdecl alias "SDL_JoystickGetHat" (byval joystick as SDL_Joystick ptr, byval hat as integer) as Uint8
declare function SDL_JoystickGetBall cdecl alias "SDL_JoystickGetBall" (byval joystick as SDL_Joystick ptr, byval ball as integer, byval dx as integer ptr, byval dy as integer ptr) as integer
declare function SDL_JoystickGetButton cdecl alias "SDL_JoystickGetButton" (byval joystick as SDL_Joystick ptr, byval button as integer) as Uint8
declare sub SDL_JoystickClose cdecl alias "SDL_JoystickClose" (byval joystick as SDL_Joystick ptr)

#include once "close_code.bi"

#endif
