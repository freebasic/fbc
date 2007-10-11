''
''
'' gstring -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gstring_bi__
#define __gstring_bi__

#include once "gtypes.bi"
#include once "gunicode.bi"
#include once "gutils.bi"

type GString as _GString
type GStringChunk as _GStringChunk

type _GString
	str as zstring ptr
	len as gsize
	allocated_len as gsize
end type

declare function g_string_chunk_new (byval size as gsize) as GStringChunk ptr
declare sub g_string_chunk_free (byval chunk as GStringChunk ptr)
declare function g_string_chunk_insert (byval chunk as GStringChunk ptr, byval string as zstring ptr) as zstring ptr
declare function g_string_chunk_insert_len (byval chunk as GStringChunk ptr, byval string as zstring ptr, byval len as gssize) as zstring ptr
declare function g_string_chunk_insert_const (byval chunk as GStringChunk ptr, byval string as zstring ptr) as zstring ptr
declare function g_string_new (byval init as zstring ptr) as GString ptr
declare function g_string_new_len (byval init as zstring ptr, byval len as gssize) as GString ptr
declare function g_string_sized_new (byval dfl_size as gsize) as GString ptr
declare function g_string_free (byval string as GString ptr, byval free_segment as gboolean) as zstring ptr
declare function g_string_equal (byval v as GString ptr, byval v2 as GString ptr) as gboolean
declare function g_string_hash (byval str as GString ptr) as guint
declare function g_string_assign (byval string as GString ptr, byval rval as zstring ptr) as GString ptr
declare function g_string_truncate (byval string as GString ptr, byval len as gsize) as GString ptr
declare function g_string_set_size (byval string as GString ptr, byval len as gsize) as GString ptr
declare function g_string_insert_len (byval string as GString ptr, byval pos as gssize, byval val as zstring ptr, byval len as gssize) as GString ptr
declare function g_string_append (byval string as GString ptr, byval val as zstring ptr) as GString ptr
declare function g_string_append_len (byval string as GString ptr, byval val as zstring ptr, byval len as gssize) as GString ptr
declare function g_string_append_c (byval string as GString ptr, byval c as gchar) as GString ptr
declare function g_string_append_unichar (byval string as GString ptr, byval wc as gunichar) as GString ptr
declare function g_string_prepend (byval string as GString ptr, byval val as zstring ptr) as GString ptr
declare function g_string_prepend_c (byval string as GString ptr, byval c as gchar) as GString ptr
declare function g_string_prepend_unichar (byval string as GString ptr, byval wc as gunichar) as GString ptr
declare function g_string_prepend_len (byval string as GString ptr, byval val as zstring ptr, byval len as gssize) as GString ptr
declare function g_string_insert (byval string as GString ptr, byval pos as gssize, byval val as zstring ptr) as GString ptr
declare function g_string_insert_c (byval string as GString ptr, byval pos as gssize, byval c as gchar) as GString ptr
declare function g_string_insert_unichar (byval string as GString ptr, byval pos as gssize, byval wc as gunichar) as GString ptr
declare function g_string_erase (byval string as GString ptr, byval pos as gssize, byval len as gssize) as GString ptr
declare function g_string_ascii_down (byval string as GString ptr) as GString ptr
declare function g_string_ascii_up (byval string as GString ptr) as GString ptr
declare sub g_string_printf (byval string as GString ptr, byval format as zstring ptr, ...)
declare sub g_string_append_printf (byval string as GString ptr, byval format as zstring ptr, ...)
declare function g_string_down (byval string as GString ptr) as GString ptr
declare function g_string_up (byval string as GString ptr) as GString ptr

#define	g_string_sprintf g_string_printf
#define	g_string_sprintfa g_string_append_printf

#endif
