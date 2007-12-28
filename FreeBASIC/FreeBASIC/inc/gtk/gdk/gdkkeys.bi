''
''
'' gdkkeys -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gdkkeys_bi__
#define __gdkkeys_bi__

#include once "gdktypes.bi"

#define GDK_TYPE_KEYMAP (gdk_keymap_get_type ())
#define GDK_KEYMAP(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GDK_TYPE_KEYMAP, GdkKeymap))
#define GDK_KEYMAP_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GDK_TYPE_KEYMAP, GdkKeymapClass))
#define GDK_IS_KEYMAP(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GDK_TYPE_KEYMAP))
#define GDK_IS_KEYMAP_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GDK_TYPE_KEYMAP))
#define GDK_KEYMAP_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GDK_TYPE_KEYMAP, GdkKeymapClass))

type GdkKeymapKey as _GdkKeymapKey

type _GdkKeymapKey
	keycode as guint
	group as gint
	level as gint
end type

type GdkKeymap as _GdkKeymap
type GdkKeymapClass as _GdkKeymapClass

type _GdkKeymap
	parent_instance as GObject
	display as GdkDisplay ptr
end type

type _GdkKeymapClass
	parent_class as GObjectClass
	direction_changed as sub cdecl(byval as GdkKeymap ptr)
	keys_changed as sub cdecl(byval as GdkKeymap ptr)
end type

declare function gdk_keymap_get_type () as GType
declare function gdk_keymap_get_default () as GdkKeymap ptr
declare function gdk_keymap_get_for_display (byval display as GdkDisplay ptr) as GdkKeymap ptr
declare function gdk_keymap_lookup_key (byval keymap as GdkKeymap ptr, byval key as GdkKeymapKey ptr) as guint
declare function gdk_keymap_translate_keyboard_state (byval keymap as GdkKeymap ptr, byval hardware_keycode as guint, byval state as GdkModifierType, byval group as gint, byval keyval as guint ptr, byval effective_group as gint ptr, byval level as gint ptr, byval consumed_modifiers as GdkModifierType ptr) as gboolean
declare function gdk_keymap_get_entries_for_keyval (byval keymap as GdkKeymap ptr, byval keyval as guint, byval keys as GdkKeymapKey ptr ptr, byval n_keys as gint ptr) as gboolean
declare function gdk_keymap_get_entries_for_keycode (byval keymap as GdkKeymap ptr, byval hardware_keycode as guint, byval keys as GdkKeymapKey ptr ptr, byval keyvals as guint ptr ptr, byval n_entries as gint ptr) as gboolean
declare function gdk_keymap_get_direction (byval keymap as GdkKeymap ptr) as PangoDirection
declare function gdk_keyval_name (byval keyval as guint) as zstring ptr
declare function gdk_keyval_from_name (byval keyval_name as zstring ptr) as guint
declare sub gdk_keyval_convert_case (byval symbol as guint, byval lower as guint ptr, byval upper as guint ptr)
declare function gdk_keyval_to_upper (byval keyval as guint) as guint
declare function gdk_keyval_to_lower (byval keyval as guint) as guint
declare function gdk_keyval_is_upper (byval keyval as guint) as gboolean
declare function gdk_keyval_is_lower (byval keyval as guint) as gboolean
declare function gdk_keyval_to_unicode (byval keyval as guint) as guint32
declare function gdk_unicode_to_keyval (byval wc as guint32) as guint

#endif
