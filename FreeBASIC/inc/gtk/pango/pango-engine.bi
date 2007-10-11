''
''
'' pango-engine -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __pango_engine_bi__
#define __pango_engine_bi__

#include once "pango-types.bi"
#include once "pango-item.bi"
#include once "pango-font.bi"
#include once "pango-glyph.bi"
#include once "pango-script.bi"

#define PANGO_TYPE_ENGINE (pango_engine_get_type ())
#define PANGO_ENGINE(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), PANGO_TYPE_ENGINE, PangoEngine))
#define PANGO_IS_ENGINE(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), PANGO_TYPE_ENGINE))
#define PANGO_ENGINE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), PANGO_TYPE_ENGINE, PangoEngineClass))
#define PANGO_IS_ENGINE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), PANGO_TYPE_ENGINE))
#define PANGO_ENGINE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), PANGO_TYPE_ENGINE, PangoEngineClass))

#endif
