' SDL_getenv.h header ported to freeBasic by Edmond Leung (leung.edmond@gmail.com)

'$inclib: "SDL"

#ifdef NEED_SDL_GETENV

'$include: 'SDL/begin_code.bi'

declare function SDL_putenv SDLCALL alias "SDL_putenv" _
   (byval variable as string) as integer
private function putenv (byref X as string) as integer
   putenv = SDL_putenv(X)
end function

declare function SDL_getenv SDLCALL alias "SDL_getenv" _
   (byval name as string) as byte ptr
private function getenv (byref X as string) as byte ptr
   getenv = SDL_getenv(X)
end function

'$include: 'SDL/close_code.bi'

#endif
