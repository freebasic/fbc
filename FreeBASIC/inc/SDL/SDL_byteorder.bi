' SDL_byteorder.h header ported to freeBasic by Edmond Leung (leung.edmond@gmail.com)

'$inclib: "SDL"

#ifndef SDL_byteorder_bi_
#define SDL_byteorder_bi_

#define SDL_LIL_ENDIAN 1234
#define SDL_BIG_ENDIAN 4321

#if defined(FB__WIN32) or defined(FB__LINUX)
#define SDL_BYTEORDER SDL_LIL_ENDIAN
#else
#define SDL_BYTEORDER SDL_BIG_ENDIAN
#endif

#endif