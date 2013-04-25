''
''
'' cdclipbd -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __cdclipbd_bi__
#define __cdclipbd_bi__

declare function cdContextClipboard cdecl alias "cdContextClipboard" () as cdContext ptr
#define CD_CLIPBOARD cdContextClipboard()

#endif
