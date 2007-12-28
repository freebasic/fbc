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
# pragma push(msbitfields)
# inclib "pangowin32-1.0"
#elseif defined(__FB_LINUX__)
# inclib "pangox-1.0"
#else
# error Platform not supported!
#endif

extern "c"

#include once "pango/pango-attributes.bi"
#include once "pango/pango-break.bi"
#include once "pango/pango-context.bi"
#include once "pango/pango-coverage.bi"
#include once "pango/pango-engine.bi"
#include once "pango/pango-enum-types.bi"
#include once "pango/pango-font.bi"
#include once "pango/pango-fontmap.bi"
#include once "pango/pango-glyph.bi"
#include once "pango/pango-item.bi"
#include once "pango/pango-layout.bi"
#include once "pango/pango-renderer.bi"
#include once "pango/pango-script.bi"
#include once "pango/pango-types.bi"

end extern

#ifdef __FB_WIN32__
# pragma pop(msbitfields)
#endif

#endif
