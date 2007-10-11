''
''
'' gdkpango -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gdkpango_bi__
#define __gdkpango_bi__

#include once "gdktypes.bi"

#define GDK_TYPE_PANGO_RENDERER (gdk_pango_renderer_get_type())
#define GDK_PANGO_RENDERER(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GDK_TYPE_PANGO_RENDERER, GdkPangoRenderer))
#define GDK_IS_PANGO_RENDERER(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GDK_TYPE_PANGO_RENDERER))
#define GDK_PANGO_RENDERER_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GDK_TYPE_PANGO_RENDERER, GdkPangoRendererClass))
#define GDK_IS_PANGO_RENDERER_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GDK_TYPE_PANGO_RENDERER))
#define GDK_PANGO_RENDERER_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GDK_TYPE_PANGO_RENDERER, GdkPangoRendererClass))

type GdkPangoRenderer as _GdkPangoRenderer
type GdkPangoRendererClass as _GdkPangoRendererClass
type GdkPangoRendererPrivate as _GdkPangoRendererPrivate

type _GdkPangoRenderer
	parent_instance as PangoRenderer
	priv as GdkPangoRendererPrivate ptr
end type

type _GdkPangoRendererClass
	parent_class as PangoRendererClass
end type

declare function gdk_pango_renderer_get_type () as GType
declare function gdk_pango_renderer_new (byval screen as GdkScreen ptr) as PangoRenderer ptr
declare function gdk_pango_renderer_get_default (byval screen as GdkScreen ptr) as PangoRenderer ptr
declare sub gdk_pango_renderer_set_drawable (byval gdk_renderer as GdkPangoRenderer ptr, byval drawable as GdkDrawable ptr)
declare sub gdk_pango_renderer_set_gc (byval gdk_renderer as GdkPangoRenderer ptr, byval gc as GdkGC ptr)
declare sub gdk_pango_renderer_set_stipple (byval gdk_renderer as GdkPangoRenderer ptr, byval part as PangoRenderPart, byval stipple as GdkBitmap ptr)
declare sub gdk_pango_renderer_set_override_color (byval gdk_renderer as GdkPangoRenderer ptr, byval part as PangoRenderPart, byval color as GdkColor ptr)
declare function gdk_pango_context_get_for_screen (byval screen as GdkScreen ptr) as PangoContext ptr
declare function gdk_pango_context_get () as PangoContext ptr
declare sub gdk_pango_context_set_colormap (byval context as PangoContext ptr, byval colormap as GdkColormap ptr)
declare function gdk_pango_layout_line_get_clip_region (byval line as PangoLayoutLine ptr, byval x_origin as gint, byval y_origin as gint, byval index_ranges as gint ptr, byval n_ranges as gint) as GdkRegion ptr
declare function gdk_pango_layout_get_clip_region (byval layout as PangoLayout ptr, byval x_origin as gint, byval y_origin as gint, byval index_ranges as gint ptr, byval n_ranges as gint) as GdkRegion ptr

type GdkPangoAttrStipple as _GdkPangoAttrStipple
type GdkPangoAttrEmbossed as _GdkPangoAttrEmbossed

type _GdkPangoAttrStipple
	attr as PangoAttribute
	stipple as GdkBitmap ptr
end type

type _GdkPangoAttrEmbossed
	attr as PangoAttribute
	embossed as gboolean
end type

declare function gdk_pango_attr_stipple_new (byval stipple as GdkBitmap ptr) as PangoAttribute ptr
declare function gdk_pango_attr_embossed_new (byval embossed as gboolean) as PangoAttribute ptr

#endif
