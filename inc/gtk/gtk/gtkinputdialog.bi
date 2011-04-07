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
#include once "gtkdialog.bi"

#define GTK_TYPE_INPUT_DIALOG (gtk_input_dialog_get_type ())
#define GTK_INPUT_DIALOG(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_INPUT_DIALOG, GtkInputDialog))
#define GTK_INPUT_DIALOG_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_INPUT_DIALOG, GtkInputDialogClass))
#define GTK_IS_INPUT_DIALOG(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_INPUT_DIALOG))
#define GTK_IS_INPUT_DIALOG_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_INPUT_DIALOG))
#define GTK_INPUT_DIALOG_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_INPUT_DIALOG, GtkInputDialogClass))

type GtkInputDialog as _GtkInputDialog
type GtkInputDialogClass as _GtkInputDialogClass

type _GtkInputDialog
	dialog as GtkDialog
	axis_list as GtkWidget ptr
	axis_listbox as GtkWidget ptr
	mode_optionmenu as GtkWidget ptr
	close_button as GtkWidget ptr
	save_button as GtkWidget ptr
	axis_items(0 to GDK_AXIS_LAST-1) as GtkWidget ptr
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

declare function gtk_input_dialog_get_type () as GType
declare function gtk_input_dialog_new () as GtkWidget ptr

#endif
