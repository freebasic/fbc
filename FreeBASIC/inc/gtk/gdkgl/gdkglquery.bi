''
''
'' gdkglquery -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gdkglquery_bi__
#define __gdkglquery_bi__

#include once "gdkgldefs.bi"
#include once "gdkgltypes.bi"

declare function gdk_gl_query_extension () as gboolean
declare function gdk_gl_query_version (byval major as integer ptr, byval minor as integer ptr) as gboolean
declare function gdk_gl_query_gl_extension (byval extension as zstring ptr) as gboolean
declare function gdk_gl_get_proc_address (byval proc_name as zstring ptr) as GdkGLProc

#endif
