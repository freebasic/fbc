''
''
'' gdkproperty -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gdkproperty_bi__
#define __gdkproperty_bi__

#include once "gtk/gdk/gdktypes.bi"

enum GdkPropMode
	GDK_PROP_MODE_REPLACE
	GDK_PROP_MODE_PREPEND
	GDK_PROP_MODE_APPEND
end enum


declare function gdk_atom_intern cdecl alias "gdk_atom_intern" (byval atom_name as string, byval only_if_exists as gboolean) as GdkAtom
declare function gdk_atom_name cdecl alias "gdk_atom_name" (byval atom as GdkAtom) as zstring ptr
declare function gdk_property_get cdecl alias "gdk_property_get" (byval window as GdkWindow ptr, byval property as GdkAtom, byval type as GdkAtom, byval offset as gulong, byval length as gulong, byval pdelete as gint, byval actual_property_type as GdkAtom ptr, byval actual_format as gint ptr, byval actual_length as gint ptr, byval data as guchar ptr ptr) as gboolean
declare sub gdk_property_change cdecl alias "gdk_property_change" (byval window as GdkWindow ptr, byval property as GdkAtom, byval type as GdkAtom, byval format as gint, byval mode as GdkPropMode, byval data as guchar ptr, byval nelements as gint)
declare sub gdk_property_delete cdecl alias "gdk_property_delete" (byval window as GdkWindow ptr, byval property as GdkAtom)
declare function gdk_text_property_to_text_list cdecl alias "gdk_text_property_to_text_list" (byval encoding as GdkAtom, byval format as gint, byval text as guchar ptr, byval length as gint, byval list as zstring ptr ptr ptr) as gint
declare function gdk_text_property_to_utf8_list cdecl alias "gdk_text_property_to_utf8_list" (byval encoding as GdkAtom, byval format as gint, byval text as guchar ptr, byval length as gint, byval list as zstring ptr ptr ptr) as gint
declare function gdk_utf8_to_compound_text cdecl alias "gdk_utf8_to_compound_text" (byval str as string, byval encoding as GdkAtom ptr, byval format as gint ptr, byval ctext as guchar ptr ptr, byval length as gint ptr) as gboolean
declare function gdk_string_to_compound_text cdecl alias "gdk_string_to_compound_text" (byval str as string, byval encoding as GdkAtom ptr, byval format as gint ptr, byval ctext as guchar ptr ptr, byval length as gint ptr) as gint
declare function gdk_text_property_to_text_list_for_display cdecl alias "gdk_text_property_to_text_list_for_display" (byval display as GdkDisplay ptr, byval encoding as GdkAtom, byval format as gint, byval text as guchar ptr, byval length as gint, byval list as zstring ptr ptr ptr) as gint
declare function gdk_text_property_to_utf8_list_for_display cdecl alias "gdk_text_property_to_utf8_list_for_display" (byval display as GdkDisplay ptr, byval encoding as GdkAtom, byval format as gint, byval text as guchar ptr, byval length as gint, byval list as zstring ptr ptr ptr) as gint
declare function gdk_utf8_to_string_target cdecl alias "gdk_utf8_to_string_target" (byval str as string) as zstring ptr
declare function gdk_string_to_compound_text_for_display cdecl alias "gdk_string_to_compound_text_for_display" (byval display as GdkDisplay ptr, byval str as string, byval encoding as GdkAtom ptr, byval format as gint ptr, byval ctext as guchar ptr ptr, byval length as gint ptr) as gint
declare function gdk_utf8_to_compound_text_for_display cdecl alias "gdk_utf8_to_compound_text_for_display" (byval display as GdkDisplay ptr, byval str as string, byval encoding as GdkAtom ptr, byval format as gint ptr, byval ctext as guchar ptr ptr, byval length as gint ptr) as gboolean
declare sub gdk_free_text_list cdecl alias "gdk_free_text_list" (byval list as zstring ptr ptr)
declare sub gdk_free_compound_text cdecl alias "gdk_free_compound_text" (byval ctext as guchar ptr)

#endif
