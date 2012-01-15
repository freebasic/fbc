''
''
'' pango-renderer -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __pango_renderer_bi__
#define __pango_renderer_bi__

#include once "pango-layout.bi"

#define PANGO_TYPE_RENDERER (pango_renderer_get_type())
#define PANGO_RENDERER(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), PANGO_TYPE_RENDERER, PangoRenderer))
#define PANGO_IS_RENDERER(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), PANGO_TYPE_RENDERER))
#define PANGO_RENDERER_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), PANGO_TYPE_RENDERER, PangoRendererClass))
#define PANGO_IS_RENDERER_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), PANGO_TYPE_RENDERER))
#define PANGO_RENDERER_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), PANGO_TYPE_RENDERER, PangoRendererClass))

type PangoRenderer as _PangoRenderer
type PangoRendererClass as _PangoRendererClass
type PangoRendererPrivate as _PangoRendererPrivate

enum PangoRenderPart
	PANGO_RENDER_PART_FOREGROUND
	PANGO_RENDER_PART_BACKGROUND
	PANGO_RENDER_PART_UNDERLINE
	PANGO_RENDER_PART_STRIKETHROUGH
end enum


type _PangoRenderer
	parent_instance as GObject
	underline as PangoUnderline
	strikethrough as gboolean
	active_count as integer
	matrix as PangoMatrix ptr
	priv as PangoRendererPrivate ptr
end type

type _PangoRendererClass
	parent_class as GObjectClass
	draw_glyphs as sub cdecl(byval as PangoRenderer ptr, byval as PangoFont ptr, byval as PangoGlyphString ptr, byval as integer, byval as integer)
	draw_rectangle as sub cdecl(byval as PangoRenderer ptr, byval as PangoRenderPart, byval as integer, byval as integer, byval as integer, byval as integer)
	draw_error_underline as sub cdecl(byval as PangoRenderer ptr, byval as integer, byval as integer, byval as integer, byval as integer)
	draw_shape as sub cdecl(byval as PangoRenderer ptr, byval as PangoAttrShape ptr, byval as integer, byval as integer)
	draw_trapezoid as sub cdecl(byval as PangoRenderer ptr, byval as PangoRenderPart, byval as double, byval as double, byval as double, byval as double, byval as double, byval as double)
	draw_glyph as sub cdecl(byval as PangoRenderer ptr, byval as PangoFont ptr, byval as PangoGlyph, byval as double, byval as double)
	part_changed as sub cdecl(byval as PangoRenderer ptr, byval as PangoRenderPart)
	begin as sub cdecl(byval as PangoRenderer ptr)
	end as sub cdecl(byval as PangoRenderer ptr)
	prepare_run as sub cdecl(byval as PangoRenderer ptr, byval as PangoLayoutRun ptr)
	_pango_reserved1 as sub cdecl()
	_pango_reserved2 as sub cdecl()
	_pango_reserved3 as sub cdecl()
	_pango_reserved4 as sub cdecl()
end type

declare function pango_renderer_get_type () as GType
declare sub pango_renderer_draw_layout (byval renderer as PangoRenderer ptr, byval layout as PangoLayout ptr, byval x as integer, byval y as integer)
declare sub pango_renderer_draw_layout_line (byval renderer as PangoRenderer ptr, byval line as PangoLayoutLine ptr, byval x as integer, byval y as integer)
declare sub pango_renderer_draw_glyphs (byval renderer as PangoRenderer ptr, byval font as PangoFont ptr, byval glyphs as PangoGlyphString ptr, byval x as integer, byval y as integer)
declare sub pango_renderer_draw_rectangle (byval renderer as PangoRenderer ptr, byval part as PangoRenderPart, byval x as integer, byval y as integer, byval width as integer, byval height as integer)
declare sub pango_renderer_draw_error_underline (byval renderer as PangoRenderer ptr, byval x as integer, byval y as integer, byval width as integer, byval height as integer)
declare sub pango_renderer_draw_trapezoid (byval renderer as PangoRenderer ptr, byval part as PangoRenderPart, byval y1 as double, byval x11 as double, byval x21 as double, byval y2 as double, byval x12 as double, byval x22 as double)
declare sub pango_renderer_draw_glyph (byval renderer as PangoRenderer ptr, byval font as PangoFont ptr, byval glyph as PangoGlyph, byval x as double, byval y as double)
declare sub pango_renderer_activate (byval renderer as PangoRenderer ptr)
declare sub pango_renderer_deactivate (byval renderer as PangoRenderer ptr)
declare sub pango_renderer_part_changed (byval renderer as PangoRenderer ptr, byval part as PangoRenderPart)
declare sub pango_renderer_set_color (byval renderer as PangoRenderer ptr, byval part as PangoRenderPart, byval color as PangoColor ptr)
declare function pango_renderer_get_color (byval renderer as PangoRenderer ptr, byval part as PangoRenderPart) as PangoColor ptr
declare sub pango_renderer_set_matrix (byval renderer as PangoRenderer ptr, byval matrix as PangoMatrix ptr)
declare function pango_renderer_get_matrix (byval renderer as PangoRenderer ptr) as PangoMatrix ptr

#endif
