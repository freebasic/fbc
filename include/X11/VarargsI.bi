''
''
'' VarargsI -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __VarargsI_bi__
#define __VarargsI_bi__

declare sub _XtVaToArgList cdecl alias "_XtVaToArgList" (byval as Widget, byval as va_list, byval as integer, byval as ArgList ptr, byval as Cardinal ptr)
declare sub _XtVaToTypedArgList cdecl alias "_XtVaToTypedArgList" (byval as va_list, byval as integer, byval as XtTypedArgList ptr, byval as Cardinal ptr)
declare function _XtVaCreateTypedArgList cdecl alias "_XtVaCreateTypedArgList" (byval as va_list, byval as integer) as XtTypedArgList
declare sub _XtFreeArgList cdecl alias "_XtFreeArgList" (byval as ArgList, byval as integer, byval as integer)
declare sub _XtGetApplicationResources cdecl alias "_XtGetApplicationResources" (byval as Widget, byval as XtPointer, byval as XtResourceList, byval as Cardinal, byval as ArgList, byval as Cardinal, byval as XtTypedArgList, byval as Cardinal)
declare sub _XtGetSubresources cdecl alias "_XtGetSubresources" (byval as Widget, byval as XtPointer, byval as zstring ptr, byval as zstring ptr, byval as XtResourceList, byval as Cardinal, byval as ArgList, byval as Cardinal, byval as XtTypedArgList, byval as Cardinal)

#endif
