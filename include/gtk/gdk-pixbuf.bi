''
''
'' gdk-pixbuf -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gdk_pixbuf_bi__
#define __gdk_pixbuf_bi__

#ifdef __FB_WIN32__
# pragma push(msbitfields)
#endif

extern "c" lib "gdk_pixbuf-2.0"

#include once "glib.bi"
#include once "gdk-pixbuf/gdk-pixbuf-features.bi"
#include once "glib-object.bi"
#include once "gdk-pixbuf/gdk-pixbuf-core.bi"
#include once "gdk-pixbuf/gdk-pixbuf-transform.bi"
#include once "gdk-pixbuf/gdk-pixbuf-animation.bi"
#include once "gdk-pixbuf/gdk-pixbuf-io.bi"
#include once "gdk-pixbuf/gdk-pixbuf-loader.bi"
#include once "gdk-pixbuf/gdk-pixbuf-enum-types.bi"

end extern

#ifdef __FB_WIN32__
# pragma pop(msbitfields)
#endif

#endif
