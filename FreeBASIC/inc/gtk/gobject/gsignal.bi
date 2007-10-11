''
''
'' gsignal -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsignal_bi__
#define __gsignal_bi__

#include once "gclosure.bi"
#include once "gvalue.bi"
#include once "gparam.bi"
#include once "gmarshal.bi"

type GSignalQuery as _GSignalQuery
type GSignalInvocationHint as _GSignalInvocationHint
type GSignalCMarshaller as GClosureMarshal
type GSignalEmissionHook as function cdecl(byval as GSignalInvocationHint ptr, byval as guint, byval as GValue ptr, byval as gpointer) as gboolean
type GSignalAccumulator as function cdecl(byval as GSignalInvocationHint ptr, byval as GValue ptr, byval as GValue ptr, byval as gpointer) as gboolean

enum GSignalFlags
	G_SIGNAL_RUN_FIRST = 1 shl 0
	G_SIGNAL_RUN_LAST = 1 shl 1
	G_SIGNAL_RUN_CLEANUP = 1 shl 2
	G_SIGNAL_NO_RECURSE = 1 shl 3
	G_SIGNAL_DETAILED = 1 shl 4
	G_SIGNAL_ACTION = 1 shl 5
	G_SIGNAL_NO_HOOKS = 1 shl 6
end enum


#define G_SIGNAL_FLAGS_MASK &h7f

enum GConnectFlags
	G_CONNECT_AFTER = 1 shl 0
	G_CONNECT_SWAPPED = 1 shl 1
end enum


enum GSignalMatchType
	G_SIGNAL_MATCH_ID = 1 shl 0
	G_SIGNAL_MATCH_DETAIL = 1 shl 1
	G_SIGNAL_MATCH_CLOSURE = 1 shl 2
	G_SIGNAL_MATCH_FUNC = 1 shl 3
	G_SIGNAL_MATCH_DATA = 1 shl 4
	G_SIGNAL_MATCH_UNBLOCKED = 1 shl 5
end enum


#define G_SIGNAL_MATCH_MASK &h3f

type _GSignalInvocationHint
	signal_id as guint
	detail as GQuark
	run_type as GSignalFlags
end type

type _GSignalQuery
	signal_id as guint
	signal_name as zstring ptr
	itype as GType
	signal_flags as GSignalFlags
	return_type as GType
	n_params as guint
	param_types as GType ptr
end type

