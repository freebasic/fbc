''
''
'' security -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __security_bi__
#define __security_bi__

#define XSecurityNumberEvents 1
#define XSecurityNumberErrors 2
#define XSecurityBadAuthorization 0
#define XSecurityBadAuthorizationProtocol 1
#define XSecurityClientTrusted 0
#define XSecurityClientUntrusted 1
#define XSecurityTimeout (1 shl 0)
#define XSecurityTrustLevel (1 shl 1)
#define XSecurityGroup (1 shl 2)
#define XSecurityEventMask (1 shl 3)
#define XSecurityAllAuthorizationAttributes ((1 shl 0) or (1 shl 1) or (1 shl 2) or (1 shl 3))
#define XSecurityAuthorizationRevokedMask (1 shl 0)
#define XSecurityAllEventMasks (1 shl 0)
#define XSecurityAuthorizationRevoked 0
#define XSecurityAuthorizationName "XC-QUERY-SECURITY-1"
#define XSecurityAuthorizationNameLen 19

declare sub XSecurityFreeXauth cdecl alias "XSecurityFreeXauth" (byval auth as Xauth ptr)

type XSecurityAuthorization as uinteger

type XSecurityAuthorizationAttributes
	timeout as uinteger
	trust_level as uinteger
	group as XID
	event_mask as integer
end type

declare function XSecurityGenerateAuthorization cdecl alias "XSecurityGenerateAuthorization" (byval dpy as Display ptr, byval auth_in as Xauth ptr, byval valuemask as uinteger, byval attributes as XSecurityAuthorizationAttributes ptr, byval auth_id_return as XSecurityAuthorization ptr) as Xauth ptr
declare function XSecurityRevokeAuthorization cdecl alias "XSecurityRevokeAuthorization" (byval dpy as Display ptr, byval auth_id as XSecurityAuthorization) as Status

type XSecurityAuthorizationRevokedEvent
	type as integer
	serial as uinteger
	send_event as Bool
	display as Display ptr
	auth_id as XSecurityAuthorization
end type

#endif
