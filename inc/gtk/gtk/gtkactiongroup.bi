''
''
'' gtkactiongroup -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkactiongroup_bi__
#define __gtkactiongroup_bi__

#include once "gtkaction.bi"
#include once "gtkitemfactory.bi"

#define GTK_TYPE_ACTION_GROUP (gtk_action_group_get_type ())
#define GTK_ACTION_GROUP(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_ACTION_GROUP, GtkActionGroup))
#define GTK_ACTION_GROUP_CLASS(vtable) (G_TYPE_CHECK_CLASS_CAST ((vtable), GTK_TYPE_ACTION_GROUP, GtkActionGroupClass))
#define GTK_IS_ACTION_GROUP(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_ACTION_GROUP))
#define GTK_IS_ACTION_GROUP_CLASS(vtable) (G_TYPE_CHECK_CLASS_TYPE ((vtable), GTK_TYPE_ACTION_GROUP))
#define GTK_ACTION_GROUP_GET_CLASS(inst) (G_TYPE_INSTANCE_GET_CLASS ((inst), GTK_TYPE_ACTION_GROUP, GtkActionGroupClass))

type GtkActionGroup as _GtkActionGroup
type GtkActionGroupPrivate as _GtkActionGroupPrivate
type GtkActionGroupClass as _GtkActionGroupClass
type GtkActionEntry as _GtkActionEntry
type GtkToggleActionEntry as _GtkToggleActionEntry
type GtkRadioActionEntry as _GtkRadioActionEntry

type _GtkActionGroup
	parent as GObject
	private_data as GtkActionGroupPrivate ptr
end type

type _GtkActionGroupClass
	parent_class as GObjectClass
	get_action as function cdecl(byval as GtkActionGroup ptr, byval as zstring ptr) as GtkAction
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

type _GtkActionEntry
	name as zstring ptr
	stock_id as zstring ptr
	label as zstring ptr
	accelerator as zstring ptr
	tooltip as zstring ptr
	callback as GCallback
end type

type _GtkToggleActionEntry
	name as zstring ptr
	stock_id as zstring ptr
	label as zstring ptr
	accelerator as zstring ptr
	tooltip as zstring ptr
	callback as GCallback
	is_active as gboolean
end type

type _GtkRadioActionEntry
	name as zstring ptr
	stock_id as zstring ptr
	label as zstring ptr
	accelerator as zstring ptr
	tooltip as zstring ptr
	value as gint
end type

declare function gtk_action_group_get_type () as GType
declare function gtk_action_group_new (byval name as zstring ptr) as GtkActionGroup ptr
declare function gtk_action_group_get_name (byval action_group as GtkActionGroup ptr) as zstring ptr
declare function gtk_action_group_get_sensitive (byval action_group as GtkActionGroup ptr) as gboolean
declare sub gtk_action_group_set_sensitive (byval action_group as GtkActionGroup ptr, byval sensitive as gboolean)
declare function gtk_action_group_get_visible (byval action_group as GtkActionGroup ptr) as gboolean
declare sub gtk_action_group_set_visible (byval action_group as GtkActionGroup ptr, byval visible as gboolean)
declare function gtk_action_group_get_action (byval action_group as GtkActionGroup ptr, byval action_name as zstring ptr) as GtkAction ptr
declare function gtk_action_group_list_actions (byval action_group as GtkActionGroup ptr) as GList ptr
declare sub gtk_action_group_add_action (byval action_group as GtkActionGroup ptr, byval action as GtkAction ptr)
declare sub gtk_action_group_add_action_with_accel (byval action_group as GtkActionGroup ptr, byval action as GtkAction ptr, byval accelerator as zstring ptr)
declare sub gtk_action_group_remove_action (byval action_group as GtkActionGroup ptr, byval action as GtkAction ptr)
declare sub gtk_action_group_add_actions (byval action_group as GtkActionGroup ptr, byval entries as GtkActionEntry ptr, byval n_entries as guint, byval user_data as gpointer)
declare sub gtk_action_group_add_toggle_actions (byval action_group as GtkActionGroup ptr, byval entries as GtkToggleActionEntry ptr, byval n_entries as guint, byval user_data as gpointer)
declare sub gtk_action_group_add_radio_actions (byval action_group as GtkActionGroup ptr, byval entries as GtkRadioActionEntry ptr, byval n_entries as guint, byval value as gint, byval on_change as GCallback, byval user_data as gpointer)
declare sub gtk_action_group_add_actions_full (byval action_group as GtkActionGroup ptr, byval entries as GtkActionEntry ptr, byval n_entries as guint, byval user_data as gpointer, byval destroy as GDestroyNotify)
declare sub gtk_action_group_add_toggle_actions_full (byval action_group as GtkActionGroup ptr, byval entries as GtkToggleActionEntry ptr, byval n_entries as guint, byval user_data as gpointer, byval destroy as GDestroyNotify)
declare sub gtk_action_group_add_radio_actions_full (byval action_group as GtkActionGroup ptr, byval entries as GtkRadioActionEntry ptr, byval n_entries as guint, byval value as gint, byval on_change as GCallback, byval user_data as gpointer, byval destroy as GDestroyNotify)
declare sub gtk_action_group_set_translate_func (byval action_group as GtkActionGroup ptr, byval func as GtkTranslateFunc, byval data as gpointer, byval notify as GtkDestroyNotify)
declare sub gtk_action_group_set_translation_domain (byval action_group as GtkActionGroup ptr, byval domain as zstring ptr)
declare function gtk_action_group_translate_string (byval action_group as GtkActionGroup ptr, byval string as zstring ptr) as zstring ptr
declare sub _gtk_action_group_emit_connect_proxy (byval action_group as GtkActionGroup ptr, byval action as GtkAction ptr, byval proxy as GtkWidget ptr)
declare sub _gtk_action_group_emit_disconnect_proxy (byval action_group as GtkActionGroup ptr, byval action as GtkAction ptr, byval proxy as GtkWidget ptr)
declare sub _gtk_action_group_emit_pre_activate (byval action_group as GtkActionGroup ptr, byval action as GtkAction ptr)
declare sub _gtk_action_group_emit_post_activate (byval action_group as GtkActionGroup ptr, byval action as GtkAction ptr)

#endif
