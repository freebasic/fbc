''
''
'' cddbuf -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __cddbuf_bi__
#define __cddbuf_bi__

declare function cdContextDBuffer cdecl alias "cdContextDBuffer" () as cdContext ptr
#define CD_DBUFFER cdContextDBuffer()

#endif
