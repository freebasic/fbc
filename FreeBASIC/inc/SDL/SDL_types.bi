''
''
'' SDL_types -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __SDL_types_bi__
#define __SDL_types_bi__

#define SDL_TABLESIZE(table) (ubound(table) - lbound(table) + 1)

enum SDL_bool
	SDL_FALSE = 0
	SDL_TRUE = 1
end enum

type Uint8 as ubyte
type Sint8 as byte
type Uint16 as ushort
type Sint16 as short
type Uint32 as uinteger
type Sint32 as integer
type Uint64 as ulongint
type Sint64 as longint

enum SDL_DUMMY_ENUM
	DUMMY_ENUM_VALUE
end enum


enum 
	SDL_PRESSED = &h01
	SDL_RELEASED = &h00
end enum

#endif
