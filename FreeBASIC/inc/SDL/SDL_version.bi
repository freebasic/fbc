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

#define SDL_VERSION_(X) X->major = SDL_MAJOR_VERSION : X->minor = SDL_MINOR_VERSION : X->patch = SDL_PATCHLEVEL

#define SDL_VERSIONNUM(X,Y,Z) ((X) * 1000 + (Y) * 100 + (Z))

#define SDL_COMPILEDVERSION SDL_VERSIONNUM(SDL_MAJOR_VERSION, SDL_MINOR_VERSION, SDL_PATCHLEVEL)

#define SDL_VERSION_ATLEAST(X,Y,Z) (SDL_COMPILEDVERSION >= SDL_VERSIONNUM(X, Y, Z))

declare function SDL_Linked_Version SDLCALL alias "SDL_Linked_Version" _
   () as SDL_Version ptr
  
'$include: 'SDL/close_code.bi'

#endif