''
''
'' goption -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __goption_bi__
#define __goption_bi__

#include once "gerror.bi"
#include once "gquark.bi"

type GOptionContext as _GOptionContext
type GOptionGroup as _GOptionGroup
type GOptionEntry as _GOptionEntry

enum GOptionFlags
	G_OPTION_FLAG_HIDDEN = 1 shl 0
	G_OPTION_FLAG_IN_MAIN = 1 shl 1
	G_OPTION_FLAG_REVERSE = 1 shl 2
end enum


enum GOptionArg
	G_OPTION_ARG_NONE
	G_OPTION_ARG_STRING
	G_OPTION_ARG_INT
	G_OPTION_ARG_CALLBACK
	G_OPTION_ARG_FILENAME
	G_OPTION_ARG_STRING_ARRAY
	G_OPTION_ARG_FILENAME_ARRAY
end enum

type GOptionArgFunc as function cdecl(byval as zstring ptr, byval as zstring ptr, byval as gpointer, byval as GError ptr ptr) as gboolean
type GOptionParseFunc as function cdecl(byval as GOptionContext ptr, byval as GOptionGroup ptr, byval as gpointer, byval as GError ptr ptr) as gboolean
type GOptionErrorFunc as sub cdecl(byval as GOptionContext ptr, byval as GOptionGroup ptr, byval as gpointer, byval as GError ptr ptr)

enum GOptionError
	G_OPTION_ERROR_UNKNOWN_OPTION
	G_OPTION_ERROR_BAD_VALUE
	G_OPTION_ERROR_FAILED
end enum


declare function g_option_error_quark () as GQuark

type _GOptionEntry
	long_name as zstring ptr
	short_name as gchar
	flags as gint
	arg as GOptionArg
	arg_data as gpointer
	description as zstring ptr
	arg_description as zstring ptr
end type

#define G_OPTION_REMAINING ""

declare function g_option_context_new (byval parameter_string as zstring ptr) as GOptionContext ptr
declare sub g_option_context_free (byval context as GOptionContext ptr)
declare sub g_option_context_set_help_enabled (byval context as GOptionContext ptr, byval help_enabled as gboolean)
declare function g_option_context_get_help_enabled (byval context as GOptionContext ptr) as gboolean
declare sub g_option_context_set_ignore_unknown_options (byval context as GOptionContext ptr, byval ignore_unknown as gboolean)
declare function g_option_context_get_ignore_unknown_options (byval context as GOptionContext ptr) as gboolean
declare sub g_option_context_add_main_entries (byval context as GOptionContext ptr, byval entries as GOptionEntry ptr, byval translation_domain as zstring ptr)
declare function g_option_context_parse (byval context as GOptionContext ptr, byval argc as gint ptr, byval argv as zstring ptr ptr ptr, byval error as GError ptr ptr) as gboolean
declare sub g_option_context_add_group (byval context as GOptionContext ptr, byval group as GOptionGroup ptr)
declare sub g_option_context_set_main_group (byval context as GOptionContext ptr, byval group as GOptionGroup ptr)
declare function g_option_context_get_main_group (byval context as GOptionContext ptr) as GOptionGroup ptr
declare function g_option_group_new (byval name as zstring ptr, byval description as zstring ptr, byval help_description as zstring ptr, byval user_data as gpointer, byval destroy as GDestroyNotify) as GOptionGroup ptr
declare sub g_option_group_set_parse_hooks (byval group as GOptionGroup ptr, byval pre_parse_func as GOptionParseFunc, byval post_parse_func as GOptionParseFunc)
declare sub g_option_group_set_error_hook (byval group as GOptionGroup ptr, byval error_func as GOptionErrorFunc)
declare sub g_option_group_free (byval group as GOptionGroup ptr)
declare sub g_option_group_add_entries (byval group as GOptionGroup ptr, byval entries as GOptionEntry ptr)
declare sub g_option_group_set_translate_func (byval group as GOptionGroup ptr, byval func as GTranslateFunc, byval data as gpointer, byval destroy_notify as GDestroyNotify)
declare sub g_option_group_set_translation_domain (byval group as GOptionGroup ptr, byval domain as zstring ptr)

#endif
