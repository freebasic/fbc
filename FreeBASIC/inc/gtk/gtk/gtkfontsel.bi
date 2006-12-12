''
''
'' gtkfontsel -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkfontsel_bi__
#define __gtkfontsel_bi__

#include once "gtk/gdk.bi"
#include once "gtkdialog.bi"
#include once "gtkvbox.bi"

#define GTK_TYPE_FONT_SELECTION (gtk_font_selection_get_type ())
#define GTK_FONT_SELECTION(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_FONT_SELECTION, GtkFontSelection))
#define GTK_FONT_SELECTION_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_FONT_SELECTION, GtkFontSelectionClass))
#define GTK_IS_FONT_SELECTION(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_FONT_SELECTION))
#define GTK_IS_FONT_SELECTION_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_FONT_SELECTION))
#define GTK_FONT_SELECTION_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_FONT_SELECTION, GtkFontSelectionClass))


#define GTK_TYPE_FONT_SELECTION_DIALOG (gtk_font_selection_dialog_get_type ())
#define GTK_FONT_SELECTION_DIALOG(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_FONT_SELECTION_DIALOG, GtkFontSelectionDialog))
#define GTK_FONT_SELECTION_DIALOG_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_FONT_SELECTION_DIALOG, GtkFontSelectionDialogClass))
#define GTK_IS_FONT_SELECTION_DIALOG(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_FONT_SELECTION_DIALOG))
#define GTK_IS_FONT_SELECTION_DIALOG_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_FONT_SELECTION_DIALOG))
#define GTK_FONT_SELECTION_DIALOG_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_FONT_SELECTION_DIALOG, GtkFontSelectionDialogClass))

type GtkFontSelection as _GtkFontSelection
type GtkFontSelectionClass as _GtkFontSelectionClass
type GtkFontSelectionDialog as _GtkFontSelectionDialog
type GtkFontSelectionDialogClass as _GtkFontSelectionDialogClass

type _GtkFontSelection
	parent_instance as GtkVBox
	font_entry as GtkWidget ptr
	family_list as GtkWidget ptr
	font_style_entry as GtkWidget ptr
	face_list as GtkWidget ptr
	size_entry as GtkWidget ptr
	size_list as GtkWidget ptr
	pixels_button as GtkWidget ptr
	points_button as GtkWidget ptr
	filter_button as GtkWidget ptr
	preview_entry as GtkWidget ptr
	family as PangoFontFamily ptr
	face as PangoFontFace ptr
	size as gint
	font as GdkFont ptr
end type

type _GtkFontSelectionClass
	parent_class as GtkVBoxClass
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

type _GtkFontSelectionDialog
	parent_instance as GtkDialog
	fontsel as GtkWidget ptr
	main_vbox as GtkWidget ptr
	action_area as GtkWidget ptr
	ok_button as GtkWidget ptr
	apply_button as GtkWidget ptr
	cancel_button as GtkWidget ptr
	dialog_width as gint
	auto_resize as gboolean
end type

type _GtkFontSelectionDialogClass
	parent_class as GtkDialogClass
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_font_selection_get_type () as GType
declare function gtk_font_selection_new () as GtkWidget ptr
declare function gtk_font_selection_get_font_name (byval fontsel as GtkFontSelection ptr) as zstring ptr
declare function gtk_font_selection_get_font (byval fontsel as GtkFontSelection ptr) as GdkFont ptr
declare function gtk_font_selection_set_font_name (byval fontsel as GtkFontSelection ptr, byval fontname as zstring ptr) as gboolean
declare function gtk_font_selection_get_preview_text (byval fontsel as GtkFontSelection ptr) as zstring ptr
declare sub gtk_font_selection_set_preview_text (byval fontsel as GtkFontSelection ptr, byval text as zstring ptr)
declare function gtk_font_selection_dialog_get_type () as GType
declare function gtk_font_selection_dialog_new (byval title as zstring ptr) as GtkWidget ptr
declare function gtk_font_selection_dialog_get_font_name (byval fsd as GtkFontSelectionDialog ptr) as zstring ptr
declare function gtk_font_selection_dialog_get_font (byval fsd as GtkFontSelectionDialog ptr) as GdkFont ptr
declare function gtk_font_selection_dialog_set_font_name (byval fsd as GtkFontSelectionDialog ptr, byval fontname as zstring ptr) as gboolean
declare function gtk_font_selection_dialog_get_preview_text (byval fsd as GtkFontSelectionDialog ptr) as zstring ptr
declare sub gtk_font_selection_dialog_set_preview_text (byval fsd as GtkFontSelectionDialog ptr, byval text as zstring ptr)

#endif
