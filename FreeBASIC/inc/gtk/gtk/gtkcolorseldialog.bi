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

#include once "gtk/gtk/gtkdialog.bi"
#include once "gtk/gtk/gtkcolorsel.bi"
#include once "gtk/gtk/gtkvbox.bi"

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

declare function gtk_color_selection_dialog_get_type cdecl alias "gtk_color_selection_dialog_get_type" () as GType
declare function gtk_color_selection_dialog_new cdecl alias "gtk_color_selection_dialog_new" (byval title as gchar ptr) as GtkWidget ptr

#endif
