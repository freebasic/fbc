''
''
'' MyMem -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __CUnit_MyMem_bi__
#define __CUnit_MyMem_bi__

#ifdef MEMTRACE
declare function CU_calloc_ cdecl alias "CU_calloc" (byval nmemb as size_t, byval size as size_t, byval uiLine as uinteger, byval szFileName as zstring ptr) as any ptr
declare function CU_malloc_ cdecl alias "CU_malloc" (byval size as size_t, byval uiLine as uinteger, byval szFileName as zstring ptr) as any ptr
declare sub CU_free_ cdecl alias "CU_free" (byval ptr as any ptr, byval uiLine as uinteger, byval szFileName as zstring ptr)
declare function CU_realloc_ cdecl alias "CU_realloc" (byval ptr as any ptr, byval size as size_t, byval uiLine as uinteger, byval szFileName as zstring ptr) as any ptr
declare sub CU_dump_memory_usage_ cdecl alias "CU_dump_memory_usage" (byval as zstring ptr)

# define CU_CALLOC(x, y) CU_calloc_((x), (y), __LINE__, __FILE__)
# define CU_MALLOC(x) CU_malloc_((x), __LINE__, __FILE__)
# define CU_FREE(x) CU_free_((x), __LINE__, __FILE__)
# define CU_REALLOC(x, y) CU_realloc_((x), (y), __LINE__, __FILE__)
# define CU_CREATE_MEMORY_REPORT(x) CU_dump_memory_usage_((x))
# define CU_DUMP_MEMORY_USAGE(x) CU_dump_memory_usage_((x))

#else
# define CU_CALLOC(x, y) callocate((x), (y))
# define CU_MALLOC(x) allocate((x))
# define CU_FREE(x) deallocate((x))
# define CU_REALLOC(x, y) reallocate((x), (y))
# define CU_CREATE_MEMORY_REPORT(x)
# define CU_DUMP_MEMORY_USAGE(x)
#endif

#endif
