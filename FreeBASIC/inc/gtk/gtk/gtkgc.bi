''
''
'' gtkgc -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkgc_bi__
#define __gtkgc_bi__

#include once "gtk/gdk.bi"

declare function gtk_gc_get (byval depth as gint, byval colormap as GdkColormap ptr, byval values as GdkGCValues ptr, byval values_mask as GdkGCValuesMask) as GdkGC ptr
declare sub gtk_gc_release (byval gc as GdkGC ptr)

#endif
