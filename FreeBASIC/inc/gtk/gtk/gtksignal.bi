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

#include once "gtkenums.bi"
#include once "gtkobject.bi"
#include once "gtkmarshal.bi"

#define GTK_SIGNAL_OFFSET GTK_STRUCT_OFFSET
#define	gtk_signal_lookup(name_,object_type)	g_signal_lookup(name_,object_type)
#define	gtk_signal_name(signal_id) g_signal_name(signal_id)
#define	gtk_signal_emit_stop(object,signal_id) g_signal_stop_emission(object,signal_id,0)
#define	gtk_signal_connect(object,name_,func,func_data) gtk_signal_connect_full(object,name_,func,0,func_data,0,0,0)
#define	gtk_signal_connect_after(object,name_,func,func_data) gtk_signal_connect_full(object,name_,func,0,func_data,0,0,1)
#define	gtk_signal_connect_object(object,name_,func,slot_object) gtk_signal_connect_full(object,name_,func,0,slot_object,0,1,0)
#define	gtk_signal_connect_object_after(object,name_,func,slot_object) gtk_signal_connect_full(object,name_,func,0,slot_object,0,1,1)
#define	gtk_signal_disconnect(object,handler_id) g_signal_handler_disconnect(object,handler_id)
#define	gtk_signal_handler_block(object,handler_id) g_signal_handler_block(object,handler_id)
#define	gtk_signal_handler_unblock(object,handler_id) g_signal_handler_unblock(object,handler_id)
#define	gtk_signal_disconnect_by_func(object,func,data_) gtk_signal_compat_matched(object,func,data_,(G_SIGNAL_MATCH_FUNC or G_SIGNAL_MATCH_DATA),0)
#define	gtk_signal_disconnect_by_data(object,data_) gtk_signal_compat_matched(object,0,data_,G_SIGNAL_MATCH_DATA,0)
#define	gtk_signal_handler_block_by_func(object,func,data_) gtk_signal_compat_matched(object,func,data_,(G_SIGNAL_MATCH_FUNC or G_SIGNAL_MATCH_DATA),1)
#define	gtk_signal_handler_block_by_data(object,data_) gtk_signal_compat_matched(object,0,data_,G_SIGNAL_MATCH_DATA,1)
#define	gtk_signal_handler_unblock_by_func(object,func,data_) gtk_signal_compat_matched(object,func,data_,(G_SIGNAL_MATCH_FUNC or G_SIGNAL_MATCH_DATA), 2)
#define	gtk_signal_handler_unblock_by_data(object,data_) gtk_signal_compat_matched(object,0,data_,G_SIGNAL_MATCH_DATA,2)
#define	gtk_signal_handler_pending(object,signal_id,may_be_blocked) g_signal_has_handler_pending(object,signal_id,0,may_be_blocked)
#define	gtk_signal_handler_pending_by_func(object,signal_id,may_be_blocked,func,data_) (g_signal_handler_find (object,G_SIGNAL_MATCH_ID or G_SIGNAL_MATCH_FUNC or G_SIGNAL_MATCH_DATA or iif(may_be_blocked, 0, G_SIGNAL_MATCH_UNBLOCKED),signal_id,0,0,func,data_) <> 0)

declare function gtk_signal_newv (byval name as zstring ptr, byval signal_flags as GtkSignalRunType, byval object_type as GtkType, byval function_offset as guint, byval marshaller as GtkSignalMarshaller, byval return_val as GtkType, byval n_args as guint, byval args as GtkType ptr) as guint
declare function gtk_signal_new (byval name as zstring ptr, byval signal_flags as GtkSignalRunType, byval object_type as GtkType, byval function_offset as guint, byval marshaller as GtkSignalMarshaller, byval return_val as GtkType, byval n_args as guint, ...) as guint
declare sub gtk_signal_emit_stop_by_name (byval object as GtkObject ptr, byval name as zstring ptr)
declare sub gtk_signal_connect_object_while_alive (byval object as GtkObject ptr, byval name as zstring ptr, byval func as GtkSignalFunc, byval alive_object as GtkObject ptr)
declare sub gtk_signal_connect_while_alive (byval object as GtkObject ptr, byval name as zstring ptr, byval func as GtkSignalFunc, byval func_data as gpointer, byval alive_object as GtkObject ptr)
declare function gtk_signal_connect_full (byval object as GtkObject ptr, byval name as zstring ptr, byval func as GtkSignalFunc, byval unsupported as GtkCallbackMarshal, byval data as gpointer, byval destroy_func as GtkDestroyNotify, byval object_signal as gint, byval after as gint) as gulong
declare sub gtk_signal_emitv (byval object as GtkObject ptr, byval signal_id as guint, byval args as GtkArg ptr)
declare sub gtk_signal_emit (byval object as GtkObject ptr, byval signal_id as guint, ...)
declare sub gtk_signal_emit_by_name (byval object as GtkObject ptr, byval name as zstring ptr, ...)
declare sub gtk_signal_emitv_by_name (byval object as GtkObject ptr, byval name as zstring ptr, byval args as GtkArg ptr)
declare sub gtk_signal_compat_matched (byval object as GtkObject ptr, byval func as GtkSignalFunc, byval data as gpointer, byval match as GSignalMatchType, byval action as guint)

#define	gtk_signal_default_marshaller g_cclosure_marshal_VOID__VOID

#endif
