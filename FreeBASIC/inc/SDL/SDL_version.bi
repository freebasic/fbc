' SDL_version.h header ported to freeBasic by Edmond Leung (leung.edmond@gmail.com)

'$inclib: "sdl"

#ifndef SDL_version_bi_
#define SDL_version_bi_

'$include: 'SDL/SDL_types.bi'

'$include: 'SDL/begin_code.bi'

#define SDL_MAJOR_VERSION 1
#define SDL_MINOR_VERSION 2
#define SDL_PATCHLEVEL 8

type SDL_version
   major as Uint8
   minor as Uint8
   patch as Uint8
end type

private sub SDL_VERSION (byval X as SDL_version ptr)
   X->major = SDL_MAJOR_VERSION
   X->minor = SDL_MINOR_VERSION
   X->patch = SDL_PATCHLEVEL
end sub

private function SDL_VERSIONNUM (byval X as Uint8, byval Y as Uint8, byval Z as Uint8) _
   as uinteger
   SDL_VERSIONNUM = X * 1000 + Y * 100 + Z
end function

#define SDL_COMPILEDVERSION _
   SDL_VERSIONNUM(SDL_MAJOR_VERSION, SDL_MINOR_VERSION, SDL_PATCHLEVEL)

private function SDL_VERSION_ATLEAST _
   (byval X as Uint8, byval Y as Uint8, byval Z as Uint8) as byte
   SDL_VERSION_ATLEAST = SDL_COMPILEDVERSION >= SDL_VERSIONNUM(X, Y, Z)
end function

declare function SDL_Linked_Version SDLCALL alias "SDL_Linked_Version" _
   () as SDL_Version ptr
  
'$include: 'SDL/close_code.bi'

#endif