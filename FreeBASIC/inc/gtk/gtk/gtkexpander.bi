''
''
'' gtkexpander -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkexpander_bi__
#define __gtkexpander_bi__

#include once "gtk/gtk/gtkbin.bi"

type GtkExpander as _GtkExpander
type GtkExpanderClass as _GtkExpanderClass
type GtkExpanderPrivate as _GtkExpanderPrivate

type _GtkExpander
	bin as GtkBin
	priv as GtkExpanderPrivate ptr
end type

type _GtkExpanderClass
	parent_class as GtkBinClass
	activate as sub cdecl(byval as GtkExpander ptr)
end type

declare function gtk_expander_get_type cdecl alias "gtk_expander_get_type" () as GType
declare function gtk_expander_new cdecl alias "gtk_expander_new" (byval label as gchar ptr) as GtkWidget ptr
declare function gtk_expander_new_with_mnemonic cdecl alias "gtk_expander_new_with_mnemonic" (byval label as gchar ptr) as GtkWidget ptr
declare sub gtk_expander_set_expanded cdecl alias "gtk_expander_set_expanded" (byval expander as GtkExpander ptr, byval expanded as gboolean)
declare function gtk_expander_get_expanded cdecl alias "gtk_expander_get_expanded" (byval expander as GtkExpander ptr) as gboolean
declare sub gtk_expander_set_spacing cdecl alias "gtk_expander_set_spacing" (byval expander as GtkExpander ptr, byval spacing as gint)
declare function gtk_expander_get_spacing cdecl alias "gtk_expander_get_spacing" (byval expander as GtkExpander ptr) as gint
declare sub gtk_expander_set_label cdecl alias "gtk_expander_set_label" (byval expander as GtkExpander ptr, byval label as gchar ptr)
declare function gtk_expander_get_label cdecl alias "gtk_expander_get_label" (byval expander as GtkExpander ptr) as gchar ptr
declare sub gtk_expander_set_use_underline cdecl alias "gtk_expander_set_use_underline" (byval expander as GtkExpander ptr, byval use_underline as gboolean)
declare function gtk_expander_get_use_underline cdecl alias "gtk_expander_get_use_underline" (byval expander as GtkExpander ptr) as gboolean
declare sub gtk_expander_set_use_markup cdecl alias "gtk_expander_set_use_markup" (byval expander as GtkExpander ptr, byval use_markup as gboolean)
declare function gtk_expander_get_use_markup cdecl alias "gtk_expander_get_use_markup" (byval expander as GtkExpander ptr) as gboolean
declare sub gtk_expander_set_label_widget cdecl alias "gtk_expander_set_label_widget" (byval expander as GtkExpander ptr, byval label_widget as GtkWidget ptr)
declare function gtk_expander_get_label_widget cdecl alias "gtk_expander_get_label_widget" (byval expander as GtkExpander ptr) as GtkWidget ptr

#endif
