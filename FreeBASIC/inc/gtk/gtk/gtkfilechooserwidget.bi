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

#include once "gtk/gtk/gtkfilechooser.bi"
#include once "gtk/gtk/gtkvbox.bi"

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

declare function gtk_file_chooser_widget_get_type cdecl alias "gtk_file_chooser_widget_get_type" () as GType
declare function gtk_file_chooser_widget_new cdecl alias "gtk_file_chooser_widget_new" (byval action as GtkFileChooserAction) as GtkWidget ptr
declare function gtk_file_chooser_widget_new_with_backend cdecl alias "gtk_file_chooser_widget_new_with_backend" (byval action as GtkFileChooserAction, byval backend as gchar ptr) as GtkWidget ptr

#endif
