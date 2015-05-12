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

extern "c"
declare sub IupSboxOpen ()
declare function IupSbox (byval child as Ihandle ptr) as Ihandle ptr
end extern

#endif
