''
''
'' gdkspawn -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gdkspawn_bi__
#define __gdkspawn_bi__

#include once "gdkscreen.bi"
#include once "gtk/glib/gspawn.bi"

declare function gdk_spawn_on_screen (byval screen as GdkScreen ptr, byval working_directory as zstring ptr, byval argv as zstring ptr ptr, byval envp as zstring ptr ptr, byval flags as GSpawnFlags, byval child_setup as GSpawnChildSetupFunc, byval user_data as gpointer, byval child_pid as gint ptr, byval error as GError ptr ptr) as gboolean
declare function gdk_spawn_on_screen_with_pipes (byval screen as GdkScreen ptr, byval working_directory as zstring ptr, byval argv as zstring ptr ptr, byval envp as zstring ptr ptr, byval flags as GSpawnFlags, byval child_setup as GSpawnChildSetupFunc, byval user_data as gpointer, byval child_pid as gint ptr, byval standard_input as gint ptr, byval standard_output as gint ptr, byval standard_error as gint ptr, byval error as GError ptr ptr) as gboolean
declare function gdk_spawn_command_line_on_screen (byval screen as GdkScreen ptr, byval command_line as zstring ptr, byval error as GError ptr ptr) as gboolean

#endif
