''
''
'' gtkaccelgroup -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkaccelgroup_bi__
#define __gtkaccelgroup_bi__

#include once "gtk/gdk.bi"
#include once "gtkenums.bi"

#define GTK_TYPE_ACCEL_GROUP (gtk_accel_group_get_type ())
#define GTK_ACCEL_GROUP(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GTK_TYPE_ACCEL_GROUP, GtkAccelGroup))
#define GTK_ACCEL_GROUP_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_ACCEL_GROUP, GtkAccelGroupClass))
#define GTK_IS_ACCEL_GROUP(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GTK_TYPE_ACCEL_GROUP))
#define GTK_IS_ACCEL_GROUP_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_ACCEL_GROUP))
#define GTK_ACCEL_GROUP_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_ACCEL_GROUP, GtkAccelGroupClass))


enum GtkAccelFlags
	GTK_ACCEL_VISIBLE = 1 shl 0
	GTK_ACCEL_LOCKED = 1 shl 1
	GTK_ACCEL_MASK = &h07
end enum

type GtkAccelGroup as _GtkAccelGroup
type GtkAccelGroupClass as _GtkAccelGroupClass
type GtkAccelKey as _GtkAccelKey
type GtkAccelGroupEntry as _GtkAccelGroupEntry
type GtkAccelGroupActivate as function cdecl(byval as GtkAccelGroup ptr, byval as GObject ptr, byval as guint, byval as GdkModifierType) as gboolean
type GtkAccelGroupFindFunc as function cdecl(byval as GtkAccelKey ptr, byval as GClosure ptr, byval as gpointer) as gboolean

type _GtkAccelGroup
	parent as GObject
	lock_count as guint
	modifier_mask as GdkModifierType
	acceleratables as GSList ptr
	n_accels as guint
	priv_accels as GtkAccelGroupEntry ptr
end type

type _GtkAccelGroupClass
	parent_class as GObjectClass
	accel_changed as sub cdecl(byval as GtkAccelGroup ptr, byval as guint, byval as GdkModifierType, byval as GClosure ptr)
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

type _GtkAccelKey
	accel_key as guint
	accel_mods as GdkModifierType
	accel_flags as guint
end type

declare function gtk_accel_group_get_type () as GType
declare function gtk_accel_group_new () as GtkAccelGroup ptr
declare sub gtk_accel_group_lock (byval accel_group as GtkAccelGroup ptr)
declare sub gtk_accel_group_unlock (byval accel_group as GtkAccelGroup ptr)
declare sub gtk_accel_group_connect (byval accel_group as GtkAccelGroup ptr, byval accel_key as guint, byval accel_mods as GdkModifierType, byval accel_flags as GtkAccelFlags, byval closure as GClosure ptr)
declare sub gtk_accel_group_connect_by_path (byval accel_group as GtkAccelGroup ptr, byval accel_path as zstring ptr, byval closure as GClosure ptr)
declare function gtk_accel_group_disconnect (byval accel_group as GtkAccelGroup ptr, byval closure as GClosure ptr) as gboolean
declare function gtk_accel_group_disconnect_key (byval accel_group as GtkAccelGroup ptr, byval accel_key as guint, byval accel_mods as GdkModifierType) as gboolean
declare function gtk_accel_group_activate (byval accel_group as GtkAccelGroup ptr, byval accel_quark as GQuark, byval acceleratable as GObject ptr, byval accel_key as guint, byval accel_mods as GdkModifierType) as gboolean
declare sub _gtk_accel_group_attach (byval accel_group as GtkAccelGroup ptr, byval object as GObject ptr)
declare sub _gtk_accel_group_detach (byval accel_group as GtkAccelGroup ptr, byval object as GObject ptr)
declare function gtk_accel_groups_activate (byval object as GObject ptr, byval accel_key as guint, byval accel_mods as GdkModifierType) as gboolean
declare function gtk_accel_groups_from_object (byval object as GObject ptr) as GSList ptr
declare function gtk_accel_group_find (byval accel_group as GtkAccelGroup ptr, byval find_func as GtkAccelGroupFindFunc, byval data as gpointer) as GtkAccelKey ptr
declare function gtk_accel_group_from_accel_closure (byval closure as GClosure ptr) as GtkAccelGroup ptr
declare function gtk_accelerator_valid (byval keyval as guint, byval modifiers as GdkModifierType) as gboolean
declare sub gtk_accelerator_parse (byval accelerator as zstring ptr, byval accelerator_key as guint ptr, byval accelerator_mods as GdkModifierType ptr)
declare function gtk_accelerator_name (byval accelerator_key as guint, byval accelerator_mods as GdkModifierType) as zstring ptr
declare function gtk_accelerator_get_label (byval accelerator_key as guint, byval accelerator_mods as GdkModifierType) as zstring ptr
declare sub gtk_accelerator_set_default_mod_mask (byval default_mod_mask as GdkModifierType)
declare function gtk_accelerator_get_default_mod_mask () as guint
declare function gtk_accel_group_query (byval accel_group as GtkAccelGroup ptr, byval accel_key as guint, byval accel_mods as GdkModifierType, byval n_entries as guint ptr) as GtkAccelGroupEntry ptr
declare sub _gtk_accel_group_reconnect (byval accel_group as GtkAccelGroup ptr, byval accel_path_quark as GQuark)

type _GtkAccelGroupEntry
	key as GtkAccelKey
	closure as GClosure ptr
	accel_path_quark as GQuark
end type

#define	gtk_accel_group_ref	g_object_ref
#define	gtk_accel_group_unref g_object_unref

#endif
