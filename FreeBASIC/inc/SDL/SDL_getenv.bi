' SDL_getenv.h header ported to freeBasic by Edmond Leung (leung.edmond@gmail.com)

'$inclib: "SDL"

#ifdef NEED_SDL_GETENV

'$include: 'SDL/begin_code.bi'

declare function SDL_putenv SDLCALL alias "SDL_putenv" _
   (byval variable as string) as integer

#define putenv(X) SDL_putenv(X)

declare function SDL_getenv SDLCALL alias "SDL_getenv" _
   (byval name as string) as zstring ptr

#define getenv(X) SDL_getenv(X)

'$include: 'SDL/close_code.bi'

#endif
