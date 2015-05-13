''
''
'' objsafe -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_objsafe_bi__
#define __win_objsafe_bi__

#define INTERFACESAFE_FOR_UNTRUSTED_CALLER &h00000001
#define INTERFACESAFE_FOR_UNTRUSTED_DATA &h00000002

extern IID_IObjectSafety alias "IID_IObjectSafety" as IID

type IObjectSafetyVtbl_ as IObjectSafetyVtbl

type IObjectSafety
	lpVtbl as IObjectSafetyVtbl_ ptr
end type

type IObjectSafetyVtbl
	GetInterfaceSafetyOptions as function(byval as IObjectSafety ptr, byval as IID ptr, byval as DWORD ptr, byval as DWORD ptr) as HRESULT
	SetInterfaceSafetyOptions as function(byval as IObjectSafety ptr, byval as IID ptr, byval as DWORD, byval as DWORD) as HRESULT
end type

#endif
