' SDL_types.h header ported to freeBasic by Edmond Leung (leung.edmond@gmail.com)

'$inclib: "sdl"

#ifndef SDL_types_bi_
#define SDL_types_bi_

#define SDL_TABLESIZE(table) (ubound(table) - lbound(table) + 1)

enum SDL_bool
   SDL_FALSE = 0
   SDL_TRUE = 1
end enum

#define Uint8 ubyte
#define Sint8 byte
#define Uint16 ushort
#define Sint16 short
#define Uint32 uinteger
#define Sint32 integer

enum inputstates
   SDL_PRESSED = &h01
   SDL_RELEASED = &h00
end enum

#endif