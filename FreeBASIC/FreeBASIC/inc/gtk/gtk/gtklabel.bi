''
''
'' gtklabel -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtklabel_bi__
#define __gtklabel_bi__

#include once "gtk/gdk.bi"
#include once "gtkmisc.bi"
#include once "gtkwindow.bi"
#include once "gtkmenu.bi"

#define GTK_TYPE_LABEL (gtk_label_get_type ())
#define GTK_LABEL(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_LABEL, GtkLabel))
#define GTK_LABEL_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_LABEL, GtkLabelClass))
#define GTK_IS_LABEL(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_LABEL))
#define GTK_IS_LABEL_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_LABEL))
#define GTK_LABEL_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_LABEL, GtkLabelClass))

type GtkLabel as _GtkLabel
type GtkLabelClass as _GtkLabelClass
type GtkLabelSelectionInfo as _GtkLabelSelectionInfo

type _GtkLabel
	misc as GtkMisc
	label as zstring ptr
	jtype:2 as guint
	wrap:1 as guint
	use_underline:1 as guint
	use_markup:1 as guint
	ellipsize:3 as guint
	mnemonic_keyval as guint
	text as zstring ptr
	attrs as PangoAttrList ptr
	effective_attrs as PangoAttrList ptr
	layout as PangoLayout ptr
	mnemonic_widget as GtkWidget ptr
	mnemonic_window as GtkWindow ptr
	select_info as GtkLabelSelectionInfo ptr
end type

type _GtkLabelClass
	parent_class as GtkMiscClass
	move_cursor as sub cdecl(byval as GtkLabel ptr, byval as GtkMovementStep, byval as gint, byval as gboolean)
	copy_clipboard as sub cdecl(byval as GtkLabel ptr)
	populate_popup as sub cdecl(byval as GtkLabel ptr, byval as GtkMenu ptr)
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_label_get_type () as GType
declare function gtk_label_new (byval str as zstring ptr) as GtkWidget ptr
declare function gtk_label_new_with_mnemonic (byval str as zstring ptr) as GtkWidget ptr
declare sub gtk_label_set_text (byval label as GtkLabel ptr, byval str as zstring ptr)
declare function gtk_label_get_text (byval label as GtkLabel ptr) as zstring ptr
declare sub gtk_label_set_attributes (byval label as GtkLabel ptr, byval attrs as PangoAttrList ptr)
declare function gtk_label_get_attributes (byval label as GtkLabel ptr) as PangoAttrList ptr
declare sub gtk_label_set_label (byval label as GtkLabel ptr, byval str as zstring ptr)
declare function gtk_label_get_label (byval label as GtkLabel ptr) as zstring ptr
declare sub gtk_label_set_markup (byval label as GtkLabel ptr, byval str as zstring ptr)
declare sub gtk_label_set_use_markup (byval label as GtkLabel ptr, byval setting as gboolean)
declare function gtk_label_get_use_markup (byval label as GtkLabel ptr) as gboolean
declare sub gtk_label_set_use_underline (byval label as GtkLabel ptr, byval setting as gboolean)
declare function gtk_label_get_use_underline (byval label as GtkLabel ptr) as gboolean
declare sub gtk_label_set_markup_with_mnemonic (byval label as GtkLabel ptr, byval str as zstring ptr)
declare function gtk_label_get_mnemonic_keyval (byval label as GtkLabel ptr) as guint
declare sub gtk_label_set_mnemonic_widget (byval label as GtkLabel ptr, byval widget as GtkWidget ptr)
declare function gtk_label_get_mnemonic_widget (byval label as GtkLabel ptr) as GtkWidget ptr
declare sub gtk_label_set_text_with_mnemonic (byval label as GtkLabel ptr, byval str as zstring ptr)
declare sub gtk_label_set_justify (byval label as GtkLabel ptr, byval jtype as GtkJustification)
declare function gtk_label_get_justify (byval label as GtkLabel ptr) as GtkJustification
declare sub gtk_label_set_ellipsize (byval label as GtkLabel ptr, byval mode as PangoEllipsizeMode)
declare function gtk_label_get_ellipsize (byval label as GtkLabel ptr) as PangoEllipsizeMode
declare sub gtk_label_set_width_chars (byval label as GtkLabel ptr, byval n_chars as gint)
declare function gtk_label_get_width_chars (byval label as GtkLabel ptr) as gint
declare sub gtk_label_set_max_width_chars (byval label as GtkLabel ptr, byval n_chars as gint)
declare function gtk_label_get_max_width_chars (byval label as GtkLabel ptr) as gint
declare sub gtk_label_set_pattern (byval label as GtkLabel ptr, byval pattern as zstring ptr)
declare sub gtk_label_set_line_wrap (byval label as GtkLabel ptr, byval wrap as gboolean)
declare function gtk_label_get_line_wrap (byval label as GtkLabel ptr) as gboolean
declare sub gtk_label_set_selectable (byval label as GtkLabel ptr, byval setting as gboolean)
declare function gtk_label_get_selectable (byval label as GtkLabel ptr) as gboolean
declare sub gtk_label_set_angle (byval label as GtkLabel ptr, byval angle as gdouble)
declare function gtk_label_get_angle (byval label as GtkLabel ptr) as gdouble
declare sub gtk_label_select_region (byval label as GtkLabel ptr, byval start_offset as gint, byval end_offset as gint)
declare function gtk_label_get_selection_bounds (byval label as GtkLabel ptr, byval start as gint ptr, byval end as gint ptr) as gboolean
declare function gtk_label_get_layout (byval label as GtkLabel ptr) as PangoLayout ptr
declare sub gtk_label_get_layout_offsets (byval label as GtkLabel ptr, byval x as gint ptr, byval y as gint ptr)
declare sub gtk_label_set_single_line_mode (byval label as GtkLabel ptr, byval single_line_mode as gboolean)
declare function gtk_label_get_single_line_mode (byval label as GtkLabel ptr) as gboolean
declare sub gtk_label_get (byval label as GtkLabel ptr, byval str as byte ptr ptr)
declare function gtk_label_parse_uline (byval label as GtkLabel ptr, byval string as zstring ptr) as guint

#define gtk_label_set gtk_label_set_text

#endif
