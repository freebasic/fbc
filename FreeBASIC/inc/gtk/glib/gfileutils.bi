''
''
'' gfileutils -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gfileutils_bi__
#define __gfileutils_bi__

#include once "gerror.bi"

enum GFileError
	G_FILE_ERROR_EXIST
	G_FILE_ERROR_ISDIR
	G_FILE_ERROR_ACCES
	G_FILE_ERROR_NAMETOOLONG
	G_FILE_ERROR_NOENT
	G_FILE_ERROR_NOTDIR
	G_FILE_ERROR_NXIO
	G_FILE_ERROR_NODEV
	G_FILE_ERROR_ROFS
	G_FILE_ERROR_TXTBSY
	G_FILE_ERROR_FAULT
	G_FILE_ERROR_LOOP
	G_FILE_ERROR_NOSPC
	G_FILE_ERROR_NOMEM
	G_FILE_ERROR_MFILE
	G_FILE_ERROR_NFILE
	G_FILE_ERROR_BADF
	G_FILE_ERROR_INVAL
	G_FILE_ERROR_PIPE
	G_FILE_ERROR_AGAIN
	G_FILE_ERROR_INTR
	G_FILE_ERROR_IO
	G_FILE_ERROR_PERM
	G_FILE_ERROR_NOSYS
	G_FILE_ERROR_FAILED
end enum


enum GFileTest
	G_FILE_TEST_IS_REGULAR = 1 shl 0
	G_FILE_TEST_IS_SYMLINK = 1 shl 1
	G_FILE_TEST_IS_DIR = 1 shl 2
	G_FILE_TEST_IS_EXECUTABLE = 1 shl 3
	G_FILE_TEST_EXISTS = 1 shl 4
end enum


declare function g_file_error_quark () as GQuark
declare function g_file_error_from_errno (byval err_no as gint) as GFileError
declare function g_file_test_utf8 (byval filename as zstring ptr, byval test as GFileTest) as gboolean
declare function g_file_get_contents_utf8 (byval filename as zstring ptr, byval contents as zstring ptr ptr, byval length as gsize ptr, byval error as GError ptr ptr) as gboolean
declare function g_file_read_link (byval filename as zstring ptr, byval error as GError ptr ptr) as zstring ptr
declare function g_mkstemp_utf8 (byval tmpl as zstring ptr) as gint
declare function g_file_open_tmp_utf8 (byval tmpl as zstring ptr, byval name_used as zstring ptr ptr, byval error as GError ptr ptr) as gint
declare function g_build_path (byval separator as zstring ptr, byval first_element as zstring ptr, ...) as zstring ptr
declare function g_build_filename (byval first_element as zstring ptr, ...) as zstring ptr

#endif
