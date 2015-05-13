''
''
'' jit-init -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __jit_init_bi__
#define __jit_init_bi__

#include "jit/jit-defs.bi"

declare sub jit_init cdecl alias "jit_init" ()
declare function jit_uses_interpreter cdecl alias "jit_uses_interpreter" () as integer

#endif
