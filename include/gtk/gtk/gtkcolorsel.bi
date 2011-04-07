''
''
'' gtkcolorsel -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkcolorsel_bi__
#define __gtkcolorsel_bi__

#include once "gtkdialog.bi"
#include once "gtkvbox.bi"

#define GTK_TYPE_COLOR_SELECTION (gtk_color_selection_get_type ())
#define GTK_COLOR_SELECTION(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_COLOR_SELECTION, GtkColorSelection))
#define GTK_COLOR_SELECTION_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_COLOR_SELECTION, GtkColorSelectionClass))
#define GTK_IS_COLOR_SELECTION(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_COLOR_SELECTION))
#define GTK_IS_COLOR_SELECTION_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_COLOR_SELECTION))
#define GTK_COLOR_SELECTION_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_COLOR_SELECTION, GtkColorSelectionClass))

type GtkColorSelection as _GtkColorSelection
type GtkColorSelectionClass as _GtkColorSelectionClass
type GtkColorSelectionChangePaletteFunc as sub cdecl(byval as GdkColor ptr, byval as gint)
type GtkColorSelectionChangePaletteWithScreenFunc as sub cdecl(byval as GdkScreen ptr, byval as GdkColor ptr, byval as gint)

type _GtkColorSelection
	parent_instance as GtkVBox
	private_data as gpointer
end type

type _GtkColorSelectionClass
	parent_class as GtkVBoxClass
	color_changed as sub cdecl(byval as GtkColorSelection ptr)
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_color_selection_get_type () as GType
declare function gtk_color_selection_new () as GtkWidget ptr
declare function gtk_color_selection_get_has_opacity_control (byval colorsel as GtkColorSelection ptr) as gboolean
declare sub gtk_color_selection_set_has_opacity_control (byval colorsel as GtkColorSelection ptr, byval has_opacity as gboolean)
declare function gtk_color_selection_get_has_palette (byval colorsel as GtkColorSelection ptr) as gboolean
declare sub gtk_color_selection_set_has_palette (byval colorsel as GtkColorSelection ptr, byval has_palette as gboolean)
declare sub gtk_color_selection_set_current_color (byval colorsel as GtkColorSelection ptr, byval color as GdkColor ptr)
declare sub gtk_color_selection_set_current_alpha (byval colorsel as GtkColorSelection ptr, byval alpha as guint16)
declare sub gtk_color_selection_get_current_color (byval colorsel as GtkColorSelection ptr, byval color as GdkColor ptr)
declare function gtk_color_selection_get_current_alpha (byval colorsel as GtkColorSelection ptr) as guint16
declare sub gtk_color_selection_set_previous_color (byval colorsel as GtkColorSelection ptr, byval color as GdkColor ptr)
declare sub gtk_color_selection_set_previous_alpha (byval colorsel as GtkColorSelection ptr, byval alpha as guint16)
declare sub gtk_color_selection_get_previous_color (byval colorsel as GtkColorSelection ptr, byval color as GdkColor ptr)
declare function gtk_color_selection_get_previous_alpha (byval colorsel as GtkColorSelection ptr) as guint16
declare function gtk_color_selection_is_adjusting (byval colorsel as GtkColorSelection ptr) as gboolean
declare function gtk_color_selection_palette_from_string (byval str as zstring ptr, byval colors as GdkColor ptr ptr, byval n_colors as gint ptr) as gboolean
declare function gtk_color_selection_palette_to_string (byval colors as GdkColor ptr, byval n_colors as gint) as zstring ptr
declare function gtk_color_selection_set_change_palette_hook (byval func as GtkColorSelectionChangePaletteFunc) as GtkColorSelectionChangePaletteFunc
declare function gtk_color_selection_set_change_palette_with_screen_hook (byval func as GtkColorSelectionChangePaletteWithScreenFunc) as GtkColorSelectionChangePaletteWithScreenFunc
declare sub gtk_color_selection_set_color (byval colorsel as GtkColorSelection ptr, byval color as gdouble ptr)
declare sub gtk_color_selection_get_color (byval colorsel as GtkColorSelection ptr, byval color as gdouble ptr)
declare sub gtk_color_selection_set_update_policy (byval colorsel as GtkColorSelection ptr, byval policy as GtkUpdateType)

#endif
