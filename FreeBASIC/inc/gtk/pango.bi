''
''
'' pango -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __pango_bi__
#define __pango_bi__

#inclib "pango-1.0"

#ifdef __FB_WIN32__
#inclib "pangowin32-1.0"
#elseif defined(__FB_LINUX__)
#inclib "pangox-1.0"
#else
#error Platform not supported!
#endif

#include once "gtk/pango/pango-attributes.bi"
#include once "gtk/pango/pango-break.bi"
#include once "gtk/pango/pango-context.bi"
#include once "gtk/pango/pango-coverage.bi"
#include once "gtk/pango/pango-engine.bi"
#include once "gtk/pango/pango-enum-types.bi"
#include once "gtk/pango/pango-font.bi"
#include once "gtk/pango/pango-fontmap.bi"
#include once "gtk/pango/pango-glyph.bi"
#include once "gtk/pango/pango-item.bi"
#include once "gtk/pango/pango-layout.bi"
#include once "gtk/pango/pango-renderer.bi"
#include once "gtk/pango/pango-script.bi"
#include once "gtk/pango/pango-types.bi"

#endif
