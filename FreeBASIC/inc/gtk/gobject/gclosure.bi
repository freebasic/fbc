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

#include once "gtk/gobject/gtype.bi"

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
	ref_count as guint
	meta_marshal as guint
	n_guards as guint
	n_fnotifiers as guint
	n_inotifiers as guint
	in_inotify as guint
	floating as guint
	derivative_flag as guint
	in_marshal as guint
	is_invalid as guint
	marshal as sub cdecl(byval as GClosure ptr, byval as GValue ptr, byval as guint, byval as GValue ptr, byval as gpointer, byval as gpointer)
	data as gpointer
	notifiers as GClosureNotifyData ptr
end type

type _GCClosure
	closure as GClosure
	callback as gpointer
end type

declare function g_cclosure_new cdecl alias "g_cclosure_new" (byval callback_func as GCallback, byval user_data as gpointer, byval destroy_data as GClosureNotify) as GClosure ptr
declare function g_cclosure_new_swap cdecl alias "g_cclosure_new_swap" (byval callback_func as GCallback, byval user_data as gpointer, byval destroy_data as GClosureNotify) as GClosure ptr
declare function g_signal_type_cclosure_new cdecl alias "g_signal_type_cclosure_new" (byval itype as GType, byval struct_offset as guint) as GClosure ptr
declare function g_closure_ref cdecl alias "g_closure_ref" (byval closure as GClosure ptr) as GClosure ptr
declare sub g_closure_sink cdecl alias "g_closure_sink" (byval closure as GClosure ptr)
declare sub g_closure_unref cdecl alias "g_closure_unref" (byval closure as GClosure ptr)
declare function g_closure_new_simple cdecl alias "g_closure_new_simple" (byval sizeof_closure as guint, byval data as gpointer) as GClosure ptr
declare sub g_closure_add_finalize_notifier cdecl alias "g_closure_add_finalize_notifier" (byval closure as GClosure ptr, byval notify_data as gpointer, byval notify_func as GClosureNotify)
declare sub g_closure_remove_finalize_notifier cdecl alias "g_closure_remove_finalize_notifier" (byval closure as GClosure ptr, byval notify_data as gpointer, byval notify_func as GClosureNotify)
declare sub g_closure_add_invalidate_notifier cdecl alias "g_closure_add_invalidate_notifier" (byval closure as GClosure ptr, byval notify_data as gpointer, byval notify_func as GClosureNotify)
declare sub g_closure_remove_invalidate_notifier cdecl alias "g_closure_remove_invalidate_notifier" (byval closure as GClosure ptr, byval notify_data as gpointer, byval notify_func as GClosureNotify)
declare sub g_closure_add_marshal_guards cdecl alias "g_closure_add_marshal_guards" (byval closure as GClosure ptr, byval pre_marshal_data as gpointer, byval pre_marshal_notify as GClosureNotify, byval post_marshal_data as gpointer, byval post_marshal_notify as GClosureNotify)
declare sub g_closure_set_marshal cdecl alias "g_closure_set_marshal" (byval closure as GClosure ptr, byval marshal as GClosureMarshal)
declare sub g_closure_set_meta_marshal cdecl alias "g_closure_set_meta_marshal" (byval closure as GClosure ptr, byval marshal_data as gpointer, byval meta_marshal as GClosureMarshal)
declare sub g_closure_invalidate cdecl alias "g_closure_invalidate" (byval closure as GClosure ptr)
declare sub g_closure_invoke cdecl alias "g_closure_invoke" (byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as GValue ptr, byval invocation_hint as gpointer)

#endif
