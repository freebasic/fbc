''
''
'' gmessages -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gmessages_bi__
#define __gmessages_bi__

#include once "gtypes.bi"
#include once "gmacros.bi"

'''''''' declare function g_printf_string_upper_bound (byval format as zstring ptr, byval args as va_list) as gsize

#define G_LOG_LEVEL_USER_SHIFT (8)

enum GLogLevelFlags
	G_LOG_FLAG_RECURSION = 1 shl 0
	G_LOG_FLAG_FATAL = 1 shl 1
	G_LOG_LEVEL_ERROR = 1 shl 2
	G_LOG_LEVEL_CRITICAL = 1 shl 3
	G_LOG_LEVEL_WARNING = 1 shl 4
	G_LOG_LEVEL_MESSAGE = 1 shl 5
	G_LOG_LEVEL_INFO = 1 shl 6
	G_LOG_LEVEL_DEBUG = 1 shl 7
	G_LOG_LEVEL_MASK =  not (G_LOG_FLAG_RECURSION or G_LOG_FLAG_FATAL)
end enum

type GLogFunc as sub cdecl(byval as zstring ptr, byval as GLogLevelFlags, byval as zstring ptr, byval as gpointer)

declare function g_log_set_handler (byval log_domain as zstring ptr, byval log_levels as GLogLevelFlags, byval log_func as GLogFunc, byval user_data as gpointer) as guint
declare sub g_log_remove_handler (byval log_domain as zstring ptr, byval handler_id as guint)
declare sub g_log_default_handler (byval log_domain as zstring ptr, byval log_level as GLogLevelFlags, byval message as zstring ptr, byval unused_data as gpointer)
declare function g_log_set_default_handler (byval log_func as GLogFunc, byval user_data as gpointer) as GLogFunc
declare sub g_log (byval log_domain as zstring ptr, byval log_level as GLogLevelFlags, byval format as zstring ptr, ...)
''''''' declare sub g_logv (byval log_domain as zstring ptr, byval log_level as GLogLevelFlags, byval format as zstring ptr, byval args as va_list)
declare function g_log_set_fatal_mask (byval log_domain as zstring ptr, byval fatal_mask as GLogLevelFlags) as GLogLevelFlags
declare function g_log_set_always_fatal (byval fatal_mask as GLogLevelFlags) as GLogLevelFlags
declare sub _g_log_fallback_handler (byval log_domain as zstring ptr, byval log_level as GLogLevelFlags, byval message as zstring ptr, byval unused_data as gpointer)
declare sub g_return_if_fail_warning (byval log_domain as zstring ptr, byval pretty_function as zstring ptr, byval expression as zstring ptr)
declare sub g_assert_warning (byval log_domain as zstring ptr, byval file as zstring ptr, byval line as integer, byval pretty_function as zstring ptr, byval expression as zstring ptr)

type GPrintFunc as sub cdecl(byval as zstring ptr)

declare sub g_print (byval format as zstring ptr, ...)
declare function g_set_print_handler (byval func as GPrintFunc) as GPrintFunc
declare sub g_printerr (byval format as zstring ptr, ...)
declare function g_set_printerr_handler (byval func as GPrintFunc) as GPrintFunc

#endif
