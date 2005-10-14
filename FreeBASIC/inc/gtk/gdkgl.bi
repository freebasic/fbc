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

#include once "gtk/gdkgl/gdkgldefs.bi"
#include once "gtk/gdkgl/gdkglversion.bi"
#include once "gtk/gdkgl/gdkgltokens.bi"
#include once "gtk/gdkgl/gdkgltypes.bi"
#include once "gtk/gdkgl/gdkglenumtypes.bi"
#include once "gtk/gdkgl/gdkglinit.bi"
#include once "gtk/gdkgl/gdkglquery.bi"
#include once "gtk/gdkgl/gdkglconfig.bi"
#include once "gtk/gdkgl/gdkglcontext.bi"
#include once "gtk/gdkgl/gdkgldrawable.bi"
#include once "gtk/gdkgl/gdkglpixmap.bi"
#include once "gtk/gdkgl/gdkglwindow.bi"
#include once "gtk/gdkgl/gdkglfont.bi"
#include once "gtk/gdkgl/gdkglshapes.bi"

#ifdef __FB_WIN32__
# pragma pop(msbitfields)
#endif

#endif
