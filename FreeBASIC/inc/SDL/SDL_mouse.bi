' SDL_mouse.h header ported to freeBasic by Edmond Leung (leung.edmond@gmail.com)

'$inclib: "SDL"

#ifndef SDL_mouse_bi_
#define SDL_mouse_bi_

'$include: 'SDL/SDL_types.bi'
'$include: 'SDL/SDL_video.bi'

'$include: 'SDL/begin_code.bi'

#define WMcursor any
type SDL_Cursor
   area as SDL_Rect
   hot_x as Sint16
   hot_y as Sint16
   data as Uint8 ptr
   mask as Uint8 ptr
   save(1) as Uint8 ptr
   wm_cursor as WMcursor ptr
end type

declare function SDL_GetMouseState SDLCALL alias "SDL_GetMouseState" _
   (byval x as integer ptr, byval y as integer ptr) as Uint8

declare function SDL_GetRelativeMouseState SDLCALL _
   alias "SDL_GetRelativeMouseState" _
   (byval x as integer ptr, byval y as integer ptr) as Uint8

declare sub SDL_WarpMouse SDLCALL alias "SDL_WarpMouse" _
   (byval x as Uint16, byval y as Uint16)

declare function SDL_CreateCursor SDLCALL alias "SDL_CreateCursor" _
   (byval dat as Uint8 ptr, byval mask as Uint8 ptr, byval w as integer, _
   byval h as integer, byval hot_x as integer, byval hot_y as integer) _
   as SDL_Cursor ptr

declare function SDL_SetCursor SDLCALL alias "SDL_SetCursor" _
   (byval cursor as SDL_Cursor ptr) as any ptr

declare function SDL_GetCursor SDLCALL alias "SDL_GetCursor" () as SDL_Cursor ptr

declare sub SDL_FreeCursor SDLCALL alias "SDL_FreeCursor" _
   (byval cursor as SDL_Cursor ptr)

declare function SDL_ShowCursor SDLCALL alias "SDL_ShowCursor" _
   (byval toggle as integer) as integer
   
private function SDL_BUTTON (byval X as integer) as ubyte
   SDL_BUTTON = SDL_PRESSED SHL (X - 1)
end function

#define SDL_BUTTON_LEFT 1
#define SDL_BUTTON_MIDDLE 2
#define SDL_BUTTON_RIGHT 3
#define SDL_BUTTON_WHEELUP 4
#define SDL_BUTTON_WHEELDOWN 5
#define SDL_BUTTON_LMASK SDL_BUTTON(SDL_BUTTON_LEFT)
#define SDL_BUTTON_MMASK SDL_BUTTON(SDL_BUTTON_MIDDLE)
#define SDL_BUTTON_RMASK SDL_BUTTON(SDL_BUTTON_RIGHT)

'$include: 'SDL/close_code.bi'

#endif