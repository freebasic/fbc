''
''
'' gdkcolor -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gdkcolor_bi__
#define __gdkcolor_bi__

#include once "gdktypes.bi"

#define GDK_TYPE_COLORMAP (gdk_colormap_get_type ())
#define GDK_COLORMAP(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GDK_TYPE_COLORMAP, GdkColormap))
#define GDK_COLORMAP_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GDK_TYPE_COLORMAP, GdkColormapClass))
#define GDK_IS_COLORMAP(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GDK_TYPE_COLORMAP))
#define GDK_IS_COLORMAP_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GDK_TYPE_COLORMAP))
#define GDK_COLORMAP_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GDK_TYPE_COLORMAP, GdkColormapClass))

#define GDK_TYPE_COLOR (gdk_color_get_type ())

type _GdkColor
	pixel as guint32
	red as guint16
	green as guint16
	blue as guint16
end type

type GdkColormapClass as _GdkColormapClass

type _GdkColormap
	parent_instance as GObject
	size as gint
	colors as GdkColor ptr
	visual as GdkVisual ptr
	windowing_data as gpointer
end type

type _GdkColormapClass
	parent_class as GObjectClass
end type

declare function gdk_colormap_get_type () as GType
declare function gdk_colormap_new (byval visual as GdkVisual ptr, byval allocate as gboolean) as GdkColormap ptr
declare function gdk_colormap_ref (byval cmap as GdkColormap ptr) as GdkColormap ptr
declare sub gdk_colormap_unref (byval cmap as GdkColormap ptr)
declare function gdk_colormap_get_system () as GdkColormap ptr
declare function gdk_colormap_get_screen (byval cmap as GdkColormap ptr) as GdkScreen ptr
declare function gdk_colormap_get_system_size () as gint
declare sub gdk_colormap_change (byval colormap as GdkColormap ptr, byval ncolors as gint)
declare function gdk_colormap_alloc_colors (byval colormap as GdkColormap ptr, byval colors as GdkColor ptr, byval ncolors as gint, byval writeable as gboolean, byval best_match as gboolean, byval success as gboolean ptr) as gint
declare function gdk_colormap_alloc_color (byval colormap as GdkColormap ptr, byval color as GdkColor ptr, byval writeable as gboolean, byval best_match as gboolean) as gboolean
declare sub gdk_colormap_free_colors (byval colormap as GdkColormap ptr, byval colors as GdkColor ptr, byval ncolors as gint)
declare sub gdk_colormap_query_color (byval colormap as GdkColormap ptr, byval pixel as gulong, byval result as GdkColor ptr)
declare function gdk_colormap_get_visual (byval colormap as GdkColormap ptr) as GdkVisual ptr
declare function gdk_color_copy (byval color as GdkColor ptr) as GdkColor ptr
declare sub gdk_color_free (byval color as GdkColor ptr)
declare function gdk_color_parse (byval spec as zstring ptr, byval color as GdkColor ptr) as gint
declare function gdk_color_hash (byval colora as GdkColor ptr) as guint
declare function gdk_color_equal (byval colora as GdkColor ptr, byval colorb as GdkColor ptr) as gboolean
declare function gdk_color_get_type () as GType
declare sub gdk_colors_store (byval colormap as GdkColormap ptr, byval colors as GdkColor ptr, byval ncolors as gint)
declare function gdk_color_white (byval colormap as GdkColormap ptr, byval color as GdkColor ptr) as gint
declare function gdk_color_black (byval colormap as GdkColormap ptr, byval color as GdkColor ptr) as gint
declare function gdk_color_alloc (byval colormap as GdkColormap ptr, byval color as GdkColor ptr) as gint
declare function gdk_color_change (byval colormap as GdkColormap ptr, byval color as GdkColor ptr) as gint
declare function gdk_colors_alloc (byval colormap as GdkColormap ptr, byval contiguous as gboolean, byval planes as gulong ptr, byval nplanes as gint, byval pixels as gulong ptr, byval npixels as gint) as gint
declare sub gdk_colors_free (byval colormap as GdkColormap ptr, byval pixels as gulong ptr, byval npixels as gint, byval planes as gulong)

#endif
