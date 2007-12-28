''
''
'' gtkstyle -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkstyle_bi__
#define __gtkstyle_bi__

#include once "gtk/gdk.bi"
#include once "gtkenums.bi"
#include once "gtk/pango.bi"

#define GTK_TYPE_STYLE (gtk_style_get_type ())
#define GTK_STYLE(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GTK_TYPE_STYLE, GtkStyle))
#define GTK_STYLE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_STYLE, GtkStyleClass))
#define GTK_IS_STYLE(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GTK_TYPE_STYLE))
#define GTK_IS_STYLE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_STYLE))
#define GTK_STYLE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_STYLE, GtkStyleClass))

#define GTK_TYPE_BORDER (gtk_border_get_type ())

type GtkBorder as _GtkBorder
type GtkStyle as _GtkStyle
type GtkStyleClass as _GtkStyleClass
type GtkThemeEngine as _GtkThemeEngine
type GtkRcStyle as _GtkRcStyle
type GtkIconSet as _GtkIconSet
type GtkIconSource as _GtkIconSource
type GtkRcProperty as _GtkRcProperty
type GtkSettings as _GtkSettings
type GtkRcPropertyParser as function cdecl(byval as GParamSpec ptr, byval as GString ptr, byval as GValue ptr) as gboolean
type GtkWidget as _GtkWidget

type _GtkStyle
	parent_instance as GObject
	fg(0 to 5-1) as GdkColor
	bg(0 to 5-1) as GdkColor
	light(0 to 5-1) as GdkColor
	dark(0 to 5-1) as GdkColor
	mid(0 to 5-1) as GdkColor
	text(0 to 5-1) as GdkColor
	base(0 to 5-1) as GdkColor
	text_aa(0 to 5-1) as GdkColor
	black as GdkColor
	white as GdkColor
	font_desc as PangoFontDescription ptr
	xthickness as gint
	ythickness as gint
	fg_gc(0 to 5-1) as GdkGC ptr
	bg_gc(0 to 5-1) as GdkGC ptr
	light_gc(0 to 5-1) as GdkGC ptr
	dark_gc(0 to 5-1) as GdkGC ptr
	mid_gc(0 to 5-1) as GdkGC ptr
	text_gc(0 to 5-1) as GdkGC ptr
	base_gc(0 to 5-1) as GdkGC ptr
	text_aa_gc(0 to 5-1) as GdkGC ptr
	black_gc as GdkGC ptr
	white_gc as GdkGC ptr
	bg_pixmap(0 to 5-1) as GdkPixmap ptr
	attach_count as gint
	depth as gint
	colormap as GdkColormap ptr
	private_font as GdkFont ptr
	private_font_desc as PangoFontDescription ptr
	rc_style as GtkRcStyle ptr
	styles as GSList ptr
	property_cache as GArray ptr
	icon_factories as GSList ptr
end type

