''
''
'' gcompletion -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gcompletion_bi__
#define __gcompletion_bi__

#include once "glist.bi"

type GCompletion as _GCompletion
type GCompletionFunc as function cdecl(byval as gpointer) as gchar
type GCompletionStrncmpFunc as function cdecl(byval as zstring ptr, byval as zstring ptr, byval as gsize) as gint

type _GCompletion
	items as GList ptr
	func as GCompletionFunc
	prefix as zstring ptr
	cache as GList ptr
	strncmp_func as GCompletionStrncmpFunc
end type

declare function g_completion_new (byval func as GCompletionFunc) as GCompletion ptr
declare sub g_completion_add_items (byval cmp as GCompletion ptr, byval items as GList ptr)
declare sub g_completion_remove_items (byval cmp as GCompletion ptr, byval items as GList ptr)
declare sub g_completion_clear_items (byval cmp as GCompletion ptr)
declare function g_completion_complete (byval cmp as GCompletion ptr, byval prefix as zstring ptr, byval new_prefix as zstring ptr ptr) as GList ptr
declare function g_completion_complete_utf8 (byval cmp as GCompletion ptr, byval prefix as zstring ptr, byval new_prefix as zstring ptr ptr) as GList ptr
declare sub g_completion_set_compare (byval cmp as GCompletion ptr, byval strncmp_func as GCompletionStrncmpFunc)
declare sub g_completion_free (byval cmp as GCompletion ptr)

#endif
