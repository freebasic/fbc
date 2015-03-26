#pragma once

#include once "X11/Intrinsic.bi"
#include once "X11/Xfuncproto.bi"

extern "C"

#define _XMU_INITER_H_
type XmuInitializerProc as sub(byval app_context as XtAppContext, byval data as XPointer)
declare sub XmuCallInitializers(byval app_context as XtAppContext)
declare sub XmuAddInitializer(byval func as XmuInitializerProc, byval data as XPointer)

end extern
