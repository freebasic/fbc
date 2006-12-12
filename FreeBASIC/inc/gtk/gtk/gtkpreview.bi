''
''
'' gtkpreview -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkpreview_bi__
#define __gtkpreview_bi__

#include once "gtkwidget.bi"

#define GTK_TYPE_PREVIEW (gtk_preview_get_type ())
#define GTK_PREVIEW(obj) (GTK_CHECK_CAST ((obj), GTK_TYPE_PREVIEW, GtkPreview))
#define GTK_PREVIEW_CLASS(klass) (GTK_CHECK_CLASS_CAST ((klass), GTK_TYPE_PREVIEW, GtkPreviewClass))
#define GTK_IS_PREVIEW(obj) (GTK_CHECK_TYPE ((obj), GTK_TYPE_PREVIEW))
#define GTK_IS_PREVIEW_CLASS(klass) (GTK_CHECK_CLASS_TYPE ((klass), GTK_TYPE_PREVIEW))
#define GTK_PREVIEW_GET_CLASS(obj) (GTK_CHECK_GET_CLASS ((obj), GTK_TYPE_PREVIEW, GtkPreviewClass))

type GtkPreview as _GtkPreview
type GtkPreviewInfo as _GtkPreviewInfo
type GtkDitherInfo as _GtkDitherInfo
type GtkPreviewClass as _GtkPreviewClass

type _GtkPreview
	widget as GtkWidget
	buffer as guchar ptr
	buffer_width as guint16
	buffer_height as guint16
	bpp as guint16
	rowstride as guint16
	dither as GdkRgbDither
	type:1 as guint
	expand:1 as guint
end type

type _GtkPreviewInfo
	lookup as guchar ptr
	gamma as gdouble
end type

union _GtkDitherInfo
	s(0 to 2-1) as gushort
	c(0 to 4-1) as guchar
end union

type _GtkPreviewClass
	parent_class as GtkWidgetClass
	info as GtkPreviewInfo
end type

declare function gtk_preview_get_type () as GtkType
declare sub gtk_preview_uninit ()
declare function gtk_preview_new (byval type as GtkPreviewType) as GtkWidget ptr
declare sub gtk_preview_size (byval preview as GtkPreview ptr, byval width as gint, byval height as gint)
declare sub gtk_preview_put (byval preview as GtkPreview ptr, byval window as GdkWindow ptr, byval gc as GdkGC ptr, byval srcx as gint, byval srcy as gint, byval destx as gint, byval desty as gint, byval width as gint, byval height as gint)
declare sub gtk_preview_draw_row (byval preview as GtkPreview ptr, byval data as guchar ptr, byval x as gint, byval y as gint, byval w as gint)
declare sub gtk_preview_set_expand (byval preview as GtkPreview ptr, byval expand as gboolean)
declare sub gtk_preview_set_gamma (byval gamma_ as double)
declare sub gtk_preview_set_color_cube (byval nred_shades as guint, byval ngreen_shades as guint, byval nblue_shades as guint, byval ngray_shades as guint)
declare sub gtk_preview_set_install_cmap (byval install_cmap as gint)
declare sub gtk_preview_set_reserved (byval nreserved as gint)
declare sub gtk_preview_set_dither (byval preview as GtkPreview ptr, byval dither as GdkRgbDither)
declare function gtk_preview_get_visual () as GdkVisual ptr
declare function gtk_preview_get_cmap () as GdkColormap ptr
declare function gtk_preview_get_info () as GtkPreviewInfo ptr
declare sub gtk_preview_reset ()

#endif
