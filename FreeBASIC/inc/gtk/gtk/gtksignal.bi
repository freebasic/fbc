''
''
'' gtksignal -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtksignal_bi__
#define __gtksignal_bi__

#include once "gtk/gtk/gtkenums.bi"
#include once "gtk/gtk/gtkobject.bi"
#include once "gtk/gtk/gtkmarshal.bi"

declare function gtk_signal_newv cdecl alias "gtk_signal_newv" (byval name as gchar ptr, byval signal_flags as GtkSignalRunType, byval object_type as GtkType, byval function_offset as guint, byval marshaller as GtkSignalMarshaller, byval return_val as GtkType, byval n_args as guint, byval args as GtkType ptr) as guint
declare function gtk_signal_new cdecl alias "gtk_signal_new" (byval name as gchar ptr, byval signal_flags as GtkSignalRunType, byval object_type as GtkType, byval function_offset as guint, byval marshaller as GtkSignalMarshaller, byval return_val as GtkType, byval n_args as guint, ...) as guint
declare sub gtk_signal_emit_stop_by_name cdecl alias "gtk_signal_emit_stop_by_name" (byval object as GtkObject ptr, byval name as gchar ptr)
declare sub gtk_signal_connect_object_while_alive cdecl alias "gtk_signal_connect_object_while_alive" (byval object as GtkObject ptr, byval name as gchar ptr, byval func as GtkSignalFunc, byval alive_object as GtkObject ptr)
declare sub gtk_signal_connect_while_alive cdecl alias "gtk_signal_connect_while_alive" (byval object as GtkObject ptr, byval name as gchar ptr, byval func as GtkSignalFunc, byval func_data as gpointer, byval alive_object as GtkObject ptr)
declare function gtk_signal_connect_full cdecl alias "gtk_signal_connect_full" (byval object as GtkObject ptr, byval name as gchar ptr, byval func as GtkSignalFunc, byval unsupported as GtkCallbackMarshal, byval data as gpointer, byval destroy_func as GtkDestroyNotify, byval object_signal as gint, byval after as gint) as gulong
declare sub gtk_signal_emitv cdecl alias "gtk_signal_emitv" (byval object as GtkObject ptr, byval signal_id as guint, byval args as GtkArg ptr)
declare sub gtk_signal_emit cdecl alias "gtk_signal_emit" (byval object as GtkObject ptr, byval signal_id as guint, ...)
declare sub gtk_signal_emit_by_name cdecl alias "gtk_signal_emit_by_name" (byval object as GtkObject ptr, byval name as gchar ptr, ...)
declare sub gtk_signal_emitv_by_name cdecl alias "gtk_signal_emitv_by_name" (byval object as GtkObject ptr, byval name as gchar ptr, byval args as GtkArg ptr)
declare sub gtk_signal_compat_matched cdecl alias "gtk_signal_compat_matched" (byval object as GtkObject ptr, byval func as GtkSignalFunc, byval data as gpointer, byval match as GSignalMatchType, byval action as guint)

#endif
