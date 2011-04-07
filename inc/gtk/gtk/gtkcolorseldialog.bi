''
''
'' gtkcolorseldialog -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkcolorseldialog_bi__
#define __gtkcolorseldialog_bi__

#include once "gtkdialog.bi"
#include once "gtkcolorsel.bi"
#include once "gtkvbox.bi"

#define GTK_TYPE_COLOR_SELECTION_DIALOG (gtk_color_selection_dialog_get_type ())
#define GTK_COLOR_SELECTION_DIALOG(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_COLOR_SELECTION_DIALOG, GtkColorSelectionDialog))
#define GTK_COLOR_SELECTION_DIALOG_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_COLOR_SELECTION_DIALOG, GtkColorSelectionDialogClass))
#define GTK_IS_COLOR_SELECTION_DIALOG(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_COLOR_SELECTION_DIALOG))
#define GTK_IS_COLOR_SELECTION_DIALOG_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_COLOR_SELECTION_DIALOG))
#define GTK_COLOR_SELECTION_DIALOG_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_COLOR_SELECTION_DIALOG, GtkColorSelectionDialogClass))

type GtkColorSelectionDialog as _GtkColorSelectionDialog
type GtkColorSelectionDialogClass as _GtkColorSelectionDialogClass

type _GtkColorSelectionDialog
	parent_instance as GtkDialog
	colorsel as GtkWidget ptr
	ok_button as GtkWidget ptr
	cancel_button as GtkWidget ptr
	help_button as GtkWidget ptr
end type

type _GtkColorSelectionDialogClass
	parent_class as GtkDialogClass
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_color_selection_dialog_get_type () as GType
declare function gtk_color_selection_dialog_new (byval title as zstring ptr) as GtkWidget ptr

#endif
