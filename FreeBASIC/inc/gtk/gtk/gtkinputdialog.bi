''
''
'' gtkinputdialog -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkinputdialog_bi__
#define __gtkinputdialog_bi__

#include once "gtk/gdk.bi"
#include once "gtk/gtk/gtkdialog.bi"

type GtkInputDialog as _GtkInputDialog
type GtkInputDialogClass as _GtkInputDialogClass

type _GtkInputDialog
	dialog as GtkDialog
	axis_list as GtkWidget ptr
	axis_listbox as GtkWidget ptr
	mode_optionmenu as GtkWidget ptr
	close_button as GtkWidget ptr
	save_button as GtkWidget ptr
	axis_items(0 to GDK_AXIS_LAST-1) as GtkWidget ptr ptr
	current_device as GdkDevice ptr
	keys_list as GtkWidget ptr
	keys_listbox as GtkWidget ptr
end type

type _GtkInputDialogClass
	parent_class as GtkDialogClass
	enable_device as sub cdecl(byval as GtkInputDialog ptr, byval as GdkDevice ptr)
	disable_device as sub cdecl(byval as GtkInputDialog ptr, byval as GdkDevice ptr)
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_input_dialog_get_type cdecl alias "gtk_input_dialog_get_type" () as GType
declare function gtk_input_dialog_new cdecl alias "gtk_input_dialog_new" () as GtkWidget ptr

#endif
