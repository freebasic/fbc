#pragma once

#include once "X11/X.bi"
#include once "X11/Xmd.bi"
#include once "X11/extensions/dpmsconst.bi"

extern "C"

const _X11_EXTENSIONS_DPMS_H = 1
declare function DPMSQueryExtension(byval as Display ptr, byval as long ptr, byval as long ptr) as long
declare function DPMSGetVersion(byval as Display ptr, byval as long ptr, byval as long ptr) as long
declare function DPMSCapable(byval as Display ptr) as long
declare function DPMSSetTimeouts(byval as Display ptr, byval as CARD16, byval as CARD16, byval as CARD16) as long
declare function DPMSGetTimeouts(byval as Display ptr, byval as CARD16 ptr, byval as CARD16 ptr, byval as CARD16 ptr) as long
declare function DPMSEnable(byval as Display ptr) as long
declare function DPMSDisable(byval as Display ptr) as long
declare function DPMSForceLevel(byval as Display ptr, byval as CARD16) as long
declare function DPMSInfo(byval as Display ptr, byval as CARD16 ptr, byval as XBOOL ptr) as long

end extern
