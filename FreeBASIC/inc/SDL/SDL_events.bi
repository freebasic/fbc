' SDL_events.h header ported to freeBasic by Edmond Leung (leung.edmond@gmail.com)

'$inclib: "SDL"

#ifndef SDL_events_bi_
#define SDL_events_bi_

'$include: 'SDL/SDL_types.bi'
'$include: 'SDL/SDL_active.bi'
'$include: 'SDL/SDL_keyboard.bi'
'$include: 'SDL/SDL_mouse.bi'
'$include: 'SDL/SDL_joystick.bi'
'$include: 'SDL/SDL_quit.bi'

'$include: 'SDL/begin_code.bi'

enum events
   SDL_NOEVENT = 0
   SDL_ACTIVEEVENT
   SDL_KEYDOWN
   SDL_KEYUP
   SDL_MOUSEMOTION
   SDL_MOUSEBUTTONDOWN
   SDL_MOUSEBUTTONUP
   SDL_JOYAXISMOTION
   SDL_JOYBALLMOTION
   SDL_JOYHATMOTION
   SDL_JOYBUTTONDOWN
   SDL_JOYBUTTONUP
   SDL_QUIT_
   SDL_EXIT = SDL_QUIT_
   SDL_SYSWMEVENT
   SDL_EVENT_RESERVEDA
   SDL_EVENT_RESERVEDB
   SDL_VIDEORESIZE
   SDL_VIDEOEXPOSE
   SDL_EVENT_RESERVED2
   SDL_EVENT_RESERVED3
   SDL_EVENT_RESERVED4
   SDL_EVENT_RESERVED5
   SDL_EVENT_RESERVED6
   SDL_EVENT_RESERVED7

   SDL_USEREVENT = 24

   SDL_NUMEVENTS = 32
end enum

#define SDL_EVENTMASK(X) (1 SHL (X))

enum eventmasks
   SDL_ACTIVEEVENTMASK = 1 SHL SDL_ACTIVEEVENT
	SDL_KEYDOWNMASK = 1 SHL SDL_KEYDOWN
	SDL_KEYUPMASK = 1 SHL SDL_KEYUP
	SDL_MOUSEMOTIONMASK = 1 SHL SDL_MOUSEMOTION
	SDL_MOUSEBUTTONDOWNMASK	= 1 SHL SDL_MOUSEBUTTONDOWN
	SDL_MOUSEBUTTONUPMASK = 1 SHL SDL_MOUSEBUTTONUP
	SDL_MOUSEEVENTMASK = 1 SHL SDL_MOUSEMOTION or _
      1 SHL SDL_MOUSEBUTTONDOWN or _
      1 SHL SDL_MOUSEBUTTONUP
	SDL_JOYAXISMOTIONMASK = 1 SHL SDL_JOYAXISMOTION
	SDL_JOYBALLMOTIONMASK = 1 SHL SDL_JOYBALLMOTION
	SDL_JOYHATMOTIONMASK	= 1 SHL SDL_JOYHATMOTION
	SDL_JOYBUTTONDOWNMASK = 1 SHL SDL_JOYBUTTONDOWN
	SDL_JOYBUTTONUPMASK = 1 SHL SDL_JOYBUTTONUP
	SDL_JOYEVENTMASK = 1 SHL SDL_JOYAXISMOTION or _
      1 SHL SDL_JOYBALLMOTION or _
      1 SHL SDL_JOYHATMOTION or _
      1 SHL SDL_JOYBUTTONDOWN or _
      1 SHL SDL_JOYBUTTONUP
	SDL_VIDEORESIZEMASK = 1 SHL SDL_VIDEORESIZE
	SDL_VIDEOEXPOSEMASK = 1 SHL SDL_VIDEOEXPOSE
	SDL_QUITMASK = 1 SHL SDL_QUIT_
	SDL_SYSWMEVENTMASK = 1 SHL SDL_SYSWMEVENT
