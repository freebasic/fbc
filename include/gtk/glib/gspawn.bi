''
''
'' gspawn -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gspawn_bi__
#define __gspawn_bi__

#include once "gerror.bi"

enum GSpawnError
	G_SPAWN_ERROR_FORK
	G_SPAWN_ERROR_READ
	G_SPAWN_ERROR_CHDIR
	G_SPAWN_ERROR_ACCES
	G_SPAWN_ERROR_PERM
	G_SPAWN_ERROR_2BIG
	G_SPAWN_ERROR_NOEXEC
	G_SPAWN_ERROR_NAMETOOLONG
	G_SPAWN_ERROR_NOENT
	G_SPAWN_ERROR_NOMEM
	G_SPAWN_ERROR_NOTDIR
	G_SPAWN_ERROR_LOOP
	G_SPAWN_ERROR_TXTBUSY
	G_SPAWN_ERROR_IO
	G_SPAWN_ERROR_NFILE
	G_SPAWN_ERROR_MFILE
	G_SPAWN_ERROR_INVAL
	G_SPAWN_ERROR_ISDIR
	G_SPAWN_ERROR_LIBBAD
	G_SPAWN_ERROR_FAILED
end enum

type GSpawnChildSetupFunc as sub cdecl(byval as gpointer)

enum GSpawnFlags
	G_SPAWN_LEAVE_DESCRIPTORS_OPEN = 1 shl 0
	G_SPAWN_DO_NOT_REAP_CHILD = 1 shl 1
	G_SPAWN_SEARCH_PATH = 1 shl 2
	G_SPAWN_STDOUT_TO_DEV_NULL = 1 shl 3
	G_SPAWN_STDERR_TO_DEV_NULL = 1 shl 4
	G_SPAWN_CHILD_INHERITS_STDIN = 1 shl 5
	G_SPAWN_FILE_AND_ARGV_ZERO = 1 shl 6
end enum


declare function g_spawn_error_quark () as GQuark
declare function g_spawn_async (byval working_directory as zstring ptr, byval argv as zstring ptr ptr, byval envp as zstring ptr ptr, byval flags as GSpawnFlags, byval child_setup as GSpawnChildSetupFunc, byval user_data as gpointer, byval child_pid as GPid ptr, byval error as GError ptr ptr) as gboolean
declare function g_spawn_async_with_pipes (byval working_directory as zstring ptr, byval argv as zstring ptr ptr, byval envp as zstring ptr ptr, byval flags as GSpawnFlags, byval child_setup as GSpawnChildSetupFunc, byval user_data as gpointer, byval child_pid as GPid ptr, byval standard_input as gint ptr, byval standard_output as gint ptr, byval standard_error as gint ptr, byval error as GError ptr ptr) as gboolean
declare function g_spawn_sync (byval working_directory as zstring ptr, byval argv as zstring ptr ptr, byval envp as zstring ptr ptr, byval flags as GSpawnFlags, byval child_setup as GSpawnChildSetupFunc, byval user_data as gpointer, byval standard_output as zstring ptr ptr, byval standard_error as zstring ptr ptr, byval exit_status as gint ptr, byval error as GError ptr ptr) as gboolean
declare function g_spawn_command_line_sync (byval command_line as zstring ptr, byval standard_output as zstring ptr ptr, byval standard_error as zstring ptr ptr, byval exit_status as gint ptr, byval error as GError ptr ptr) as gboolean
declare function g_spawn_command_line_async (byval command_line as zstring ptr, byval error as GError ptr ptr) as gboolean
declare sub g_spawn_close_pid (byval pid as GPid)

#endif