type _GtkStyleClass
	parent_class as GObjectClass
	realize as sub cdecl(byval as GtkStyle ptr)
	unrealize as sub cdecl(byval as GtkStyle ptr)
	copy as sub cdecl(byval as GtkStyle ptr, byval as GtkStyle ptr)
	clone as function cdecl(byval as GtkStyle ptr) as GtkStyle
	init_from_rc as sub cdecl(byval as GtkStyle ptr, byval as GtkRcStyle ptr)
	set_background as sub cdecl(byval as GtkStyle ptr, byval as GdkWindow ptr, byval as GtkStateType)
	render_icon as function cdecl(byval as GtkStyle ptr, byval as GtkIconSource ptr, byval as GtkTextDirection, byval as GtkStateType, byval as GtkIconSize, byval as GtkWidget ptr, byval as zstring ptr) as GdkPixbuf ptr
	draw_hline as sub cdecl(byval as GtkStyle ptr, byval as GdkWindow ptr, byval as GtkStateType, byval as GdkRectangle ptr, byval as GtkWidget ptr, byval as zstring ptr, byval as gint, byval as gint, byval as gint)
	draw_vline as sub cdecl(byval as GtkStyle ptr, byval as GdkWindow ptr, byval as GtkStateType, byval as GdkRectangle ptr, byval as GtkWidget ptr, byval as zstring ptr, byval as gint, byval as gint, byval as gint)
	draw_shadow as sub cdecl(byval as GtkStyle ptr, byval as GdkWindow ptr, byval as GtkStateType, byval as GtkShadowType, byval as GdkRectangle ptr, byval as GtkWidget ptr, byval as zstring ptr, byval as gint, byval as gint, byval as gint, byval as gint)
	draw_polygon as sub cdecl(byval as GtkStyle ptr, byval as GdkWindow ptr, byval as GtkStateType, byval as GtkShadowType, byval as GdkRectangle ptr, byval as GtkWidget ptr, byval as zstring ptr, byval as GdkPoint ptr, byval as gint, byval as gboolean)
	draw_arrow as sub cdecl(byval as GtkStyle ptr, byval as GdkWindow ptr, byval as GtkStateType, byval as GtkShadowType, byval as GdkRectangle ptr, byval as GtkWidget ptr, byval as zstring ptr, byval as GtkArrowType, byval as gboolean, byval as gint, byval as gint, byval as gint, byval as gint)
	draw_diamond as sub cdecl(byval as GtkStyle ptr, byval as GdkWindow ptr, byval as GtkStateType, byval as GtkShadowType, byval as GdkRectangle ptr, byval as GtkWidget ptr, byval as zstring ptr, byval as gint, byval as gint, byval as gint, byval as gint)
	draw_string as sub cdecl(byval as GtkStyle ptr, byval as GdkWindow ptr, byval as GtkStateType, byval as GdkRectangle ptr, byval as GtkWidget ptr, byval as zstring ptr, byval as gint, byval as gint, byval as zstring ptr)
	draw_box as sub cdecl(byval as GtkStyle ptr, byval as GdkWindow ptr, byval as GtkStateType, byval as GtkShadowType, byval as GdkRectangle ptr, byval as GtkWidget ptr, byval as zstring ptr, byval as gint, byval as gint, byval as gint, byval as gint)
	draw_flat_box as sub cdecl(byval as GtkStyle ptr, byval as GdkWindow ptr, byval as GtkStateType, byval as GtkShadowType, byval as GdkRectangle ptr, byval as GtkWidget ptr, byval as zstring ptr, byval as gint, byval as gint, byval as gint, byval as gint)
	draw_check as sub cdecl(byval as GtkStyle ptr, byval as GdkWindow ptr, byval as GtkStateType, byval as GtkShadowType, byval as GdkRectangle ptr, byval as GtkWidget ptr, byval as zstring ptr, byval as gint, byval as gint, byval as gint, byval as gint)
	draw_option as sub cdecl(byval as GtkStyle ptr, byval as GdkWindow ptr, byval as GtkStateType, byval as GtkShadowType, byval as GdkRectangle ptr, byval as GtkWidget ptr, byval as zstring ptr, byval as gint, byval as gint, byval as gint, byval as gint)
	draw_tab as sub cdecl(byval as GtkStyle ptr, byval as GdkWindow ptr, byval as GtkStateType, byval as GtkShadowType, byval as GdkRectangle ptr, byval as GtkWidget ptr, byval as zstring ptr, byval as gint, byval as gint, byval as gint, byval as gint)
	draw_shadow_gap as sub cdecl(byval as GtkStyle ptr, byval as GdkWindow ptr, byval as GtkStateType, byval as GtkShadowType, byval as GdkRectangle ptr, byval as GtkWidget ptr, byval as zstring ptr, byval as gint, byval as gint, byval as gint, byval as gint, byval as GtkPositionType, byval as gint, byval as gint)
	draw_box_gap as sub cdecl(byval as GtkStyle ptr, byval as GdkWindow ptr, byval as GtkStateType, byval as GtkShadowType, byval as GdkRectangle ptr, byval as GtkWidget ptr, byval as zstring ptr, byval as gint, byval as gint, byval as gint, byval as gint, byval as GtkPositionType, byval as gint, byval as gint)
	draw_extension as sub cdecl(byval as GtkStyle ptr, byval as GdkWindow ptr, byval as GtkStateType, byval as GtkShadowType, byval as GdkRectangle ptr, byval as GtkWidget ptr, byval as zstring ptr, byval as gint, byval as gint, byval as gint, byval as gint, byval as GtkPositionType)
	draw_focus as sub cdecl(byval as GtkStyle ptr, byval as GdkWindow ptr, byval as GtkStateType, byval as GdkRectangle ptr, byval as GtkWidget ptr, byval as zstring ptr, byval as gint, byval as gint, byval as gint, byval as gint)
	draw_slider as sub cdecl(byval as GtkStyle ptr, byval as GdkWindow ptr, byval as GtkStateType, byval as GtkShadowType, byval as GdkRectangle ptr, byval as GtkWidget ptr, byval as zstring ptr, byval as gint, byval as gint, byval as gint, byval as gint, byval as GtkOrientation)
	draw_handle as sub cdecl(byval as GtkStyle ptr, byval as GdkWindow ptr, byval as GtkStateType, byval as GtkShadowType, byval as GdkRectangle ptr, byval as GtkWidget ptr, byval as zstring ptr, byval as gint, byval as gint, byval as gint, byval as gint, byval as GtkOrientation)
	draw_expander as sub cdecl(byval as GtkStyle ptr, byval as GdkWindow ptr, byval as GtkStateType, byval as GdkRectangle ptr, byval as GtkWidget ptr, byval as zstring ptr, byval as gint, byval as gint, byval as GtkExpanderStyle)
	draw_layout as sub cdecl(byval as GtkStyle ptr, byval as GdkWindow ptr, byval as GtkStateType, byval as gboolean, byval as GdkRectangle ptr, byval as GtkWidget ptr, byval as zstring ptr, byval as gint, byval as gint, byval as PangoLayout ptr)
	draw_resize_grip as sub cdecl(byval as GtkStyle ptr, byval as GdkWindow ptr, byval as GtkStateType, byval as GdkRectangle ptr, byval as GtkWidget ptr, byval as zstring ptr, byval as GdkWindowEdge, byval as gint, byval as gint, byval as gint, byval as gint)
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
	_gtk_reserved5 as sub cdecl()
	_gtk_reserved6 as sub cdecl()
	_gtk_reserved7 as sub cdecl()
	_gtk_reserved8 as sub cdecl()
	_gtk_reserved9 as sub cdecl()
	_gtk_reserved10 as sub cdecl()
	_gtk_reserved11 as sub cdecl()
	_gtk_reserved12 as sub cdecl()
