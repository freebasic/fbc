#pragma once

#include once "X11/Xfuncproto.bi"

extern "C"

#define _RESCONFIGP_H
#define RCM_DATA "Custom Data"
#define RCM_INIT "Custom Init"
declare sub _XtResourceConfigurationEH(byval as Widget, byval as XtPointer, byval as XEvent ptr)

end extern