end enum
#define SDL_ALLEVENTS &hffffffff

type SDL_ActiveEvent
   type as Uint8
   gain as Uint8
   state as Uint8
end type

type SDL_KeyboardEvent
   type as Uint8
   which as Uint8
   state as Uint8
   keysym as SDL_keysym
end type

type SDL_MouseMotionEvent
   type as Uint8
   which as Uint8
   state as Uint8
   x as Uint16
   y as Uint16
   xrel as Sint16
   yrel as Sint16
end type

type SDL_MouseButtonEvent
   type as Uint8
   which as Uint8
   button as Uint8
   state as Uint8
   x as Uint16
   y as Uint16
end type

type SDL_JoyAxisEvent
   type as Uint8
   which as Uint8
   axis as Uint8
   value as Sint16
end type

type SDL_JoyBallEvent
   type as Uint8
   which as Uint8
   ball as Uint8
   xrel as Sint16
   yrel as Sint16
end type

type SDL_JoyHatEvent
   type as Uint8
   which as Uint8
   hat as Uint8
   value as Uint8   
end type

type SDL_JoyButtonEvent
   type as Uint8
   which as Uint8
   button as Uint8
   state as Uint8
end type

type SDL_ResizeEvent
   type as Uint8
   w as integer
   h as integer
end type

type SDL_ExposeEvent
   type as Uint8
end type

type SDL_QuitEvent
   type as Uint8
end type

type SDL_UserEvent
   type as Uint8
   cost as integer
   data1 as any ptr
   data2 as any ptr
end type

#ifndef SDL_syswm_bi_
#define SDL_SysWMmsg any
#endif
type SDL_SysWMEvent
   type as Uint8
   msg as SDL_SysWMmsg ptr
end type

union SDL_Event
   type as Uint8
   active as SDL_ActiveEvent
   key as SDL_KeyboardEvent
   motion as SDL_MouseMotionEvent
   button as SDL_MouseButtonEvent
   jaxis as SDL_JoyAxisEvent
   jball as SDL_JoyBallEvent
   jhat as SDL_JoyHatEvent
   jbutton as SDL_JoyButtonEvent
   resize as SDL_ResizeEvent
   expose as SDL_ExposeEvent
   quit as SDL_QuitEvent
   user as SDL_UserEvent
   syswm as SDL_SysWMEvent
end union

declare sub SDL_PumpEvents SDLCALL alias "SDL_PumpEvents" ()

enum SDL_eventaction
   SDL_ADDEVENT
   SDL_PEEKEVENT
   SDL_GETEVENT
end enum
declare function SDL_PeepEvents SDLCALL alias "SDL_PeepEvents" _
   (byval events as SDL_Event ptr, byval numevents as integer, _
   byval action as SDL_eventaction, byval mask as Uint32) as integer

declare function SDL_PollEvent SDLCALL alias "SDL_PollEvent" _
   (byval event as SDL_Event ptr) as integer

declare function SDL_WaitEvent SDLCALL alias "SDL_WaitEvent" _
   (byval event as SDL_Event ptr) as integer

declare function SDL_PushEvent SDLCALL alias "SDL_PushEvent" _
   (byval event as SDL_Event ptr) as integer

#define SDL_EventFilter function SDLCALL _
   (byval event as SDL_Event ptr) as integer

declare sub SDL_SetEventFilter SDLCALL alias "SDL_SetEventFilter" _
   (byval filter as SDL_EventFilter)

declare function SDL_GetEventFilter SDLCALL alias "SDL_GetEventFilter" _
   () as SDL_EventFilter
   
#define SDL_QUERY	-1
#define SDL_IGNORE 0
#define SDL_DISABLE 0
#define SDL_ENABLE 1
declare function SDL_EventState SDLCALL alias "SDL_EventState" _
   (byval typ as Uint8, byval state as integer) as Uint8

'$include: 'SDL/close_code.bi'

#endif
