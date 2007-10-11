''
''
'' security -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_security_bi__
#define __win_security_bi__

#inclib "secur32"

#define SEC_E_OK 0
#define SEC_E_CERT_EXPIRED (-2146893016)
#define SEC_E_INCOMPLETE_MESSAGE (-2146893032)
#define SEC_E_INSUFFICIENT_MEMORY (-2146893056)
#define SEC_E_INTERNAL_ERROR (-2146893052)
#define SEC_E_INVALID_HANDLE (-2146893055)
#define SEC_E_INVALID_TOKEN (-2146893048)
#define SEC_E_LOGON_DENIED (-2146893044)
#define SEC_E_NO_AUTHENTICATING_AUTHORITY (-2146893039)
#define SEC_E_NO_CREDENTIALS (-2146893042)
#define SEC_E_TARGET_UNKNOWN (-2146893053)
#define SEC_E_UNSUPPORTED_FUNCTION (-2146893054)
#define SEC_E_UNTRUSTED_ROOT (-2146893019)
#define SEC_E_WRONG_PRINCIPAL (-2146893022)
#define SEC_E_SECPKG_NOT_FOUND (-2146893051)
#define SEC_E_QOP_NOT_SUPPORTED (-2146893046)
#define SEC_E_UNKNOWN_CREDENTIALS (-2146893043)
#define SEC_E_NOT_OWNER (-2146893050)
#define SEC_I_RENEGOTIATE 590625
#define SEC_I_COMPLETE_AND_CONTINUE 590612
#define SEC_I_COMPLETE_NEEDED 590611
#define SEC_I_CONTINUE_NEEDED 590610
#define SEC_I_INCOMPLETE_CREDENTIALS 590624

type SEC_CHAR as byte
type SEC_WCHAR as wchar_t
type SECURITY_STATUS as integer

#include once "win/sspi.bi"
#include once "win/ntsecpkg.bi"
#include once "win/secext.bi"

#endif
