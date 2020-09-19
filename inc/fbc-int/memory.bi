#ifndef __FBC_INT_MEMORY_BI__ 
#define __FBC_INT_MEMORY_BI__

# if __FB_LANG__ = "qb"
# error not supported in qb dialect
# endif

'' WARNING!!! EXPERIMENTAL
''
''   1) redefine the builtin low level memory operations in a namespace
''      - currently not possible for allocate / deallocate, see below
''
''   2) alternate definition of fb.clear, fb.memmove, fb.memcopy, fb.copyclear
''      - built-in as defined by the compiler prefers BYREF parameters for source and destination
''        to be more aligned with already long existing CLEAR statemnt
''      - this header file uses BYVAL AS ANY PTR parameters to be more aligned with actual rtlib
''        definitions and use of pointers
'' 


'' undefine the memory operations so we can attempt a source only definition (no tricky fbc built-in magic)

#undef clear
#undef allocate
#undef callocate
#undef reallocate
#undef deallocate
#undef fb_MemCopy
#undef fb_MemMove
#undef fb_MemCopyClear

'' must have declaration of "..allocate()" and "..deallocate()"
'' new, new[], delete, delete[] can't work without these exact names
extern "C"
	declare function allocate cdecl alias "malloc" ( byval size as const uinteger ) as any ptr
	declare sub deallocate cdecl alias "free" ( byval p as const any ptr )
end extern

namespace FBC

extern "rtlib"
	declare function allocate cdecl alias "malloc" ( byval size as const uinteger ) as any ptr
	declare function callocate cdecl alias "calloc" ( byval items as const uinteger, byval size as const uinteger = 1 ) as any ptr
	declare function reallocate cdecl alias "realloc" ( byval p as const any ptr, byval size as const uinteger ) as any ptr
	declare sub deallocate cdecl alias "free" ( byval p as const any ptr )

	'' Note differences in the declarations fbc versus implementation:
	'' fbc's 'clear', 'fb_MemMove', 'fb_MemCopy', "fb_MemCopyClear", are declared to take
	'' 'byref as any' parameters for dst/src.
	'' - fbc declares the functions to the user as 'byref as any'
	'' - the underlying implementation is a 'byval as any ptr' (char* to be exact)
	''
	'' from ./src/compiler/rtl-mem.bas:
	'' declare function clear cdecl alias "memset" ( byref dst as any, byval value as const long = 0, byval size as const uinteger ) as any ptr
	'' declare function fb_MemMove cdecl alias "memmove" ( byref dst as any, byref src as const any, byval size as const uinteger ) as any ptr
	'' declare function fb_MemCopy cdecl alias "memcpy" ( byref dst as any, byref src as const any, byval size as const uinteger ) as any ptr
	'' declare sub fb_MemCopyClear alias "fb_MemCopyClear" ( byref dst as any, byval dstlen as const uinteger, byref src as const any, byval srclen as const uinteger )

	declare function clear cdecl alias "memset" ( byval dst as any ptr, byval value as const long = 0, byval size as const uinteger ) as any ptr
	declare function memmove cdecl alias "memmove" ( byval dst as any ptr, byval src as const any ptr, byval size as const uinteger ) as any ptr
	declare function memcopy cdecl alias "memcpy" ( byval dst as any ptr, byval src as const any ptr, byval size as const uinteger ) as any ptr
	declare sub copyclear alias "fb_MemCopyClear" ( byval dst as any ptr, byval dstlen as const uinteger, byval src as const any ptr, byval srclen as const uinteger )

end extern

end namespace

#endif
