''
''
'' iupgetparam -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __iupgetparam_bi__
#define __iupgetparam_bi__

type Iparamcb as function cdecl(byval as Ihandle ptr, byval as integer, byval as any ptr) as integer

declare function IupGetParam cdecl alias "IupGetParam" (byval title as string, byval action as Iparamcb, byval user_data as any ptr, byval format as string, ...) as integer

#endif
