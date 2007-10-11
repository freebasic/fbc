''
''
'' gdir -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gdir_bi__
#define __gdir_bi__

#include once "gerror.bi"

type GDir as _GDir

declare function g_dir_open_utf8 (byval path as zstring ptr, byval flags as guint, byval error as GError ptr ptr) as GDir ptr
declare function g_dir_read_name_utf8 (byval dir as GDir ptr) as zstring ptr
declare sub g_dir_rewind (byval dir as GDir ptr)
declare sub g_dir_close (byval dir as GDir ptr)

#endif
