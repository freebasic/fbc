''
''
'' glade -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __glade_bi__
#define __glade_bi__

#ifdef __FB_WIN32__
# pragma push(msbitfields)
#endif

extern "c" lib "glade-2.0"

#include once "glib.bi"
#include once "glade-init.bi"
#include once "glade-xml.bi"

end extern

#ifdef __FB_WIN32__
# pragma pop(msbitfields)
#endif

#endif
