''
''
'' dpms -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __dpms_bi__
#define __dpms_bi__

#define _X11_EXTENSIONS_DPMS_H 1
#define DPMSModeOn 0
#define DPMSModeStandby 1
#define DPMSModeSuspend 2
#define DPMSModeOff 3

declare function DPMSGetVersion cdecl alias "DPMSGetVersion" (byval as Display ptr, byval as integer ptr, byval as integer ptr) as Status
declare function DPMSCapable cdecl alias "DPMSCapable" (byval as Display ptr) as Bool
declare function DPMSSetTimeouts cdecl alias "DPMSSetTimeouts" (byval as Display ptr, byval as CARD16, byval as CARD16, byval as CARD16) as Status
declare function DPMSGetTimeouts cdecl alias "DPMSGetTimeouts" (byval as Display ptr, byval as CARD16 ptr, byval as CARD16 ptr, byval as CARD16 ptr) as Bool
declare function DPMSEnable cdecl alias "DPMSEnable" (byval as Display ptr) as Status
declare function DPMSDisable cdecl alias "DPMSDisable" (byval as Display ptr) as Status
declare function DPMSForceLevel cdecl alias "DPMSForceLevel" (byval as Display ptr, byval as CARD16) as Status
declare function DPMSInfo cdecl alias "DPMSInfo" (byval as Display ptr, byval as CARD16 ptr, byval as BOOL ptr) as Status

#endif
