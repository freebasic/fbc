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
#include once "gtkbin.bi"
#include once "gtkframe.bi"

#define GTK_TYPE_ASPECT_FRAME (gtk_aspect_frame_get_type ())
#define GTK_ASPECT_FRAME(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_ASPECT_FRAME, GtkAspectFrame))
#define GTK_ASPECT_FRAME_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_ASPECT_FRAME, GtkAspectFrameClass))
#define GTK_IS_ASPECT_FRAME(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_ASPECT_FRAME))
#define GTK_IS_ASPECT_FRAME_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_ASPECT_FRAME))
#define GTK_ASPECT_FRAME_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_ASPECT_FRAME, GtkAspectFrameClass))

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

declare function gtk_aspect_frame_get_type () as GType
declare function gtk_aspect_frame_new (byval label as zstring ptr, byval xalign as gfloat, byval yalign as gfloat, byval ratio as gfloat, byval obey_child as gboolean) as GtkWidget ptr
declare sub gtk_aspect_frame_set (byval aspect_frame as GtkAspectFrame ptr, byval xalign as gfloat, byval yalign as gfloat, byval ratio as gfloat, byval obey_child as gboolean)

#endif
