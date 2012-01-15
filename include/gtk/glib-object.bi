''
''
'' glib-object -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __glib_object_bi__
#define __glib_object_bi__

#ifdef __FB_WIN32__
# pragma push(msbitfields)
#endif

extern "c" lib "gobject-2.0"

#include once "gobject/gboxed.bi"
#include once "gobject/genums.bi"
#include once "gobject/gobject.bi"
#include once "gobject/gparam.bi"
#include once "gobject/gparamspecs.bi"
#include once "gobject/gsignal.bi"
#include once "gobject/gsourceclosure.bi"
#include once "gobject/gtype.bi"
#include once "gobject/gtypemodule.bi"
#include once "gobject/gtypeplugin.bi"
#include once "gobject/gvalue.bi"
#include once "gobject/gvaluearray.bi"
#include once "gobject/gvaluetypes.bi"

end extern

#ifdef __FB_WIN32__
# pragma pop(msbitfields)
#endif

#endif
