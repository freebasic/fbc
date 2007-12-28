''
''
'' SDL_endian -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __SDL_endian_bi__
#define __SDL_endian_bi__

#include once "crt/stdio.bi"
#include once "SDL_types.bi"
#include once "SDL_rwops.bi"
#include once "SDL_byteorder.bi"
#include once "begin_code.bi"

#define SDL_Swap16(x) (((x) shl 8) or ((x) shr 8))

#define SDL_Swap32(x) (((x) shl 24) or (((x) shl 8) and &h00ff0000) or (((x) shr 8) and &h0000ff00) or ((x) shr 24))

#if SDL_BYTEORDER = SDL_LIL_ENDIAN
#define SDL_SwapLE16(X) (X)
#define SDL_SwapLE32(X) (X)
#define SDL_SwapBE16(X) SDL_Swap16(X)
#define SDL_SwapBE32(X) SDL_Swap32(X)
#else
#define SDL_SwapLE16(X) SDL_Swap16(X)
#define SDL_SwapLE32(X) SDL_Swap32(X)
#define SDL_SwapBE16(X) (X)
#define SDL_SwapBE32(X) (X)
#endif

declare function SDL_ReadLE16 cdecl alias "SDL_ReadLE16" (byval src as SDL_RWops ptr) as Uint16
declare function SDL_ReadBE16 cdecl alias "SDL_ReadBE16" (byval src as SDL_RWops ptr) as Uint16
declare function SDL_ReadLE32 cdecl alias "SDL_ReadLE32" (byval src as SDL_RWops ptr) as Uint32
declare function SDL_ReadBE32 cdecl alias "SDL_ReadBE32" (byval src as SDL_RWops ptr) as Uint32
declare function SDL_ReadLE64 cdecl alias "SDL_ReadLE64" (byval src as SDL_RWops ptr) as Uint64
declare function SDL_ReadBE64 cdecl alias "SDL_ReadBE64" (byval src as SDL_RWops ptr) as Uint64
declare function SDL_WriteLE16 cdecl alias "SDL_WriteLE16" (byval dst as SDL_RWops ptr, byval value as Uint16) as integer
declare function SDL_WriteBE16 cdecl alias "SDL_WriteBE16" (byval dst as SDL_RWops ptr, byval value as Uint16) as integer
declare function SDL_WriteLE32 cdecl alias "SDL_WriteLE32" (byval dst as SDL_RWops ptr, byval value as Uint32) as integer
declare function SDL_WriteBE32 cdecl alias "SDL_WriteBE32" (byval dst as SDL_RWops ptr, byval value as Uint32) as integer
declare function SDL_WriteLE64 cdecl alias "SDL_WriteLE64" (byval dst as SDL_RWops ptr, byval value as Uint64) as integer
declare function SDL_WriteBE64 cdecl alias "SDL_WriteBE64" (byval dst as SDL_RWops ptr, byval value as Uint64) as integer

#include once "close_code.bi"

#endif
