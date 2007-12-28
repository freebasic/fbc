''
''
'' SDL_byteorder -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __SDL_byteorder_bi__
#define __SDL_byteorder_bi__

#define SDL_LIL_ENDIAN 1234
#define SDL_BIG_ENDIAN 4321

#if defined(__FB_WIN32__) or defined(__FB_LINUX__)
#define SDL_BYTEORDER SDL_LIL_ENDIAN
#else
#define SDL_BYTEORDER SDL_BIG_ENDIAN
#endif

#endif
