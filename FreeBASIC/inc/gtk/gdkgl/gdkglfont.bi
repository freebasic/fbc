''
''
'' gdkglfont -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gdkglfont_bi__
#define __gdkglfont_bi__

#include once "gdkgldefs.bi"
#include once "gdkgltypes.bi"

declare function gdk_gl_font_use_pango_font (byval font_desc as PangoFontDescription ptr, byval first as integer, byval count as integer, byval list_base as integer) as PangoFont ptr

#endif
