''
''
'' Xcup -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __Xcup_bi__
#define __Xcup_bi__

#define X_XcupQueryVersion 0
#define X_XcupGetReservedColormapEntries 1
#define X_XcupStoreColors 2
#define XcupNumberErrors 0

declare function XcupStoreColors cdecl alias "XcupStoreColors" (byval as Display ptr, byval as Colormap, byval as XColor ptr, byval as integer) as Status

#endif