end type

type _GtkBorder
	left as gint
	right as gint
	top as gint
	bottom as gint
end type

declare function gtk_style_get_type () as GType
declare function gtk_style_new () as GtkStyle ptr
declare function gtk_style_copy (byval style as GtkStyle ptr) as GtkStyle ptr
declare function gtk_style_attach (byval style as GtkStyle ptr, byval window as GdkWindow ptr) as GtkStyle ptr
declare sub gtk_style_detach (byval style as GtkStyle ptr)
declare function gtk_style_ref (byval style as GtkStyle ptr) as GtkStyle ptr
declare sub gtk_style_unref (byval style as GtkStyle ptr)
declare function gtk_style_get_font (byval style as GtkStyle ptr) as GdkFont ptr
declare sub gtk_style_set_font (byval style as GtkStyle ptr, byval font as GdkFont ptr)
declare sub gtk_style_set_background (byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType)
declare sub gtk_style_apply_default_background (byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval set_bg as gboolean, byval state_type as GtkStateType, byval area as GdkRectangle ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare function gtk_style_lookup_icon_set (byval style as GtkStyle ptr, byval stock_id as zstring ptr) as GtkIconSet ptr
declare function gtk_style_render_icon (byval style as GtkStyle ptr, byval source as GtkIconSource ptr, byval direction as GtkTextDirection, byval state as GtkStateType, byval size as GtkIconSize, byval widget as GtkWidget ptr, byval detail as zstring ptr) as GdkPixbuf ptr
declare sub gtk_draw_hline (byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval x1 as gint, byval x2 as gint, byval y as gint)
declare sub gtk_draw_vline (byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval y1_ as gint, byval y2_ as gint, byval x as gint)
declare sub gtk_draw_shadow (byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gtk_draw_polygon (byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval points as GdkPoint ptr, byval npoints as gint, byval fill as gboolean)
declare sub gtk_draw_arrow (byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval arrow_type as GtkArrowType, byval fill as gboolean, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gtk_draw_diamond (byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gtk_draw_box (byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gtk_draw_flat_box (byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gtk_draw_check (byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gtk_draw_option (byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gtk_draw_tab (byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gtk_draw_shadow_gap (byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval x as gint, byval y as gint, byval width as gint, byval height as gint, byval gap_side as GtkPositionType, byval gap_x as gint, byval gap_width as gint)
declare sub gtk_draw_box_gap (byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval x as gint, byval y as gint, byval width as gint, byval height as gint, byval gap_side as GtkPositionType, byval gap_x as gint, byval gap_width as gint)
declare sub gtk_draw_extension (byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval x as gint, byval y as gint, byval width as gint, byval height as gint, byval gap_side as GtkPositionType)
declare sub gtk_draw_focus (byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gtk_draw_slider (byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval x as gint, byval y as gint, byval width as gint, byval height as gint, byval orientation as GtkOrientation)
declare sub gtk_draw_handle (byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval x as gint, byval y as gint, byval width as gint, byval height as gint, byval orientation as GtkOrientation)
declare sub gtk_draw_expander (byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval x as gint, byval y as gint, byval expander_style as GtkExpanderStyle)
declare sub gtk_draw_layout (byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval use_text as gboolean, byval x as gint, byval y as gint, byval layout as PangoLayout ptr)
declare sub gtk_draw_resize_grip (byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval edge as GdkWindowEdge, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gtk_paint_hline (byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval area as GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as zstring ptr, byval x1 as gint, byval x2 as gint, byval y as gint)
declare sub gtk_paint_vline (byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval area as GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as zstring ptr, byval y1_ as gint, byval y2_ as gint, byval x as gint)
declare sub gtk_paint_shadow (byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval area as GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as zstring ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gtk_paint_polygon (byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval area as GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as zstring ptr, byval points as GdkPoint ptr, byval npoints as gint, byval fill as gboolean)
declare sub gtk_paint_arrow (byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval area as GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as zstring ptr, byval arrow_type as GtkArrowType, byval fill as gboolean, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gtk_paint_diamond (byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval area as GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as zstring ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gtk_paint_box (byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval area as GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as zstring ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gtk_paint_flat_box (byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval area as GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as zstring ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gtk_paint_check (byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval area as GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as zstring ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gtk_paint_option (byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval area as GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as zstring ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gtk_paint_tab (byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval area as GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as zstring ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gtk_paint_shadow_gap (byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval area as GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as zstring ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint, byval gap_side as GtkPositionType, byval gap_x as gint, byval gap_width as gint)
declare sub gtk_paint_box_gap (byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval area as GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as zstring ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint, byval gap_side as GtkPositionType, byval gap_x as gint, byval gap_width as gint)
declare sub gtk_paint_extension (byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval area as GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as zstring ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint, byval gap_side as GtkPositionType)
declare sub gtk_paint_focus (byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval area as GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as zstring ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gtk_paint_slider (byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval area as GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as zstring ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint, byval orientation as GtkOrientation)
declare sub gtk_paint_handle (byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval area as GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as zstring ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint, byval orientation as GtkOrientation)
declare sub gtk_paint_expander (byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval area as GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as zstring ptr, byval x as gint, byval y as gint, byval expander_style as GtkExpanderStyle)
declare sub gtk_paint_layout (byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval use_text as gboolean, byval area as GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as zstring ptr, byval x as gint, byval y as gint, byval layout as PangoLayout ptr)
declare sub gtk_paint_resize_grip (byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval area as GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as zstring ptr, byval edge as GdkWindowEdge, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare function gtk_border_get_type () as GType
declare function gtk_border_copy (byval border_ as GtkBorder ptr) as GtkBorder ptr
declare sub gtk_border_free (byval border_ as GtkBorder ptr)
declare function _gtk_style_peek_property_value (byval style as GtkStyle ptr, byval widget_type as GType, byval pspec as GParamSpec ptr, byval parser as GtkRcPropertyParser) as GValue ptr
declare sub _gtk_style_init_for_settings (byval style as GtkStyle ptr, byval settings as GtkSettings ptr)
declare sub gtk_draw_string (byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval x as gint, byval y as gint, byval string as zstring ptr)
declare sub gtk_paint_string (byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval area as GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as zstring ptr, byval x as gint, byval y as gint, byval string as zstring ptr)
declare sub gtk_draw_insertion_cursor (byval widget as GtkWidget ptr, byval drawable as GdkDrawable ptr, byval area as GdkRectangle ptr, byval location as GdkRectangle ptr, byval is_primary as gboolean, byval direction as GtkTextDirection, byval draw_arrow as gboolean)

#define gtk_style_apply_default_pixmap(s,gw,st,a,x,y,w,h) gtk_style_apply_default_background(s,gw,1,st,a,x,y,w,h)

#endif
