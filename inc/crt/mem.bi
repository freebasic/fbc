#pragma once

#include once "crt/stddef.bi"

extern "C"

declare function memchr (byval as const any ptr, byval as long, byval as size_t) as any ptr
declare function memcmp (byval as const any ptr, byval as const any ptr, byval as size_t) as long
declare function memcpy (byval as any ptr, byval as const any ptr, byval as size_t) as any ptr
declare function memmove (byval as any ptr, byval as const any ptr, byval as size_t) as any ptr
declare function memset (byval as any ptr, byval as long, byval as size_t) as any ptr

end extern
