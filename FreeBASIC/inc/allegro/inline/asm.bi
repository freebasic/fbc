''
''
'' allegro\asm -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __allegro_inline_asm_bi__
#define __allegro_inline_asm_bi__

#ifndef ALLEGRO_NO_ASM
 #if defined(ALLEGRO_GCC) and defined(ALLEGRO_I386)
  #include once "allegro/platform/al386gcc.bi"
 #elseif defined(ALLEGRO_MSVC) and defined(ALLEGRO_I386)
  #include once "allegro/platform/al386vc.bi"
 #elseif defined(ALLEGRO_WATCOM) and defined(ALLEGRO_I386)
  #include once "allegro/platform/al386wat.bi"
 #else
  #define ALLEGRO_NO_ASM
 #endif
#endif

#endif