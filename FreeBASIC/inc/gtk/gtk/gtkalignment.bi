''
''
'' gtkalignment -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkalignment_bi__
#define __gtkalignment_bi__

#include once "gtk/gdk.bi"
#include once "gtk/gtk/gtkbin.bi"

type GtkAlignment as _GtkAlignment
type GtkAlignmentClass as _GtkAlignmentClass
type GtkAlignmentPrivate as _GtkAlignmentPrivate

type _GtkAlignment
	bin as GtkBin
	xalign as gfloat
	yalign as gfloat
	xscale as gfloat
	yscale as gfloat
end type

type _GtkAlignmentClass
	parent_class as GtkBinClass
end type

declare function gtk_alignment_get_type cdecl alias "gtk_alignment_get_type" () as GType
declare function gtk_alignment_new cdecl alias "gtk_alignment_new" (byval xalign as gfloat, byval yalign as gfloat, byval xscale as gfloat, byval yscale as gfloat) as GtkWidget ptr
declare sub gtk_alignment_set cdecl alias "gtk_alignment_set" (byval alignment as GtkAlignment ptr, byval xalign as gfloat, byval yalign as gfloat, byval xscale as gfloat, byval yscale as gfloat)
declare sub gtk_alignment_set_padding cdecl alias "gtk_alignment_set_padding" (byval alignment as GtkAlignment ptr, byval padding_top as guint, byval padding_bottom as guint, byval padding_left as guint, byval padding_right as guint)
declare sub gtk_alignment_get_padding cdecl alias "gtk_alignment_get_padding" (byval alignment as GtkAlignment ptr, byval padding_top as guint ptr, byval padding_bottom as guint ptr, byval padding_left as guint ptr, byval padding_right as guint ptr)

#endif
