''
''
'' gmem -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gmem_bi__
#define __gmem_bi__

#include once "gtypes.bi"

type GAllocator as _GAllocator
type GMemChunk as _GMemChunk
type GMemVTable as _GMemVTable

#define G_MEM_ALIGN 4

declare function g_malloc (byval n_bytes as gulong) as gpointer
declare function g_malloc0 (byval n_bytes as gulong) as gpointer
declare function g_realloc (byval mem as gpointer, byval n_bytes as gulong) as gpointer
declare sub g_free (byval mem as gpointer)
declare function g_try_malloc (byval n_bytes as gulong) as gpointer
declare function g_try_realloc (byval mem as gpointer, byval n_bytes as gulong) as gpointer

type _GMemVTable
	malloc as function cdecl(byval as gsize) as gpointer
	realloc as function cdecl(byval as gpointer, byval as gsize) as gpointer
	free as sub cdecl(byval as gpointer)
	calloc as function cdecl(byval as gsize, byval as gsize) as gpointer
	try_malloc as function cdecl(byval as gsize) as gpointer
	try_realloc as function cdecl(byval as gpointer, byval as gsize) as gpointer
end type

declare sub g_mem_set_vtable (byval vtable as GMemVTable ptr)
declare function g_mem_is_system_malloc () as gboolean
declare sub g_mem_profile ()

#define G_ALLOC_ONLY 1
#define G_ALLOC_AND_FREE 2

declare function g_mem_chunk_new (byval name as zstring ptr, byval atom_size as gint, byval area_size as gulong, byval type as gint) as GMemChunk ptr
declare sub g_mem_chunk_destroy (byval mem_chunk as GMemChunk ptr)
declare function g_mem_chunk_alloc (byval mem_chunk as GMemChunk ptr) as gpointer
declare function g_mem_chunk_alloc0 (byval mem_chunk as GMemChunk ptr) as gpointer
declare sub g_mem_chunk_free (byval mem_chunk as GMemChunk ptr, byval mem as gpointer)
declare sub g_mem_chunk_clean (byval mem_chunk as GMemChunk ptr)
declare sub g_mem_chunk_reset (byval mem_chunk as GMemChunk ptr)
declare sub g_mem_chunk_print (byval mem_chunk as GMemChunk ptr)
declare sub g_mem_chunk_info ()
declare sub g_blow_chunks ()
declare function g_allocator_new (byval name as zstring ptr, byval n_preallocs as guint) as GAllocator ptr
declare sub g_allocator_free (byval allocator as GAllocator ptr)

#define G_ALLOCATOR_LIST (1)
#define G_ALLOCATOR_SLIST (2)
#define G_ALLOCATOR_NODE (3)

#endif
