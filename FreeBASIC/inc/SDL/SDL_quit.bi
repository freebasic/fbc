' SDL_quit.h header ported to freeBasic by Edmond Leung (leung.edmond@gmail.com)

'$inclib: "SDL"

#ifndef SDL_quit_bi_
#define SDL_quit_bi_

#define SDL_QuitRequested() _
   (SDL_PumpEvents(), SDL_PeepEvents(NULL, 0, SDL_PEEKEVENT, SDL_QUITMASK))

#endif