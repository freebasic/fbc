#pragma once

#include once "crt/long.bi"
#include once "X11/extensions/ag.bi"
#include once "X11/Xfuncproto.bi"
#include once "crt/stdarg.bi"

extern "C"

#define _XAG_H_
type XAppGroup as XID
declare function XagQueryVersion(byval as Display ptr, byval as long ptr, byval as long ptr) as long
declare function XagCreateEmbeddedApplicationGroup(byval as Display ptr, byval as VisualID, byval as Colormap, byval as culong, byval as culong, byval as XAppGroup ptr) as long
declare function XagCreateNonembeddedApplicationGroup(byval as Display ptr, byval as XAppGroup ptr) as long
declare function XagDestroyApplicationGroup(byval as Display ptr, byval as XAppGroup) as long
declare function XagGetApplicationGroupAttributes(byval as Display ptr, byval as XAppGroup, ...) as long
declare function XagQueryApplicationGroup(byval as Display ptr, byval as XID, byval as XAppGroup ptr) as long
declare function XagCreateAssociation(byval as Display ptr, byval as Window ptr, byval as any ptr) as long
declare function XagDestroyAssociation(byval as Display ptr, byval as Window) as long

end extern
