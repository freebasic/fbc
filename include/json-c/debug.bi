''
''
'' debug -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __debug_bi__
#define __debug_bi__

Extern "C"

declare sub mc_set_debug (byval debug as integer)
declare function mc_get_debug () as integer
declare sub mc_set_syslog (byval syslog as integer)
declare sub mc_abort (byval msg as zstring ptr, ...)
declare sub mc_debug (byval msg as zstring ptr, ...)
declare sub mc_error (byval msg as zstring ptr, ...)
declare sub mc_info (ByVal msg as zstring ptr, ...)

End Extern

#endif
