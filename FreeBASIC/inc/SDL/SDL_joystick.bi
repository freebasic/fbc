' SDL_joystick.h header ported to freeBasic by Edmond Leung (leung.edmond@gmail.com)

'$inclib: "SDL"

#ifndef SDL_joystick_bi_
#define SDL_joystick_bi_

'$include: 'SDL/SDL_types.bi'

'$include: 'SDL/begin_code.bi'

#define SDL_Joystick any

declare function SDL_NumJoySticks SDLCALL alias "SDL_NumJoySticks" () as integer

declare function SDL_JoystickName SDLCALL alias "SDL_JoyStickName" _
   (byval device_index as integer) as zstring ptr

declare function SDL_JoystickOpen SDLCALL alias "SDL_JoystickOpen" _
   (byval device_index as integer) as SDL_Joystick ptr

declare function SDL_JoystickOpened SDLCALL alias "SDL_JoystickOpened" _
   (byval device_index as integer) as integer

declare function SDL_JoystickIndex SDLCALL alias "SDL_JoystickIndex" _
   (byval joystick as SDL_Joystick ptr) as integer

declare function SDL_JoystickNumAxes SDLCALL alias "SDL_JoystickNumAxes" _
   (byval joystick as SDL_Joystick ptr) as integer

declare function SDL_JoystickNumBalls SDLCALL alias "SDL_JoystickNumBalls" _
   (byval joystick as SDL_Joystick ptr) as integer

declare function SDL_JoystickNumHats SDLCALL alias "SDL_JoystickNumHats" _
   (byval joystick as SDL_Joystick ptr) as integer

declare function SDL_JoystickNumButtons SDLCALL alias "SDL_JoystickNumButtons" _
   (byval joystick as SDL_Joystick ptr) as integer

declare sub SDL_JoystickUpdate SDLCALL alias "SDL_JoystickUpdate" ()

declare function SDL_JoystickEventState SDLCALL alias "SDL_JoystickEventState" _
   (byval state as integer) as integer

declare function SDL_JoystickGetAxis SDLCALL alias "SDL_JoystickGetAxis" _
   (byval joystick as SDL_Joystick ptr, byval axis as integer) as Sint16

#define SDL_HAT_CENTERED &h00
#define SDL_HAT_UP &h01
#define SDL_HAT_RIGHT &h02
#define SDL_HAT_DOWN &h04
#define SDL_HAT_LEFT &h08
#define SDL_HAT_RIGHTUP (SDL_HAT_RIGHT or SDL_HAT_UP)
#define SDL_HAT_RIGHTDOWN (SDL_HAT_RIGHT or SDL_HAT_DOWN)
#define SDL_HAT_LEFTUP (SDL_HAT_LEFT or SDL_HAT_UP)
#define SDL_HAT_LEFTDOWN (SDL_HAT_LEFT or SDL_HAT_DOWN)

declare function SDL_JoystickGetHat SDLCALL alias "SDL_JoystickGetHat" _
   (byval joystick as SDL_Joystick ptr, byval hat as integer) as Uint8

declare function SDL_JoystickGetBall SDLCALL alias "SDL_JoystickGetBall" _
   (byval joystick as SDL_Joystick ptr, byval ball as integer, _
   byval dx as integer ptr, byval dy as integer ptr) as integer

declare function SDL_JoystickGetButton SDLCALL alias "SDL_JoystickGetButton" _
   (byval joystick as SDL_Joystick ptr, byval button as integer) as Uint8

declare sub SDL_JoystickClose SDLCALL alias "SDL_JoystickClose" _
   (byval joystick as SDL_Joystick ptr)

'$include: 'SDL/close_code.bi'

#endif