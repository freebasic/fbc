''
''
'' gtkbindings -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkbindings_bi__
#define __gtkbindings_bi__

#include once "gtk/gdk.bi"
#include once "gtkobject.bi"
#include once "gtkenums.bi"

type GtkBindingSet as _GtkBindingSet
type GtkBindingEntry as _GtkBindingEntry
type GtkBindingSignal as _GtkBindingSignal
type GtkBindingArg as _GtkBindingArg

type _GtkBindingSet
	set_name as zstring ptr
	priority as gint
	widget_path_pspecs as GSList ptr
	widget_class_pspecs as GSList ptr
	class_branch_pspecs as GSList ptr
	entries as GtkBindingEntry ptr
	current as GtkBindingEntry ptr
	parsed:1 as guint
end type

type _GtkBindingEntry
	keyval as guint
	modifiers as GdkModifierType
	binding_set as GtkBindingSet ptr
	destroyed:1 as guint
	in_emission:1 as guint
	set_next as GtkBindingEntry ptr
	hash_next as GtkBindingEntry ptr
	signals as GtkBindingSignal ptr
end type

type _GtkBindingSignal
	next as GtkBindingSignal ptr
	signal_name as zstring ptr
	n_args as guint
	args as GtkBindingArg ptr
end type

union _GtkBindingArg_d
	long_data as glong
	double_data as gdouble
	string_data as zstring ptr
end union

type _GtkBindingArg
	arg_type as GType
	d as _GtkBindingArg_d
end type


declare function gtk_binding_set_new (byval set_name as zstring ptr) as GtkBindingSet ptr
declare function gtk_binding_set_by_class (byval object_class as gpointer) as GtkBindingSet ptr
declare function gtk_binding_set_find (byval set_name as zstring ptr) as GtkBindingSet ptr
declare function gtk_bindings_activate (byval object as GtkObject ptr, byval keyval as guint, byval modifiers as GdkModifierType) as gboolean
declare function gtk_bindings_activate_event (byval object as GtkObject ptr, byval event as GdkEventKey ptr) as gboolean
declare function gtk_binding_set_activate (byval binding_set as GtkBindingSet ptr, byval keyval as guint, byval modifiers as GdkModifierType, byval object as GtkObject ptr) as gboolean
declare sub gtk_binding_entry_clear (byval binding_set as GtkBindingSet ptr, byval keyval as guint, byval modifiers as GdkModifierType)
declare sub gtk_binding_entry_add_signal (byval binding_set as GtkBindingSet ptr, byval keyval as guint, byval modifiers as GdkModifierType, byval signal_name as zstring ptr, byval n_args as guint, ...)
declare sub gtk_binding_set_add_path (byval binding_set as GtkBindingSet ptr, byval path_type as GtkPathType, byval path_pattern as zstring ptr, byval priority as GtkPathPriorityType)
declare sub gtk_binding_entry_remove (byval binding_set as GtkBindingSet ptr, byval keyval as guint, byval modifiers as GdkModifierType)
declare sub gtk_binding_entry_add_signall (byval binding_set as GtkBindingSet ptr, byval keyval as guint, byval modifiers as GdkModifierType, byval signal_name as zstring ptr, byval binding_args as GSList ptr)
declare function gtk_binding_parse_binding (byval scanner as GScanner ptr) as guint
declare sub _gtk_binding_reset_parsed ()
declare function _gtk_binding_signal_new (byval signal_name as zstring ptr, byval itype as GType, byval signal_flags as GSignalFlags, byval handler as GCallback, byval accumulator as GSignalAccumulator, byval accu_data as gpointer, byval c_marshaller as GSignalCMarshaller, byval return_type as GType, byval n_params as guint, ...) as guint

#endif
