''
''
'' gshell -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gshell_bi__
#define __gshell_bi__

#include once "gtk/glib/gerror.bi"

enum GShellError
	G_SHELL_ERROR_BAD_QUOTING
	G_SHELL_ERROR_EMPTY_STRING
	G_SHELL_ERROR_FAILED
end enum


declare function g_shell_error_quark cdecl alias "g_shell_error_quark" () as GQuark
declare function g_shell_quote cdecl alias "g_shell_quote" (byval unquoted_string as gchar ptr) as gchar ptr
declare function g_shell_unquote cdecl alias "g_shell_unquote" (byval quoted_string as gchar ptr, byval error as GError ptr ptr) as gchar ptr
declare function g_shell_parse_argv cdecl alias "g_shell_parse_argv" (byval command_line as gchar ptr, byval argcp as gint ptr, byval argvp as gchar ptr ptr ptr, byval error as GError ptr ptr) as gboolean

#endif
