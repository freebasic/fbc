'' FreeBASIC binding for libXt-1.1.4

#pragma once

#include once "crt/stdarg.bi"

extern "C"

#define _VarargsI_h_
declare sub _XtCountVaList(byval as va_list, byval as long ptr, byval as long ptr)
declare sub _XtVaToArgList(byval as Widget, byval as va_list, byval as long, byval as ArgList ptr, byval as Cardinal ptr)
declare sub _XtVaToTypedArgList(byval as va_list, byval as long, byval as XtTypedArgList ptr, byval as Cardinal ptr)
declare function _XtVaCreateTypedArgList(byval as va_list, byval as long) as XtTypedArgList
declare sub _XtFreeArgList(byval as ArgList, byval as long, byval as long)
declare sub _XtGetApplicationResources(byval as Widget, byval as XtPointer, byval as XtResourceList, byval as Cardinal, byval as ArgList, byval as Cardinal, byval as XtTypedArgList, byval as Cardinal)
declare sub _XtGetSubresources(byval as Widget, byval as XtPointer, byval as const zstring ptr, byval as const zstring ptr, byval as XtResourceList, byval as Cardinal, byval as ArgList, byval as Cardinal, byval as XtTypedArgList, byval as Cardinal)

end extern
