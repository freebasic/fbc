''
''
'' iupole -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __iupole_bi__
#define __iupole_bi__

declare function IupOleControl cdecl alias "IupOleControl" (byval progid as zstring ptr) as Ihandle ptr
declare function IupOleControlOpen cdecl alias "IupOleControlOpen" () as integer

#endif
