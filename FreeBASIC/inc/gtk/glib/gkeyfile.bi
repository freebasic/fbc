''
''
'' gkeyfile -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gkeyfile_bi__
#define __gkeyfile_bi__

#include once "gtk/glib/gerror.bi"

enum GKeyFileError
	G_KEY_FILE_ERROR_UNKNOWN_ENCODING
	G_KEY_FILE_ERROR_PARSE
	G_KEY_FILE_ERROR_NOT_FOUND
	G_KEY_FILE_ERROR_KEY_NOT_FOUND
	G_KEY_FILE_ERROR_GROUP_NOT_FOUND
	G_KEY_FILE_ERROR_INVALID_VALUE
end enum


declare function g_key_file_error_quark cdecl alias "g_key_file_error_quark" () as GQuark

type GKeyFile as _GKeyFile

enum GKeyFileFlags
	G_KEY_FILE_NONE = 0
	G_KEY_FILE_KEEP_COMMENTS = 1 shl 0
	G_KEY_FILE_KEEP_TRANSLATIONS = 1 shl 1
end enum


declare function g_key_file_new cdecl alias "g_key_file_new" () as GKeyFile ptr
declare sub g_key_file_free cdecl alias "g_key_file_free" (byval key_file as GKeyFile ptr)
declare sub g_key_file_set_list_separator cdecl alias "g_key_file_set_list_separator" (byval key_file as GKeyFile ptr, byval separator as gchar)
declare function g_key_file_load_from_file cdecl alias "g_key_file_load_from_file" (byval key_file as GKeyFile ptr, byval file as gchar ptr, byval flags as GKeyFileFlags, byval error as GError ptr ptr) as gboolean
declare function g_key_file_load_from_data cdecl alias "g_key_file_load_from_data" (byval key_file as GKeyFile ptr, byval data as gchar ptr, byval length as gsize, byval flags as GKeyFileFlags, byval error as GError ptr ptr) as gboolean
declare function g_key_file_load_from_data_dirs cdecl alias "g_key_file_load_from_data_dirs" (byval key_file as GKeyFile ptr, byval file as gchar ptr, byval full_path as gchar ptr ptr, byval flags as GKeyFileFlags, byval error as GError ptr ptr) as gboolean
declare function g_key_file_to_data cdecl alias "g_key_file_to_data" (byval key_file as GKeyFile ptr, byval length as gsize ptr, byval error as GError ptr ptr) as gchar ptr
declare function g_key_file_get_start_group cdecl alias "g_key_file_get_start_group" (byval key_file as GKeyFile ptr) as gchar ptr
declare function g_key_file_get_groups cdecl alias "g_key_file_get_groups" (byval key_file as GKeyFile ptr, byval length as gsize ptr) as gchar ptr ptr
declare function g_key_file_get_keys cdecl alias "g_key_file_get_keys" (byval key_file as GKeyFile ptr, byval group_name as gchar ptr, byval length as gsize ptr, byval error as GError ptr ptr) as gchar ptr ptr
declare function g_key_file_has_group cdecl alias "g_key_file_has_group" (byval key_file as GKeyFile ptr, byval group_name as gchar ptr) as gboolean
declare function g_key_file_has_key cdecl alias "g_key_file_has_key" (byval key_file as GKeyFile ptr, byval group_name as gchar ptr, byval key as gchar ptr, byval error as GError ptr ptr) as gboolean
declare function g_key_file_get_value cdecl alias "g_key_file_get_value" (byval key_file as GKeyFile ptr, byval group_name as gchar ptr, byval key as gchar ptr, byval error as GError ptr ptr) as gchar ptr
declare sub g_key_file_set_value cdecl alias "g_key_file_set_value" (byval key_file as GKeyFile ptr, byval group_name as gchar ptr, byval key as gchar ptr, byval value as gchar ptr)
declare function g_key_file_get_string cdecl alias "g_key_file_get_string" (byval key_file as GKeyFile ptr, byval group_name as gchar ptr, byval key as gchar ptr, byval error as GError ptr ptr) as gchar ptr
declare sub g_key_file_set_string cdecl alias "g_key_file_set_string" (byval key_file as GKeyFile ptr, byval group_name as gchar ptr, byval key as gchar ptr, byval string as gchar ptr)
declare function g_key_file_get_locale_string cdecl alias "g_key_file_get_locale_string" (byval key_file as GKeyFile ptr, byval group_name as gchar ptr, byval key as gchar ptr, byval locale as gchar ptr, byval error as GError ptr ptr) as gchar ptr
declare sub g_key_file_set_locale_string cdecl alias "g_key_file_set_locale_string" (byval key_file as GKeyFile ptr, byval group_name as gchar ptr, byval key as gchar ptr, byval locale as gchar ptr, byval string as gchar ptr)
declare function g_key_file_get_boolean cdecl alias "g_key_file_get_boolean" (byval key_file as GKeyFile ptr, byval group_name as gchar ptr, byval key as gchar ptr, byval error as GError ptr ptr) as gboolean
declare sub g_key_file_set_boolean cdecl alias "g_key_file_set_boolean" (byval key_file as GKeyFile ptr, byval group_name as gchar ptr, byval key as gchar ptr, byval value as gboolean)
declare function g_key_file_get_integer cdecl alias "g_key_file_get_integer" (byval key_file as GKeyFile ptr, byval group_name as gchar ptr, byval key as gchar ptr, byval error as GError ptr ptr) as gint
declare sub g_key_file_set_integer cdecl alias "g_key_file_set_integer" (byval key_file as GKeyFile ptr, byval group_name as gchar ptr, byval key as gchar ptr, byval value as gint)
declare function g_key_file_get_string_list cdecl alias "g_key_file_get_string_list" (byval key_file as GKeyFile ptr, byval group_name as gchar ptr, byval key as gchar ptr, byval length as gsize ptr, byval error as GError ptr ptr) as gchar ptr ptr
declare sub g_key_file_set_string_list cdecl alias "g_key_file_set_string_list" (byval key_file as GKeyFile ptr, byval group_name as gchar ptr, byval key as gchar ptr, byval list as gchar ptr ptr, byval length as gsize)
declare function g_key_file_get_locale_string_list cdecl alias "g_key_file_get_locale_string_list" (byval key_file as GKeyFile ptr, byval group_name as gchar ptr, byval key as gchar ptr, byval locale as gchar ptr, byval length as gsize ptr, byval error as GError ptr ptr) as gchar ptr ptr
declare sub g_key_file_set_locale_string_list cdecl alias "g_key_file_set_locale_string_list" (byval key_file as GKeyFile ptr, byval group_name as gchar ptr, byval key as gchar ptr, byval locale as gchar ptr, byval list as gchar ptr ptr, byval length as gsize)
declare function g_key_file_get_boolean_list cdecl alias "g_key_file_get_boolean_list" (byval key_file as GKeyFile ptr, byval group_name as gchar ptr, byval key as gchar ptr, byval length as gsize ptr, byval error as GError ptr ptr) as gboolean ptr
declare sub g_key_file_set_boolean_list cdecl alias "g_key_file_set_boolean_list" (byval key_file as GKeyFile ptr, byval group_name as gchar ptr, byval key as gchar ptr, byval list as gboolean ptr, byval length as gsize)
declare function g_key_file_get_integer_list cdecl alias "g_key_file_get_integer_list" (byval key_file as GKeyFile ptr, byval group_name as gchar ptr, byval key as gchar ptr, byval length as gsize ptr, byval error as GError ptr ptr) as gint ptr
declare sub g_key_file_set_integer_list cdecl alias "g_key_file_set_integer_list" (byval key_file as GKeyFile ptr, byval group_name as gchar ptr, byval key as gchar ptr, byval list as gint ptr, byval length as gsize)
declare sub g_key_file_set_comment cdecl alias "g_key_file_set_comment" (byval key_file as GKeyFile ptr, byval group_name as gchar ptr, byval key as gchar ptr, byval comment as gchar ptr, byval error as GError ptr ptr)
declare function g_key_file_get_comment cdecl alias "g_key_file_get_comment" (byval key_file as GKeyFile ptr, byval group_name as gchar ptr, byval key as gchar ptr, byval error as GError ptr ptr) as gchar ptr
declare sub g_key_file_remove_comment cdecl alias "g_key_file_remove_comment" (byval key_file as GKeyFile ptr, byval group_name as gchar ptr, byval key as gchar ptr, byval error as GError ptr ptr)
declare sub g_key_file_remove_key cdecl alias "g_key_file_remove_key" (byval key_file as GKeyFile ptr, byval group_name as gchar ptr, byval key as gchar ptr, byval error as GError ptr ptr)
declare sub g_key_file_remove_group cdecl alias "g_key_file_remove_group" (byval key_file as GKeyFile ptr, byval group_name as gchar ptr, byval error as GError ptr ptr)

#endif
