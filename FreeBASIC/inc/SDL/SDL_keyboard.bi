' SDL_keyboard.h header ported to freeBasic by Edmond Leung (leung.edmond@gmail.com)

'$inclib: "SDL"

#ifndef SDL_keyboard_bi_
#define SDL_keyboard_bi_

'$include: 'SDL/SDL_types.bi'
'$include: 'SDL/SDL_keysym.bi'

'$include: 'SDL/begin_code.bi'

type SDL_keysym
   scancode as Uint8
   sym as SDLKey
   mod as SDLMod
   unicode as Uint16
end type

#define SDL_ALL_HOTKEYS &hffffffff

declare function SDL_EnableUNICODE SDLCALL alias "SDL_EnableUNICODE" _
   (byval enable as integer) as integer

#define SDL_DEFAULT_REPEAT_DELAY 500
#define SDL_DEFAULT_REPEAT_INTERVAL	30

declare function SDL_EnableKeyRepeat SDLCALL alias "SDL_EnableKeyRepeat" _
   (byval delay as integer, byval interval as integer) as integer

declare function SDL_GetKeyState SDLCALL alias "SDL_GetKeyState" _
   (byval numkeys as integer ptr) as Uint8 ptr

declare function SDL_GetModState SDLCALL alias "SDL_GetModState" () as SDLMod

declare sub SDL_SetModState SDLCALL alias "SDL_SetModState" _
   (byval modstate as SDLMod)

declare function SDL_GetKeyName SDLCALL alias "SDL_GetKeyName" _
   (byval key as SDLKey) as byte ptr

'$include: 'SDL/close_code.bi'

#endif