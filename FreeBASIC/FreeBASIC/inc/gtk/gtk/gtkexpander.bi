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

#include once "gtkbin.bi"

#define GTK_TYPE_EXPANDER (gtk_expander_get_type ())
#define GTK_EXPANDER(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_EXPANDER, GtkExpander))
#define GTK_EXPANDER_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_EXPANDER, GtkExpanderClass))
#define GTK_IS_EXPANDER(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_EXPANDER))
#define GTK_IS_EXPANDER_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_EXPANDER))
#define GTK_EXPANDER_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_EXPANDER, GtkExpanderClass))

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

declare function gtk_expander_get_type () as GType
declare function gtk_expander_new (byval label as zstring ptr) as GtkWidget ptr
declare function gtk_expander_new_with_mnemonic (byval label as zstring ptr) as GtkWidget ptr
declare sub gtk_expander_set_expanded (byval expander as GtkExpander ptr, byval expanded as gboolean)
declare function gtk_expander_get_expanded (byval expander as GtkExpander ptr) as gboolean
declare sub gtk_expander_set_spacing (byval expander as GtkExpander ptr, byval spacing as gint)
declare function gtk_expander_get_spacing (byval expander as GtkExpander ptr) as gint
declare sub gtk_expander_set_label (byval expander as GtkExpander ptr, byval label as zstring ptr)
declare function gtk_expander_get_label (byval expander as GtkExpander ptr) as zstring ptr
declare sub gtk_expander_set_use_underline (byval expander as GtkExpander ptr, byval use_underline as gboolean)
declare function gtk_expander_get_use_underline (byval expander as GtkExpander ptr) as gboolean
declare sub gtk_expander_set_use_markup (byval expander as GtkExpander ptr, byval use_markup as gboolean)
declare function gtk_expander_get_use_markup (byval expander as GtkExpander ptr) as gboolean
declare sub gtk_expander_set_label_widget (byval expander as GtkExpander ptr, byval label_widget as GtkWidget ptr)
declare function gtk_expander_get_label_widget (byval expander as GtkExpander ptr) as GtkWidget ptr

#endif
