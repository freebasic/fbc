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

#include once "gtkdialog.bi"

#define GTK_TYPE_MESSAGE_DIALOG (gtk_message_dialog_get_type ())
#define GTK_MESSAGE_DIALOG(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_MESSAGE_DIALOG, GtkMessageDialog))
#define GTK_MESSAGE_DIALOG_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_MESSAGE_DIALOG, GtkMessageDialogClass))
#define GTK_IS_MESSAGE_DIALOG(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_MESSAGE_DIALOG))
#define GTK_IS_MESSAGE_DIALOG_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_MESSAGE_DIALOG))
#define GTK_MESSAGE_DIALOG_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_MESSAGE_DIALOG, GtkMessageDialogClass))

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

declare function gtk_message_dialog_get_type () as GType
declare function gtk_message_dialog_new (byval parent as GtkWindow ptr, byval flags as GtkDialogFlags, byval type as GtkMessageType, byval buttons as GtkButtonsType, byval message_format as zstring ptr, ...) as GtkWidget ptr
declare function gtk_message_dialog_new_with_markup (byval parent as GtkWindow ptr, byval flags as GtkDialogFlags, byval type as GtkMessageType, byval buttons as GtkButtonsType, byval message_format as zstring ptr, ...) as GtkWidget ptr
declare sub gtk_message_dialog_set_markup (byval message_dialog as GtkMessageDialog ptr, byval str as zstring ptr)
declare sub gtk_message_dialog_format_secondary_text (byval message_dialog as GtkMessageDialog ptr, byval message_format as zstring ptr, ...)
declare sub gtk_message_dialog_format_secondary_markup (byval message_dialog as GtkMessageDialog ptr, byval message_format as zstring ptr, ...)

#endif
