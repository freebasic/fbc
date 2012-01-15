''
''
'' gdfx -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gdfx_bi__
#define __gdfx_bi__

declare function gdImageSquareToCircle alias "gdImageSquareToCircle" (byval im as gdImagePtr, byval radius as integer) as gdImagePtr
declare function gdImageStringFTCircle alias "gdImageStringFTCircle" (byval im as gdImagePtr, byval cx as integer, byval cy as integer, byval radius as double, byval textRadius as double, byval fillPortion as double, byval font as zstring ptr, byval points as double, byval top as zstring ptr, byval bottom as zstring ptr, byval fgcolor as integer) as zstring ptr
declare sub gdImageSharpen alias "gdImageSharpen" (byval im as gdImagePtr, byval pct as integer)

#endif
