' SDL_error.h header ported to freeBasic by Edmond Leung (leung.edmond@gmail.com)

'$inclib: "SDL"

#ifndef SDL_error_bi_
#define SDL_error_bi_

'$include: 'SDL/begin_code.bi'

declare sub SDL_SetError SDLCALL alias "SDL_SetError" (byval errorMsg as string)
declare function SDL_GetError SDLCALL alias "SDL_GetError" () as byte ptr
declare sub SDL_ClearError SDLCALL alias "SDL_ClearError" ()

#define SDL_OutOfMemory() SDL_Error(SDL_ENONEM)
enum SDL_errorcode
   SDL_ENOMEM
   SDL_EFREAD
   SDL_EFWRITE
   SDL_EFSEEK
   SDL_LASTERROR
end enum
declare sub SDL_Error SDLCALL alias "SDL_Error" (byval code as SDL_errorcode)

'$include: 'SDL/close_code.bi'

#endif