declare function g_signal_newv (byval signal_name as zstring ptr, byval itype as GType, byval signal_flags as GSignalFlags, byval class_closure as GClosure ptr, byval accumulator as GSignalAccumulator, byval accu_data as gpointer, byval c_marshaller as GSignalCMarshaller, byval return_type as GType, byval n_params as guint, byval param_types as GType ptr) as guint
''''''' declare function g_signal_new_valist (byval signal_name as zstring ptr, byval itype as GType, byval signal_flags as GSignalFlags, byval class_closure as GClosure ptr, byval accumulator as GSignalAccumulator, byval accu_data as gpointer, byval c_marshaller as GSignalCMarshaller, byval return_type as GType, byval n_params as guint, byval args as va_list) as guint
declare function g_signal_new (byval signal_name as zstring ptr, byval itype as GType, byval signal_flags as GSignalFlags, byval class_offset as guint, byval accumulator as GSignalAccumulator, byval accu_data as gpointer, byval c_marshaller as GSignalCMarshaller, byval return_type as GType, byval n_params as guint, ...) as guint
declare sub g_signal_emitv (byval instance_and_params as GValue ptr, byval signal_id as guint, byval detail as GQuark, byval return_value as GValue ptr)
''''''' declare sub g_signal_emit_valist (byval instance as gpointer, byval signal_id as guint, byval detail as GQuark, byval var_args as va_list)
declare sub g_signal_emit (byval instance as gpointer, byval signal_id as guint, byval detail as GQuark, ...)
declare sub g_signal_emit_by_name (byval instance as gpointer, byval detailed_signal as zstring ptr, ...)
declare function g_signal_lookup (byval name as zstring ptr, byval itype as GType) as guint
declare function g_signal_name (byval signal_id as guint) as zstring ptr
declare sub g_signal_query (byval signal_id as guint, byval query as GSignalQuery ptr)
declare function g_signal_list_ids (byval itype as GType, byval n_ids as guint ptr) as guint ptr
declare function g_signal_parse_name (byval detailed_signal as zstring ptr, byval itype as GType, byval signal_id_p as guint ptr, byval detail_p as GQuark ptr, byval force_detail_quark as gboolean) as gboolean
declare function g_signal_get_invocation_hint (byval instance as gpointer) as GSignalInvocationHint ptr
declare sub g_signal_stop_emission (byval instance as gpointer, byval signal_id as guint, byval detail as GQuark)
declare sub g_signal_stop_emission_by_name (byval instance as gpointer, byval detailed_signal as zstring ptr)
declare function g_signal_add_emission_hook (byval signal_id as guint, byval detail as GQuark, byval hook_func as GSignalEmissionHook, byval hook_data as gpointer, byval data_destroy as GDestroyNotify) as gulong
declare sub g_signal_remove_emission_hook (byval signal_id as guint, byval hook_id as gulong)
declare function g_signal_has_handler_pending (byval instance as gpointer, byval signal_id as guint, byval detail as GQuark, byval may_be_blocked as gboolean) as gboolean
declare function g_signal_connect_closure_by_id (byval instance as gpointer, byval signal_id as guint, byval detail as GQuark, byval closure as GClosure ptr, byval after as gboolean) as gulong
declare function g_signal_connect_closure (byval instance as gpointer, byval detailed_signal as zstring ptr, byval closure as GClosure ptr, byval after as gboolean) as gulong
declare function g_signal_connect_data (byval instance as gpointer, byval detailed_signal as zstring ptr, byval c_handler as GCallback, byval data as gpointer, byval destroy_data as GClosureNotify, byval connect_flags as GConnectFlags) as gulong
declare sub g_signal_handler_block (byval instance as gpointer, byval handler_id as gulong)
declare sub g_signal_handler_unblock (byval instance as gpointer, byval handler_id as gulong)
declare sub g_signal_handler_disconnect (byval instance as gpointer, byval handler_id as gulong)
declare function g_signal_handler_is_connected (byval instance as gpointer, byval handler_id as gulong) as gboolean
declare function g_signal_handler_find (byval instance as gpointer, byval mask as GSignalMatchType, byval signal_id as guint, byval detail as GQuark, byval closure as GClosure ptr, byval func as gpointer, byval data as gpointer) as gulong
declare function g_signal_handlers_block_matched (byval instance as gpointer, byval mask as GSignalMatchType, byval signal_id as guint, byval detail as GQuark, byval closure as GClosure ptr, byval func as gpointer, byval data as gpointer) as guint
declare function g_signal_handlers_unblock_matched (byval instance as gpointer, byval mask as GSignalMatchType, byval signal_id as guint, byval detail as GQuark, byval closure as GClosure ptr, byval func as gpointer, byval data as gpointer) as guint
declare function g_signal_handlers_disconnect_matched (byval instance as gpointer, byval mask as GSignalMatchType, byval signal_id as guint, byval detail as GQuark, byval closure as GClosure ptr, byval func as gpointer, byval data as gpointer) as guint
declare sub g_signal_override_class_closure (byval signal_id as guint, byval instance_type as GType, byval class_closure as GClosure ptr)
declare sub g_signal_chain_from_overridden (byval instance_and_params as GValue ptr, byval return_value as GValue ptr)
declare function g_signal_accumulator_true_handled (byval ihint as GSignalInvocationHint ptr, byval return_accu as GValue ptr, byval handler_return as GValue ptr, byval dummy as gpointer) as gboolean
declare sub g_signal_handlers_destroy (byval instance as gpointer)
declare sub _g_signals_destroy (byval itype as GType)

#define g_signal_connect(i,s,h,d) g_signal_connect_data(i,s,h,d,0,0)
#define g_signal_connect_after(i,s,h,d) g_signal_connect_data(i,s,h,d,NULL,G_CONNECT_AFTER)
#define g_signal_connect_swapped(i,s,h,d) g_signal_connect_data(i,s,h,d,NULL,G_CONNECT_SWAPPED)
#define	g_signal_handlers_disconnect_by_func(i,f,d) g_signal_handlers_disconnect_matched(i,G_SIGNAL_MATCH_FUNC or G_SIGNAL_MATCH_DATA,0,0,NULL,f,d)
#define	g_signal_handlers_block_by_func(i,f,d) g_signal_handlers_block_matched(i,G_SIGNAL_MATCH_FUNC or G_SIGNAL_MATCH_DATA,0,0,NULL,f,d)
#define	g_signal_handlers_unblock_by_func(i,f,d) g_signal_handlers_unblock_matched(i,G_SIGNAL_MATCH_FUNC or G_SIGNAL_MATCH_DATA,0,0,NULL,f,d)

#endif
