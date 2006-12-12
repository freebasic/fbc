''
''
'' gdkglinit -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gdkglinit_bi__
#define __gdkglinit_bi__

#include once "gdkgldefs.bi"
#include once "gdkgltypes.bi"

declare function gdk_gl_parse_args (byval argc as integer ptr, byval argv as byte ptr ptr ptr) as gboolean
declare function gdk_gl_init_check (byval argc as integer ptr, byval argv as byte ptr ptr ptr) as gboolean
declare sub gdk_gl_init (byval argc as integer ptr, byval argv as byte ptr ptr ptr)

#endif
