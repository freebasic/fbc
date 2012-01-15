''
''
'' gclosure -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gclosure_bi__
#define __gclosure_bi__

#include once "gtype.bi"

#define	G_CLOSURE_NEEDS_MARSHAL(closure) (cast(GClosure ptr,closure)->marshal = NULL)
#define	G_CLOSURE_N_NOTIFIERS(cl) ((cl)->meta_marshal + ((cl)->n_guards shl 1) + (cl)->n_fnotifiers + (cl)->n_inotifiers)
#define	G_CCLOSURE_SWAP_DATA(cclosure) (cast(GClosure ptr,closure)->derivative_flag)
#define	G_CALLBACK(f) (cast(GCallback,f))

type GClosure as _GClosure
type GClosureNotifyData as _GClosureNotifyData
type GCallback as sub cdecl()
type GClosureNotify as sub cdecl(byval as gpointer, byval as GClosure ptr)
type GClosureMarshal as sub cdecl(byval as GClosure ptr, byval as GValue ptr, byval as guint, byval as GValue ptr, byval as gpointer, byval as gpointer)
type GCClosure as _GCClosure

type _GClosureNotifyData
	data as gpointer
	notify as GClosureNotify
end type

type _GClosure
	ref_count:15 as guint
	meta_marshal:1 as guint
	n_guards:1 as guint
	n_fnotifiers:2 as guint
	n_inotifiers:8 as guint
	in_inotify:1 as guint
	floating:1 as guint
	derivative_flag:1 as guint
	in_marshal:1 as guint
	is_invalid:1 as guint
	marshal as sub cdecl(byval as GClosure ptr, byval as GValue ptr, byval as guint, byval as GValue ptr, byval as gpointer, byval as gpointer)
	data as gpointer
	notifiers as GClosureNotifyData ptr
end type

type _GCClosure
	closure as GClosure
	callback as gpointer
end type

declare function g_cclosure_new (byval callback_func as GCallback, byval user_data as gpointer, byval destroy_data as GClosureNotify) as GClosure ptr
declare function g_cclosure_new_swap (byval callback_func as GCallback, byval user_data as gpointer, byval destroy_data as GClosureNotify) as GClosure ptr
declare function g_signal_type_cclosure_new (byval itype as GType, byval struct_offset as guint) as GClosure ptr
declare function g_closure_ref (byval closure as GClosure ptr) as GClosure ptr
declare sub g_closure_sink (byval closure as GClosure ptr)
declare sub g_closure_unref (byval closure as GClosure ptr)
declare function g_closure_new_simple (byval sizeof_closure as guint, byval data as gpointer) as GClosure ptr
declare sub g_closure_add_finalize_notifier (byval closure as GClosure ptr, byval notify_data as gpointer, byval notify_func as GClosureNotify)
declare sub g_closure_remove_finalize_notifier (byval closure as GClosure ptr, byval notify_data as gpointer, byval notify_func as GClosureNotify)
declare sub g_closure_add_invalidate_notifier (byval closure as GClosure ptr, byval notify_data as gpointer, byval notify_func as GClosureNotify)
declare sub g_closure_remove_invalidate_notifier (byval closure as GClosure ptr, byval notify_data as gpointer, byval notify_func as GClosureNotify)
declare sub g_closure_add_marshal_guards (byval closure as GClosure ptr, byval pre_marshal_data as gpointer, byval pre_marshal_notify as GClosureNotify, byval post_marshal_data as gpointer, byval post_marshal_notify as GClosureNotify)
declare sub g_closure_set_marshal (byval closure as GClosure ptr, byval marshal as GClosureMarshal)
declare sub g_closure_set_meta_marshal (byval closure as GClosure ptr, byval marshal_data as gpointer, byval meta_marshal as GClosureMarshal)
declare sub g_closure_invalidate (byval closure as GClosure ptr)
declare sub g_closure_invoke (byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as GValue ptr, byval invocation_hint as gpointer)

#endif
