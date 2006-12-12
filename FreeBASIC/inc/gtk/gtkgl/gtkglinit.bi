''
''
'' gtkglinit -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkglinit_bi__
#define __gtkglinit_bi__

#include once "gtk/gdk.bi"
#include once "../gtkgl.bi"

declare function gtk_gl_parse_args (byval argc as integer ptr, byval argv as byte ptr ptr ptr) as gboolean
declare function gtk_gl_init_check (byval argc as integer ptr, byval argv as byte ptr ptr ptr) as gboolean
declare sub gtk_gl_init (byval argc as integer ptr, byval argv as byte ptr ptr ptr)

#endif
