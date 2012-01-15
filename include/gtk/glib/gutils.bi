''
''
'' gutils -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gutils_bi__
#define __gutils_bi__

#include once "gtypes.bi"

#define G_DIR_SEPARATOR asc($"\")
#define G_DIR_SEPARATOR_S $"\"
#define G_SEARCHPATH_SEPARATOR asc(";")
#define G_SEARCHPATH_SEPARATOR_S ";"

declare function g_get_user_name_utf8 () as zstring ptr
declare function g_get_real_name_utf8 () as zstring ptr
declare function g_get_home_dir_utf8 () as zstring ptr
declare function g_get_tmp_dir_utf8 () as zstring ptr
declare function g_get_prgname () as zstring ptr
declare sub g_set_prgname (byval prgname as zstring ptr)
declare function g_get_application_name () as zstring ptr
declare sub g_set_application_name (byval application_name as zstring ptr)
declare function g_get_user_data_dir () as zstring ptr
declare function g_get_user_config_dir () as zstring ptr
declare function g_get_user_cache_dir () as zstring ptr
declare function g_get_system_data_dirs () as zstring ptr ptr
declare function g_get_system_config_dirs () as zstring ptr ptr
declare function g_get_language_names () as zstring ptr ptr

type GDebugKey as _GDebugKey

type _GDebugKey
	key as zstring ptr
	value as guint
end type

declare function g_parse_debug_string (byval string as zstring ptr, byval keys as GDebugKey ptr, byval nkeys as guint) as guint
declare function g_snprintf (byval string as zstring ptr, byval n as gulong, byval format as zstring ptr, ...) as gint
''''''' declare function g_vsnprintf (byval string as zstring ptr, byval n as gulong, byval format as zstring ptr, byval args as va_list) as gint
declare function g_path_is_absolute (byval file_name as zstring ptr) as gboolean
declare function g_path_skip_root (byval file_name as zstring ptr) as zstring ptr
declare function g_basename (byval file_name as zstring ptr) as zstring ptr
declare function g_get_current_dir_utf8 () as zstring ptr
declare function g_path_get_basename (byval file_name as zstring ptr) as zstring ptr
declare function g_path_get_dirname (byval file_name as zstring ptr) as zstring ptr
declare sub g_nullify_pointer (byval nullify_location as gpointer ptr)
declare function g_getenv_utf8 (byval variable as zstring ptr) as zstring ptr
declare function g_setenv_utf8 (byval variable as zstring ptr, byval value as zstring ptr, byval overwrite as gboolean) as gboolean
declare sub g_unsetenv_utf8 (byval variable as zstring ptr)

type GVoidFunc as sub cdecl()

declare sub g_atexit (byval func as GVoidFunc)
declare function g_find_program_in_path_utf8 (byval program as zstring ptr) as zstring ptr
declare function g_bit_nth_lsf (byval mask as gulong, byval nth_bit as gint) as gint
declare function g_bit_nth_msf (byval mask as gulong, byval nth_bit as gint) as gint
declare function g_bit_storage (byval number as gulong) as guint

type GTrashStack as _GTrashStack

type _GTrashStack
	next as GTrashStack ptr
end type

declare sub g_trash_stack_push (byval stack_p as GTrashStack ptr ptr, byval data_p as gpointer)
declare function g_trash_stack_pop (byval stack_p as GTrashStack ptr ptr) as gpointer
declare function g_trash_stack_peek (byval stack_p as GTrashStack ptr ptr) as gpointer
declare function g_trash_stack_height (byval stack_p as GTrashStack ptr ptr) as guint
declare function glib_check_version (byval required_major as guint, byval required_minor as guint, byval required_micro as guint) as zstring ptr

#define g_dirname g_path_get_dirname
#define g_get_current_dir g_get_current_dir_utf8

#endif
