''
''
'' iupsbox -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __iupsbox_bi__
#define __iupsbox_bi__

declare sub IupSboxOpen cdecl alias "IupSboxOpen" ()
declare function IupSbox cdecl alias "IupSbox" (byval child as Ihandle ptr) as Ihandle ptr

#endif
