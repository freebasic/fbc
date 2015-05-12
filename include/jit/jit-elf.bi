''
''
'' jit-elf -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __jit_elf_bi__
#define __jit_elf_bi__

#include "jit/jit-common.bi"

type jit_readelf_t as jit_readelf ptr
type jit_writeelf_t as jit_writeelf ptr

#define JIT_READELF_FLAG_FORCE (1 shl 0)
#define JIT_READELF_FLAG_DEBUG (1 shl 1)
#define JIT_READELF_OK 0
#define JIT_READELF_CANNOT_OPEN 1
#define JIT_READELF_NOT_ELF 2
#define JIT_READELF_WRONG_ARCH 3
#define JIT_READELF_BAD_FORMAT 4
#define JIT_READELF_MEMORY 5

declare function jit_readelf_open cdecl alias "jit_readelf_open" (byval readelf as jit_readelf_t ptr, byval filename as zstring ptr, byval flags as integer) as integer
declare sub jit_readelf_close cdecl alias "jit_readelf_close" (byval readelf as jit_readelf_t)
declare function jit_readelf_get_name cdecl alias "jit_readelf_get_name" (byval readelf as jit_readelf_t) as zstring ptr
declare function jit_readelf_get_symbol cdecl alias "jit_readelf_get_symbol" (byval readelf as jit_readelf_t, byval name as zstring ptr) as any ptr
declare function jit_readelf_get_section cdecl alias "jit_readelf_get_section" (byval readelf as jit_readelf_t, byval name as zstring ptr, byval size as jit_nuint ptr) as any ptr
declare function jit_readelf_get_section_by_type cdecl alias "jit_readelf_get_section_by_type" (byval readelf as jit_readelf_t, byval type as jit_int, byval size as jit_nuint ptr) as any ptr
declare function jit_readelf_map_vaddr cdecl alias "jit_readelf_map_vaddr" (byval readelf as jit_readelf_t, byval vaddr as jit_nuint) as any ptr
declare function jit_readelf_num_needed cdecl alias "jit_readelf_num_needed" (byval readelf as jit_readelf_t) as uinteger
declare function jit_readelf_get_needed cdecl alias "jit_readelf_get_needed" (byval readelf as jit_readelf_t, byval index as uinteger) as zstring ptr
declare sub jit_readelf_add_to_context cdecl alias "jit_readelf_add_to_context" (byval readelf as jit_readelf_t, byval context as jit_context_t)
declare function jit_readelf_resolve_all cdecl alias "jit_readelf_resolve_all" (byval context as jit_context_t, byval print_failures as integer) as integer
declare function jit_readelf_register_symbol cdecl alias "jit_readelf_register_symbol" (byval context as jit_context_t, byval name as zstring ptr, byval value as any ptr, byval after as integer) as integer
declare function jit_writeelf_create cdecl alias "jit_writeelf_create" (byval library_name as zstring ptr) as jit_writeelf_t
declare sub jit_writeelf_destroy cdecl alias "jit_writeelf_destroy" (byval writeelf as jit_writeelf_t)
declare function jit_writeelf_write cdecl alias "jit_writeelf_write" (byval writeelf as jit_writeelf_t, byval filename as zstring ptr) as integer
declare function jit_writeelf_add_function cdecl alias "jit_writeelf_add_function" (byval writeelf as jit_writeelf_t, byval func as jit_function_t, byval name as zstring ptr) as integer
declare function jit_writeelf_add_needed cdecl alias "jit_writeelf_add_needed" (byval writeelf as jit_writeelf_t, byval library_name as zstring ptr) as integer
declare function jit_writeelf_write_section cdecl alias "jit_writeelf_write_section" (byval writeelf as jit_writeelf_t, byval name as zstring ptr, byval type as jit_int, byval buf as any ptr, byval len as uinteger, byval discardable as integer) as integer

#endif
