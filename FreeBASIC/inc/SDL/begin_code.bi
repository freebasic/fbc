' begin_code.h header ported to freeBasic by Edmond Leung (leung.edmond@gmail.com)

'$inclib: "SDL"

#ifdef begin_code_bi_
#print "Nested inclusion of begin_code.bi"
#endif
#define begin_code_bi_

#ifndef SDLCALL
#ifdef FB__WIN32
#define SDLCALL cdecl
#else
#define SDLCALL
#endif
#endif

#ifndef NULL
#define NULL 0
#endif