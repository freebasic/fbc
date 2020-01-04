#ifndef __FBC_INT_MEMORY_BI__ 
#define __FBC_INT_MEMORY_BI__

# if __FB_LANG__ = "qb"
# error not supported in -lang qb dialect
# endif

'' redefine the builtin low level memory operations in a namespace

#undef clear
#undef allocate
#undef callocate
#undef reallocate
#undef deallocate
#undef fb_MemCopy
#undef fb_MemMove

# if __FB_LANG__ = "fb"
'' must have declaration of "..allocate()" and "..deallocate()"
'' new, new[], delete, delete[] can't work without them
extern "C"
	declare function allocate cdecl alias "malloc" ( byval size as const uinteger ) as any ptr
	declare sub deallocate cdecl alias "free" ( byval p as const any ptr )
end extern
# endif

# if __FB_LANG__ = "fb"
namespace FBC
# endif

extern "rtlib"
	declare function allocate cdecl alias "malloc" ( byval size as const uinteger ) as any ptr
	declare function callocate cdecl alias "calloc" ( byval items as const uinteger, byval size as const uinteger = 1 ) as any ptr
	declare function reallocate cdecl alias "realloc" ( byval p as const any ptr, byval size as const uinteger ) as any ptr
	declare sub deallocate cdecl alias "free" ( byval p as const any ptr )

	'' Note differences in the declarations fbc versus implementation:
	'' fbc's 'clear', 'fb_MemMove', 'fb_MemCopy', are declared to take
	'' 'byref as any' parameters for dst/src.
	'' - fbc declares the functions to the user as 'byref as any'
	'' - the underlying implementation is a 'byval as any ptr' (char* to be exact)
	''
	'' from ./src/compiler/rtl-mem.bas:
	'' declare function clear cdecl alias "memset" ( byref dst as any, byval value as const long = 0, byval size as const uinteger ) as any ptr
	'' declare function fb_MemMove cdecl alias "memmove" ( byref dst as any, byref src as const any, byval size as const uinteger ) as any ptr
	'' declare function fb_MemCopy cdecl alias "memcpy" ( byref dst as any, byref src as const any, byval size as const uinteger ) as any ptr
	''

	declare function clear cdecl alias "memset" ( byval dst as any ptr, byval value as const long = 0, byval size as const uinteger ) as any ptr
	declare function memmove cdecl alias "memmove" ( byval dst as any ptr, byval src as const any ptr, byval size as const uinteger ) as any ptr
	declare function memcopy cdecl alias "memcpy" ( byval dst as any ptr, byval src as const any ptr, byval size as const uinteger ) as any ptr
end extern

# if __FB_LANG__ = "fb"
end namespace
# endif

#endif
