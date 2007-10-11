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

#include once "gtkdialog.bi"
#include once "gtkfilechooser.bi"

#define GTK_TYPE_FILE_CHOOSER_DIALOG (gtk_file_chooser_dialog_get_type ())
#define GTK_FILE_CHOOSER_DIALOG(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_FILE_CHOOSER_DIALOG, GtkFileChooserDialog))
#define GTK_FILE_CHOOSER_DIALOG_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_FILE_CHOOSER_DIALOG, GtkFileChooserDialogClass))
#define GTK_IS_FILE_CHOOSER_DIALOG(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_FILE_CHOOSER_DIALOG))
#define GTK_IS_FILE_CHOOSER_DIALOG_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_FILE_CHOOSER_DIALOG))
#define GTK_FILE_CHOOSER_DIALOG_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_FILE_CHOOSER_DIALOG, GtkFileChooserDialogClass))

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

declare function gtk_file_chooser_dialog_get_type () as GType
declare function gtk_file_chooser_dialog_new (byval title as zstring ptr, byval parent as GtkWindow ptr, byval action as GtkFileChooserAction, byval first_button_text as zstring ptr, ...) as GtkWidget ptr
declare function gtk_file_chooser_dialog_new_with_backend (byval title as zstring ptr, byval parent as GtkWindow ptr, byval action as GtkFileChooserAction, byval backend as zstring ptr, byval first_button_text as zstring ptr, ...) as GtkWidget ptr

#endif
