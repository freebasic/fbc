''
''
'' allegro\platform\alplatf -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __allegro_platform_alplatf_bi__
#define __allegro_platform_alplatf_bi__

#if defined(__FB_WIN32__)
 #define ALLEGRO_MINGW32
#elseif defined(__FB_DOS__)
 #define ALLEGRO_DJGPP
#elseif defined(__FB_LINUX__)
 #define ALLEGRO_UNIX
 #define ALLEGRO_LINUX
#else
 #error Unsupported platform
#endif
#endif
