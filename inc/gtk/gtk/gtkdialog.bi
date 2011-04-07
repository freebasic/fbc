''
''
'' gtkdialog -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkdialog_bi__
#define __gtkdialog_bi__

#include once "gtk/gdk.bi"
#include once "gtkwindow.bi"

#define GTK_TYPE_DIALOG gtk_dialog_get_type()
#define GTK_DIALOG(obj) G_TYPE_CHECK_INSTANCE_CAST (obj, GTK_TYPE_DIALOG, GtkDialog)
#define GTK_DIALOG_CLASS(klass) G_TYPE_CHECK_CLASS_CAST (klass, GTK_TYPE_DIALOG, GtkDialogClass)
#define GTK_IS_DIALOG(obj) G_TYPE_CHECK_INSTANCE_TYPE (obj, GTK_TYPE_DIALOG)
#define GTK_IS_DIALOG_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE (klass, GTK_TYPE_DIALOG)
#define GTK_DIALOG_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS (obj, GTK_TYPE_DIALOG, GtkDialogClass)

enum GtkDialogFlags
	GTK_DIALOG_MODAL = 1 shl 0
	GTK_DIALOG_DESTROY_WITH_PARENT = 1 shl 1
	GTK_DIALOG_NO_SEPARATOR = 1 shl 2
end enum


enum GtkResponseType
	GTK_RESPONSE_NONE = -1
	GTK_RESPONSE_REJECT = -2
	GTK_RESPONSE_ACCEPT = -3
	GTK_RESPONSE_DELETE_EVENT = -4
	GTK_RESPONSE_OK = -5
	GTK_RESPONSE_CANCEL = -6
	GTK_RESPONSE_CLOSE = -7
	GTK_RESPONSE_YES = -8
	GTK_RESPONSE_NO = -9
	GTK_RESPONSE_APPLY = -10
	GTK_RESPONSE_HELP = -11
end enum

type GtkDialog as _GtkDialog
type GtkDialogClass as _GtkDialogClass

type _GtkDialog
	window as GtkWindow
	vbox as GtkWidget ptr
	action_area as GtkWidget ptr
	separator as GtkWidget ptr
end type

type _GtkDialogClass
	parent_class as GtkWindowClass
	response as sub cdecl(byval as GtkDialog ptr, byval as gint)
	close as sub cdecl(byval as GtkDialog ptr)
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_dialog_get_type () as GType
declare function gtk_dialog_new () as GtkWidget ptr
declare function gtk_dialog_new_with_buttons (byval title as zstring ptr, byval parent as GtkWindow ptr, byval flags as GtkDialogFlags, byval first_button_text as zstring ptr, ...) as GtkWidget ptr
declare sub gtk_dialog_add_action_widget (byval dialog as GtkDialog ptr, byval child as GtkWidget ptr, byval response_id as gint)
declare function gtk_dialog_add_button (byval dialog as GtkDialog ptr, byval button_text as zstring ptr, byval response_id as gint) as GtkWidget ptr
declare sub gtk_dialog_add_buttons (byval dialog as GtkDialog ptr, byval first_button_text as zstring ptr, ...)
declare sub gtk_dialog_set_response_sensitive (byval dialog as GtkDialog ptr, byval response_id as gint, byval setting as gboolean)
declare sub gtk_dialog_set_default_response (byval dialog as GtkDialog ptr, byval response_id as gint)
declare sub gtk_dialog_set_has_separator (byval dialog as GtkDialog ptr, byval setting as gboolean)
declare function gtk_dialog_get_has_separator (byval dialog as GtkDialog ptr) as gboolean
declare function gtk_alternative_dialog_button_order (byval screen as GdkScreen ptr) as gboolean
declare sub gtk_dialog_set_alternative_button_order (byval dialog as GtkDialog ptr, byval first_response_id as gint, ...)
declare sub gtk_dialog_set_alternative_button_order_from_array (byval dialog as GtkDialog ptr, byval n_params as gint, byval new_order as gint ptr)
declare sub gtk_dialog_response (byval dialog as GtkDialog ptr, byval response_id as gint)
declare function gtk_dialog_run (byval dialog as GtkDialog ptr) as gint
declare sub _gtk_dialog_set_ignore_separator (byval dialog as GtkDialog ptr, byval ignore_separator as gboolean)
declare function _gtk_dialog_get_response_for_widget (byval dialog as GtkDialog ptr, byval widget as GtkWidget ptr) as gint

#endif
