''
''
'' gtkmessagedialog -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkmessagedialog_bi__
#define __gtkmessagedialog_bi__

#include once "gtk/gtk/gtkdialog.bi"

enum GtkMessageType
	GTK_MESSAGE_INFO
	GTK_MESSAGE_WARNING
	GTK_MESSAGE_QUESTION
	GTK_MESSAGE_ERROR
end enum


enum GtkButtonsType
	GTK_BUTTONS_NONE
	GTK_BUTTONS_OK
	GTK_BUTTONS_CLOSE
	GTK_BUTTONS_CANCEL
	GTK_BUTTONS_YES_NO
	GTK_BUTTONS_OK_CANCEL
end enum

type GtkMessageDialog as _GtkMessageDialog
type GtkMessageDialogClass as _GtkMessageDialogClass

type _GtkMessageDialog
	parent_instance as GtkDialog
	image as GtkWidget ptr
	label as GtkWidget ptr
end type

type _GtkMessageDialogClass
	parent_class as GtkDialogClass
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_message_dialog_get_type cdecl alias "gtk_message_dialog_get_type" () as GType
declare function gtk_message_dialog_new cdecl alias "gtk_message_dialog_new" (byval parent as GtkWindow ptr, byval flags as GtkDialogFlags, byval type as GtkMessageType, byval buttons as GtkButtonsType, byval message_format as gchar ptr, ...) as GtkWidget ptr
declare function gtk_message_dialog_new_with_markup cdecl alias "gtk_message_dialog_new_with_markup" (byval parent as GtkWindow ptr, byval flags as GtkDialogFlags, byval type as GtkMessageType, byval buttons as GtkButtonsType, byval message_format as gchar ptr, ...) as GtkWidget ptr
declare sub gtk_message_dialog_set_markup cdecl alias "gtk_message_dialog_set_markup" (byval message_dialog as GtkMessageDialog ptr, byval str as gchar ptr)
declare sub gtk_message_dialog_format_secondary_text cdecl alias "gtk_message_dialog_format_secondary_text" (byval message_dialog as GtkMessageDialog ptr, byval message_format as gchar ptr, ...)
declare sub gtk_message_dialog_format_secondary_markup cdecl alias "gtk_message_dialog_format_secondary_markup" (byval message_dialog as GtkMessageDialog ptr, byval message_format as gchar ptr, ...)

#endif
