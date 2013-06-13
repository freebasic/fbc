''
''
'' iuptuio -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __iuptuio_bi__
#define __iuptuio_bi__

declare function IupTuioOpen cdecl alias "IupTuioOpen" () as integer
declare function IupTuioClient cdecl alias "IupTuioClient" (byval port as integer) as Ihandle ptr

#endif
