''
''
'' gtkfilechooserwidget -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkfilechooserwidget_bi__
#define __gtkfilechooserwidget_bi__

#include once "gtkfilechooser.bi"
#include once "gtkvbox.bi"

#define GTK_TYPE_FILE_CHOOSER_WIDGET (gtk_file_chooser_widget_get_type ())
#define GTK_FILE_CHOOSER_WIDGET(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_FILE_CHOOSER_WIDGET, GtkFileChooserWidget))
#define GTK_FILE_CHOOSER_WIDGET_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_FILE_CHOOSER_WIDGET, GtkFileChooserWidgetClass))
#define GTK_IS_FILE_CHOOSER_WIDGET(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_FILE_CHOOSER_WIDGET))
#define GTK_IS_FILE_CHOOSER_WIDGET_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_FILE_CHOOSER_WIDGET))
#define GTK_FILE_CHOOSER_WIDGET_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_FILE_CHOOSER_WIDGET, GtkFileChooserWidgetClass))

type GtkFileChooserWidget as _GtkFileChooserWidget
type GtkFileChooserWidgetClass as _GtkFileChooserWidgetClass
type GtkFileChooserWidgetPrivate as _GtkFileChooserWidgetPrivate

type _GtkFileChooserWidgetClass
	parent_class as GtkVBoxClass
end type

type _GtkFileChooserWidget
	parent_instance as GtkVBox
	priv as GtkFileChooserWidgetPrivate ptr
end type

declare function gtk_file_chooser_widget_get_type () as GType
declare function gtk_file_chooser_widget_new (byval action as GtkFileChooserAction) as GtkWidget ptr
declare function gtk_file_chooser_widget_new_with_backend (byval action as GtkFileChooserAction, byval backend as zstring ptr) as GtkWidget ptr

#endif
