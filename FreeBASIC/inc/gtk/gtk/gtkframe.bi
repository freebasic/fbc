''
''
'' gtkframe -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkframe_bi__
#define __gtkframe_bi__

#include once "gtk/gdk.bi"
#include once "gtk/gtk/gtkbin.bi"

type GtkFrame as _GtkFrame
type GtkFrameClass as _GtkFrameClass

type _GtkFrame
	bin as GtkBin
	label_widget as GtkWidget ptr
	shadow_type as gint16
	label_xalign as gfloat
	label_yalign as gfloat
	child_allocation as GtkAllocation
end type

type _GtkFrameClass
	parent_class as GtkBinClass
	compute_child_allocation as sub cdecl(byval as GtkFrame ptr, byval as GtkAllocation ptr)
end type

declare function gtk_frame_get_type cdecl alias "gtk_frame_get_type" () as GType
declare function gtk_frame_new cdecl alias "gtk_frame_new" (byval label as gchar ptr) as GtkWidget ptr
declare sub gtk_frame_set_label cdecl alias "gtk_frame_set_label" (byval frame as GtkFrame ptr, byval label as gchar ptr)
declare function gtk_frame_get_label cdecl alias "gtk_frame_get_label" (byval frame as GtkFrame ptr) as gchar ptr
declare sub gtk_frame_set_label_widget cdecl alias "gtk_frame_set_label_widget" (byval frame as GtkFrame ptr, byval label_widget as GtkWidget ptr)
declare function gtk_frame_get_label_widget cdecl alias "gtk_frame_get_label_widget" (byval frame as GtkFrame ptr) as GtkWidget ptr
declare sub gtk_frame_set_label_align cdecl alias "gtk_frame_set_label_align" (byval frame as GtkFrame ptr, byval xalign as gfloat, byval yalign as gfloat)
declare sub gtk_frame_get_label_align cdecl alias "gtk_frame_get_label_align" (byval frame as GtkFrame ptr, byval xalign as gfloat ptr, byval yalign as gfloat ptr)
declare sub gtk_frame_set_shadow_type cdecl alias "gtk_frame_set_shadow_type" (byval frame as GtkFrame ptr, byval type as GtkShadowType)
declare function gtk_frame_get_shadow_type cdecl alias "gtk_frame_get_shadow_type" (byval frame as GtkFrame ptr) as GtkShadowType

#endif
