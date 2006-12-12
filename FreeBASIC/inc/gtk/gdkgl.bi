''
''
'' gdkgl -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gdkgl_bi__
#define __gdkgl_bi__

#ifdef __FB_WIN32__
# pragma push(msbitfields)
# inclib "gdkglext-win32-1.0"
#elseif defined(__FB_LINUX__)
# inclib "gdkglext-x11-1.0"
#else
# error Platform not supported!
#endif

extern "c"

#include once "gdkgl/gdkgldefs.bi"
#include once "gdkgl/gdkglversion.bi"
#include once "gdkgl/gdkgltokens.bi"
#include once "gdkgl/gdkgltypes.bi"
#include once "gdkgl/gdkglenumtypes.bi"
#include once "gdkgl/gdkglinit.bi"
#include once "gdkgl/gdkglquery.bi"
#include once "gdkgl/gdkglconfig.bi"
#include once "gdkgl/gdkglcontext.bi"
#include once "gdkgl/gdkgldrawable.bi"
#include once "gdkgl/gdkglpixmap.bi"
#include once "gdkgl/gdkglwindow.bi"
#include once "gdkgl/gdkglfont.bi"
#include once "gdkgl/gdkglshapes.bi"

end extern

#ifdef __FB_WIN32__
# pragma pop(msbitfields)
#endif

#endif
