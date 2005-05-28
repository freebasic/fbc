''
''
'' gtkimcontextsimple -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkimcontextsimple_bi__
#define __gtkimcontextsimple_bi__

#include once "gtk/gtk/gtkimcontext.bi"

type GtkIMContextSimple as _GtkIMContextSimple
type GtkIMContextSimpleClass as _GtkIMContextSimpleClass

#define GTK_MAX_COMPOSE_LEN 7

type _GtkIMContextSimple
	object as GtkIMContext
	tables as GSList ptr
	compose_buffer(0 to 7+1-1) as guint
	tentative_match as gunichar
	tentative_match_len as gint
	in_hex_sequence as guint
end type

type _GtkIMContextSimpleClass
	parent_class as GtkIMContextClass
end type

declare function gtk_im_context_simple_get_type cdecl alias "gtk_im_context_simple_get_type" () as GType
declare function gtk_im_context_simple_new cdecl alias "gtk_im_context_simple_new" () as GtkIMContext ptr
declare sub gtk_im_context_simple_add_table cdecl alias "gtk_im_context_simple_add_table" (byval context_simple as GtkIMContextSimple ptr, byval data as guint16 ptr, byval max_seq_len as gint, byval n_seqs as gint)

#endif
