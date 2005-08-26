''
''
'' gtkfilechooserdialog -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkfilechooserdialog_bi__
#define __gtkfilechooserdialog_bi__

#include once "gtk/gtk/gtkdialog.bi"
#include once "gtk/gtk/gtkfilechooser.bi"

type GtkFileChooserDialog as _GtkFileChooserDialog
type GtkFileChooserDialogClass as _GtkFileChooserDialogClass
type GtkFileChooserDialogPrivate as _GtkFileChooserDialogPrivate

type _GtkFileChooserDialogClass
	parent_class as GtkDialogClass
end type

type _GtkFileChooserDialog
	parent_instance as GtkDialog
	priv as GtkFileChooserDialogPrivate ptr
end type

declare function gtk_file_chooser_dialog_get_type cdecl alias "gtk_file_chooser_dialog_get_type" () as GType
declare function gtk_file_chooser_dialog_new cdecl alias "gtk_file_chooser_dialog_new" (byval title as zstring ptr, byval parent as GtkWindow ptr, byval action as GtkFileChooserAction, byval first_button_text as zstring ptr, ...) as GtkWidget ptr
declare function gtk_file_chooser_dialog_new_with_backend cdecl alias "gtk_file_chooser_dialog_new_with_backend" (byval title as zstring ptr, byval parent as GtkWindow ptr, byval action as GtkFileChooserAction, byval backend as zstring ptr, byval first_button_text as zstring ptr, ...) as GtkWidget ptr

#endif
