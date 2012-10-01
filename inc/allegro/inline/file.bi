''
''
'' allegro\file -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __allegro_inline_file_bi__
#define __allegro_inline_file_bi__

#include once "allegro/file.bi"

declare function pack_getc cdecl alias "pack_getc" (byval f as PACKFILE ptr) as integer
declare function pack_putc cdecl alias "pack_putc" (byval c as integer, byval f as PACKFILE ptr) as integer
declare function pack_feof cdecl alias "pack_feof" (byval f as PACKFILE ptr) as integer
declare function pack_ferror cdecl alias "pack_ferror" (byval f as PACKFILE ptr) as integer

#endif
