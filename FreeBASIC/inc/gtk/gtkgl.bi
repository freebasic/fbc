''
''
'' gtkgl -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkgl_bi__
#define __gtkgl_bi__

#ifdef __FB_WIN32__
# inclib "gtkglext-win32-1.0"
# pragma push(msbitfields)
#elseif defined(__FB_LINUX__)
# inclib "gtkglext-x11-1.0"
#else
# error Platform not supported!
#endif

extern "c"

#include once "gdkgl.bi"
#include once "gtkgl/gtkgldefs.bi"
#include once "gtkgl/gtkglversion.bi"
#include once "gtkgl/gtkglinit.bi"
#include once "gtkgl/gtkglwidget.bi"

end extern

#ifdef __FB_WIN32__
# pragma pop(msbitfields)
#endif

#endif
