''
''
'' Initer -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __Initer_bi__
#define __Initer_bi__

type XmuInitializerProc as sub cdecl(byval as XtAppContext, byval as XPointer)

declare sub XmuAddInitializer cdecl alias "XmuAddInitializer" (byval func as XmuInitializerProc, byval data as XPointer)

#endif
