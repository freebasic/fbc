' SDL_endian.h header ported to freeBasic by Edmond Leung (leung.edmond@gmail.com)

'$inclib: "SDL"

#ifndef SDL_endian_bi
#define SDL_endian_bi

'$include: 'SDL/SDL_types.bi'
'$include: 'SDL/SDL_rwops.bi'
'$include: 'SDL/SDL_byteorder.bi'

'$include: 'SDL/begin_code.bi'

#define SDL_Swap16(x) (((x) SHL 8) or ((x) SHR 8))

#define SDL_Swap32(x) (((x) SHL 24) or (((x) SHL 8) and &h00ff0000) or (((x) SHR 8) and &h0000ff00) or ((x) SHR 24))

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

declare function SDL_ReadLE16 SDLCALL alias "SDL_ReadLE16" _
   (src as SDL_RWops ptr) as Uint16
declare function SDL_ReadBE16 SDLCALL alias "SDL_ReadBE16" _
   (src as SDL_RWops ptr) as Uint16
declare function SDL_ReadLE32 SDLCALL alias "SDL_ReadLE32" _
   (src as SDL_RWops ptr) as Uint32
declare function SDL_ReadBE32 SDLCALL alias "SDL_ReadBE32" _
   (src as SDL_RWops ptr) as Uint32

declare function SDL_WriteLE16 SDLCALL alias "SDL_WriteLE16" _
   (dst as SDL_RWops ptr, value as Uint16) as integer
declare function SDL_WriteBE16 SDLCALL alias "SDL_WriteBE16" _
   (dst as SDL_RWops ptr, value as Uint16) as integer
declare function SDL_WriteLE32 SDLCALL alias "SDL_WriteLE32" _
   (dst as SDL_RWops ptr, value as Uint32) as integer
declare function SDL_WriteBE32 SDLCALL alias "SDL_WriteBE32" _
   (dst as SDL_RWops ptr, value as Uint32) as integer

'$include: 'SDL/close_code.bi'

#endif