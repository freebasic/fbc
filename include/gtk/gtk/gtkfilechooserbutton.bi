''
''
'' gtkfilechooserbutton -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkfilechooserbutton_bi__
#define __gtkfilechooserbutton_bi__

#include once "gtkhbox.bi"
#include once "gtkfilechooser.bi"

#define GTK_TYPE_FILE_CHOOSER_BUTTON (gtk_file_chooser_button_get_type ())
#define GTK_FILE_CHOOSER_BUTTON(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GTK_TYPE_FILE_CHOOSER_BUTTON, GtkFileChooserButton))
#define GTK_FILE_CHOOSER_BUTTON_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_FILE_CHOOSER_BUTTON, GtkFileChooserButtonClass))
#define GTK_IS_FILE_CHOOSER_BUTTON(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GTK_TYPE_FILE_CHOOSER_BUTTON))
#define GTK_IS_FILE_CHOOSER_BUTTON_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_FILE_CHOOSER_BUTTON))
#define GTK_FILE_CHOOSER_BUTTON_GET_CLASS(object) (G_TYPE_INSTANCE_GET_CLASS ((object), GTK_TYPE_FILE_CHOOSER_BUTTON, GtkFileChooserButtonClass))

type GtkFileChooserButton as _GtkFileChooserButton
type GtkFileChooserButtonPrivate as _GtkFileChooserButtonPrivate
type GtkFileChooserButtonClass as _GtkFileChooserButtonClass

type _GtkFileChooserButton
	parent as GtkHBox
	priv as GtkFileChooserButtonPrivate ptr
end type

type _GtkFileChooserButtonClass
	parent_class as GtkHBoxClass
	__gtk_reserved1 as any ptr
	__gtk_reserved2 as any ptr
	__gtk_reserved3 as any ptr
	__gtk_reserved4 as any ptr
	__gtk_reserved5 as any ptr
	__gtk_reserved6 as any ptr
	__gtk_reserved7 as any ptr
	__gtk_reserved8 as any ptr
end type

declare function gtk_file_chooser_button_get_type () as GType
declare function gtk_file_chooser_button_new (byval title as zstring ptr, byval action as GtkFileChooserAction) as GtkWidget ptr
declare function gtk_file_chooser_button_new_with_backend (byval title as zstring ptr, byval action as GtkFileChooserAction, byval backend as zstring ptr) as GtkWidget ptr
declare function gtk_file_chooser_button_new_with_dialog (byval dialog as GtkWidget ptr) as GtkWidget ptr
declare function gtk_file_chooser_button_get_title (byval button as GtkFileChooserButton ptr) as zstring ptr
declare sub gtk_file_chooser_button_set_title (byval button as GtkFileChooserButton ptr, byval title as zstring ptr)
declare function gtk_file_chooser_button_get_width_chars (byval button as GtkFileChooserButton ptr) as gint
declare sub gtk_file_chooser_button_set_width_chars (byval button as GtkFileChooserButton ptr, byval n_chars as gint)

#endif
