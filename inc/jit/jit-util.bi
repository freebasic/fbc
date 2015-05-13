''
''
'' jit-util -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __jit_util_bi__
#define __jit_util_bi__

#include "jit/jit-common.bi"

declare function jit_malloc cdecl alias "jit_malloc" (byval size as uinteger) as any ptr
declare function jit_calloc cdecl alias "jit_calloc" (byval num as uinteger, byval size as uinteger) as any ptr
declare function jit_realloc cdecl alias "jit_realloc" (byval ptr as any ptr, byval size as uinteger) as any ptr
declare sub jit_free cdecl alias "jit_free" (byval ptr as any ptr)
declare function jit_malloc_exec cdecl alias "jit_malloc_exec" (byval size as uinteger) as any ptr
declare sub jit_free_exec cdecl alias "jit_free_exec" (byval ptr as any ptr, byval size as uinteger)
declare sub jit_flush_exec cdecl alias "jit_flush_exec" (byval ptr as any ptr, byval size as uinteger)
declare function jit_exec_page_size cdecl alias "jit_exec_page_size" () as uinteger

#define	jit_new(_type)		(CPtr(_type ptr, jit_malloc(sizeof(_type))))
#define	jit_cnew(_type)		(CPtr(_type ptr, jit_calloc(1, sizeof(type))))

declare function jit_memset cdecl alias "jit_memset" (byval dest as any ptr, byval ch as integer, byval len as uinteger) as any ptr
declare function jit_memcpy cdecl alias "jit_memcpy" (byval dest as any ptr, byval src as any ptr, byval len as uinteger) as any ptr
declare function jit_memmove cdecl alias "jit_memmove" (byval dest as any ptr, byval src as any ptr, byval len as uinteger) as any ptr
declare function jit_memcmp cdecl alias "jit_memcmp" (byval s1 as any ptr, byval s2 as any ptr, byval len as uinteger) as integer
declare function jit_memchr cdecl alias "jit_memchr" (byval str as any ptr, byval ch as integer, byval len as uinteger) as any ptr
declare function jit_strlen cdecl alias "jit_strlen" (byval str as zstring ptr) as uinteger
declare function jit_strcpy cdecl alias "jit_strcpy" (byval dest as zstring ptr, byval src as zstring ptr) as zstring ptr
declare function jit_strcat cdecl alias "jit_strcat" (byval dest as zstring ptr, byval src as zstring ptr) as zstring ptr
declare function jit_strncpy cdecl alias "jit_strncpy" (byval dest as zstring ptr, byval src as zstring ptr, byval len as uinteger) as zstring ptr
declare function jit_strdup cdecl alias "jit_strdup" (byval str as zstring ptr) as zstring ptr
declare function jit_strndup cdecl alias "jit_strndup" (byval str as zstring ptr, byval len as uinteger) as zstring ptr
declare function jit_strcmp cdecl alias "jit_strcmp" (byval str1 as zstring ptr, byval str2 as zstring ptr) as integer
declare function jit_strncmp cdecl alias "jit_strncmp" (byval str1 as zstring ptr, byval str2 as zstring ptr, byval len as uinteger) as integer
declare function jit_stricmp cdecl alias "jit_stricmp" (byval str1 as zstring ptr, byval str2 as zstring ptr) as integer
declare function jit_strnicmp cdecl alias "jit_strnicmp" (byval str1 as zstring ptr, byval str2 as zstring ptr, byval len as uinteger) as integer
declare function jit_strchr cdecl alias "jit_strchr" (byval str as zstring ptr, byval ch as integer) as zstring ptr
declare function jit_strrchr cdecl alias "jit_strrchr" (byval str as zstring ptr, byval ch as integer) as zstring ptr
declare function jit_sprintf cdecl alias "jit_sprintf" (byval str as zstring ptr, byval format as zstring ptr, ...) as integer
declare function jit_snprintf cdecl alias "jit_snprintf" (byval str as zstring ptr, byval len as uinteger, byval format as zstring ptr, ...) as integer

#endif
