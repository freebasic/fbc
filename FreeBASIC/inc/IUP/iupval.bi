''
''
'' iupval -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __iupval_bi__
#define __iupval_bi__

#define ICTL_SHOWTICKS "SHOWTICKS"

extern "c"
declare function IupVal (byval as zstring ptr) as Ihandle ptr
declare sub IupValOpen ()
end extern

#endif
