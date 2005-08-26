''
''
'' gtkaspectframe -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkaspectframe_bi__
#define __gtkaspectframe_bi__

#include once "gtk/gdk.bi"
#include once "gtk/gtk/gtkbin.bi"
#include once "gtk/gtk/gtkframe.bi"

type GtkAspectFrame as _GtkAspectFrame
type GtkAspectFrameClass as _GtkAspectFrameClass

type _GtkAspectFrame
	frame as GtkFrame
	xalign as gfloat
	yalign as gfloat
	ratio as gfloat
	obey_child as gboolean
	center_allocation as GtkAllocation
end type

type _GtkAspectFrameClass
	parent_class as GtkFrameClass
end type

declare function gtk_aspect_frame_get_type cdecl alias "gtk_aspect_frame_get_type" () as GType
declare function gtk_aspect_frame_new cdecl alias "gtk_aspect_frame_new" (byval label as zstring ptr, byval xalign as gfloat, byval yalign as gfloat, byval ratio as gfloat, byval obey_child as gboolean) as GtkWidget ptr
declare sub gtk_aspect_frame_set cdecl alias "gtk_aspect_frame_set" (byval aspect_frame as GtkAspectFrame ptr, byval xalign as gfloat, byval yalign as gfloat, byval ratio as gfloat, byval obey_child as gboolean)

#endif
