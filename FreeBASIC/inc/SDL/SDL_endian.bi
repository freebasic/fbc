' SDL_endian.h header ported to freeBasic by Edmond Leung (leung.edmond@gmail.com)

'$inclib: "SDL"

#ifndef SDL_endian_bi
#define SDL_endian_bi

'$include: 'SDL/SDL_types.bi'
'$include: 'SDL/SDL_rwops.bi'
'$include: 'SDL/SDL_byteorder.bi'

'$include: 'SDL/begin_code.bi'

private function SDL_Swap16 (byval x as Uint16) as Uint16
   SDL_Swap16 = (x SHL 8) or (x SHR 8)
end function

private function SDL_Swap32 (byval x as Uint32) as Uint32
   SDL_Swap32 = (x SHL 24) or ((x SHL 8) and &h00ff0000) or ((x SHR 8) and _
      &h0000ff00) or (x SHR 24)
end function

#if SDL_BYTEORDER = SDL_LIL_ENDIAN
private function SDL_SwapLE16 (byval X as Uint16) as Uint16
   SDL_SwapLE16 = X
end function
private function SDL_SwapLE32 (byval X as Uint32) as Uint32
   SDL_SwapLE32 = X
end function
private function SDL_SwapBE16 (byval X as Uint16) as Uint16
   SDL_SwapBE16 = SDL_Swap16(X)
end function
private function SDL_SwapBE32 (byval X as Uint32) as Uint32
   SDL_SwapBE32 = SDL_Swap32(X)
end function
#else
private function SDL_SwapLE16 (byval X as Uint16) as Uint16
   SDL_SwapLE16 = SDL_Swap16(X)
end function
private function SDL_SwapLE32 (byval X as Uint32) as Uint32
   SDL_SwapLE32 = SDL_Swap32(X)
end function
private function SDL_SwapBE16 (byval X as Uint16) as Uint16
   SDL_SwapBE16 = X
end function
private function SDL_SwapBE32 (byval X as Uint32) as Uint32
   SDL_SwapBE32 = X
end function
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