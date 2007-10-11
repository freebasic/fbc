''
''
'' winsnmp -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_winsnmp_bi__
#define __win_winsnmp_bi__

#inclib "wsnmp32"

#define MAXOBJIDSIZE 128
#define MAXOBJIDSTRSIZE 1408
#define MAXVENDORINFO 32
#define SNMP_SYNTAX_SEQUENCE (&h00 or &h20 or &h10)
#define SNMP_SYNTAX_INT (&h00 or &h00 or &h02)
#define SNMP_SYNTAX_BITS (&h00 or &h00 or &h03)
#define SNMP_SYNTAX_OCTETS (&h00 or &h00 or &h04)
#define SNMP_SYNTAX_NULL (&h00 or &h00 or &h05)
#define SNMP_SYNTAX_OID (&h00 or &h00 or &h06)
#define SNMP_SYNTAX_IPADDR (&h40 or &h00 or &h00)
#define SNMP_SYNTAX_CNTR32 (&h40 or &h00 or &h01)
#define SNMP_SYNTAX_GAUGE32 (&h40 or &h00 or &h02)
#define SNMP_SYNTAX_TIMETICKS (&h40 or &h00 or &h03)
#define SNMP_SYNTAX_OPAQUE (&h40 or &h00 or &h04)
#define SNMP_SYNTAX_NSAPADDR (&h40 or &h00 or &h05)
#define SNMP_SYNTAX_CNTR64 (&h40 or &h00 or &h06)
#define SNMP_SYNTAX_UINT32 (&h40 or &h00 or &h07)
#define SNMP_SYNTAX_NOSUCHOBJECT (&h80 or &h00 or &h00)
#define SNMP_SYNTAX_NOSUCHINSTANCE (&h80 or &h00 or &h01)
#define SNMP_SYNTAX_ENDOFMIBVIEW (&h80 or &h00 or &h02)
#define SNMP_SYNTAX_INT32 (&h00 or &h00 or &h02)
#define SNMP_TRAP_COLDSTART 0
#define SNMP_TRAP_WARMSTART 1
#define SNMP_TRAP_LINKDOWN 2
#define SNMP_TRAP_LINKUP 3
#define SNMP_TRAP_AUTHFAIL 4
#define SNMP_TRAP_EGPNEIGHBORLOSS 5
#define SNMP_TRAP_ENTERPRISESPECIFIC 6
#define SNMP_ERROR_NOERROR 0
#define SNMP_ERROR_TOOBIG 1
#define SNMP_ERROR_NOSUCHNAME 2
#define SNMP_ERROR_BADVALUE 3
#define SNMP_ERROR_READONLY 4
#define SNMP_ERROR_GENERR 5
#define SNMP_ERROR_NOACCESS 6
#define SNMP_ERROR_WRONGTYPE 7
#define SNMP_ERROR_WRONGLENGTH 8
#define SNMP_ERROR_WRONGENCODING 9
#define SNMP_ERROR_WRONGVALUE 10
#define SNMP_ERROR_NOCREATION 11
#define SNMP_ERROR_INCONSISTENTVALUE 12
#define SNMP_ERROR_RESOURCEUNAVAILABLE 13
#define SNMP_ERROR_COMMITFAILED 14
#define SNMP_ERROR_UNDOFAILED 15
#define SNMP_ERROR_AUTHORIZATIONERROR 16
#define SNMP_ERROR_NOTWRITABLE 17
#define SNMP_ERROR_INCONSISTENTNAME 18
#define SNMP_SEC_MODEL_V1 1
#define SNMP_SEC_MODEL_V2 2
#define SNMP_SEC_MODEL_USM 3
#define SNMP_NOAUTH_NOPRIV 0
#define SNMP_AUTH_NOPRIV 1
#define SNMP_AUTH_PRIV 3
#define SNMP_USM_NO_AUTH_PROTOCOL 1
#define SNMP_USM_HMACMD5_AUTH_PROTOCOL 2
#define SNMP_USM_HMACSHA_AUTH_PROTOCOL 3
#define SNMP_USM_NO_PRIV_PROTOCOL 1
#define SNMP_USM_DES_PRIV_PROTOCOL 2
#define SNMPAPI_TRANSLATED 0
#define SNMPAPI_UNTRANSLATED_V1 1
#define SNMPAPI_UNTRANSLATED_V2 2
#define SNMPAPI_UNTRANSLATED_V3 3
#define SNMPAPI_OFF 0
#define SNMPAPI_ON 1
#define SNMPAPI_FAILURE 0
#define SNMPAPI_SUCCESS 1
#define SNMPAPI_NO_SUPPORT 0
#define SNMPAPI_V1_SUPPORT 1
#define SNMPAPI_V2_SUPPORT 2
#define SNMPAPI_M2M_SUPPORT 3
#define SNMPAPI_V3_SUPPORT 3
#define SNMPAPI_ALLOC_ERROR 2
#define SNMPAPI_CONTEXT_INVALID 3
#define SNMPAPI_CONTEXT_UNKNOWN 4
#define SNMPAPI_ENTITY_INVALID 5
#define SNMPAPI_ENTITY_UNKNOWN 6
#define SNMPAPI_INDEX_INVALID 7
#define SNMPAPI_NOOP 8
#define SNMPAPI_OID_INVALID 9
#define SNMPAPI_OPERATION_INVALID 10
#define SNMPAPI_OUTPUT_TRUNCATED 11
#define SNMPAPI_PDU_INVALID 12
#define SNMPAPI_SESSION_INVALID 13
#define SNMPAPI_SYNTAX_INVALID 14
#define SNMPAPI_VBL_INVALID 15
#define SNMPAPI_MODE_INVALID 16
#define SNMPAPI_SIZE_INVALID 17
#define SNMPAPI_NOT_INITIALIZED 18
#define SNMPAPI_MESSAGE_INVALID 19
#define SNMPAPI_HWND_INVALID 20
#define SNMPAPI_ENGINE_INVALID 30
#define SNMPAPI_ENGINE_DISCOVERY_FAILED 31
#define SNMPAPI_OTHER_ERROR 99
#define SNMPAPI_TL_NOT_INITIALIZED 100
#define SNMPAPI_TL_NOT_SUPPORTED 101
#define SNMPAPI_TL_NOT_AVAILABLE 102
#define SNMPAPI_TL_RESOURCE_ERROR 103
#define SNMPAPI_TL_UNDELIVERABLE 104
#define SNMPAPI_TL_SRC_INVALID 105
#define SNMPAPI_TL_INVALID_PARAM 106
#define SNMPAPI_TL_IN_USE 107
#define SNMPAPI_TL_TIMEOUT 108
#define SNMPAPI_TL_PDU_TOO_BIG 109
#define SNMPAPI_TL_OTHER 199
#define SNMPAPI_RPT_INVALIDMSG 200
#define SNMPAPI_RPT_INASNPARSEERR 201
#define SNMPAPI_RPT_UNKNOWNSECMODEL 202
#define SNMPAPI_RPT_UNKNOWNENGINEID 203
#define SNMPAPI_RPT_UNSUPPSECLEVEL 204
#define SNMPAPI_RPT_UNKNOWNUSERNAME 205
#define SNMPAPI_RPT_WRONGDIGEST 206
#define SNMPAPI_RPT_NOTINTIMEWINDOW 207
#define SNMPAPI_RPT_DECRYPTIONERROR 208
#define SNMPAPI_RPT_OTHER 299

type HSNMP_SESSION as HANDLE
type LPHSNMP_SESSION as HANDLE ptr
type HSNMP_CONTEXT as HANDLE
type LPHSNMP_CONTEXT as HANDLE ptr
type HSNMP_VBL as HANDLE
type LPHSNMP_VBL as HANDLE ptr
type HSNMP_PDU as HANDLE
type LPHSNMP_PDU as HANDLE ptr
type HSNMP_ENTITY as HANDLE
type LPHSNMP_ENTITY as HANDLE ptr
type smiBYTE as ubyte
type smiLPBYTE as ubyte ptr
type smiINT as integer
type smiLPINT as integer ptr
type smiINT32 as integer
type smiLPINT32 as integer ptr
type smiUINT32 as uinteger
type smiLPUINT32 as uinteger ptr
type smiCNTR32 as smiUINT32
type smiLPCNTR32 as smiUINT32 ptr
type smiGAUGE32 as smiUINT32
type smiLPGAUGE32 as smiUINT32 ptr
type smiTIMETICKS as smiUINT32
type smiLPTIMETICKS as smiUINT32 ptr
type SNMPAPI_STATUS as smiUINT32

type smiOCTETS
	len as smiUINT32
	ptr as smiLPBYTE
end type

type smiLPOCTETS as smiOCTETS ptr
type smiOPAQUE as smiOCTETS
type smiLPOPAQUE as smiOCTETS ptr
type smiBITS as smiOCTETS
type smiLPBITS as smiOCTETS ptr
type smiIPADDR as smiOCTETS
type smiLPIPADDR as smiOCTETS ptr
type smiNSAPADDR as smiOCTETS
type smiLPNSAPADDR as smiOCTETS ptr
type smiLPCOCTETS as smiLPOCTETS

type smiOID
	len as smiUINT32
	ptr as smiLPUINT32
end type

type smiLPOID as smiOID ptr
type smiLPCOID as smiLPOID

type smiCNTR64
	hipart as smiUINT32
	lopart as smiUINT32
end type

type smiLPCNTR64 as smiCNTR64 ptr

union smiVALUE_value
	sNumber as smiINT
	uNumber as smiUINT32
	hNumber as smiCNTR64
	string as smiOCTETS
	oid as smiOID
	empty as smiBYTE
end union

type smiVALUE
	syntax as smiUINT32
	value as smiVALUE_value
end type

type smiLPVALUE as smiVALUE ptr

type smiLPCVALUE as smiLPVALUE

type smiVENDORINFO
	vendorName as zstring * 32*2
	vendorContact as zstring * 32*2
	vendorVersionId as zstring * 32
	vendorVersionDate as zstring * 32
	vendorEnterprise as smiUINT32
end type

type smiLPVENDORINFO as smiVENDORINFO ptr
type SNMPAPI_CALLBACK as function(byval as HSNMP_SESSION, byval as HWND, byval as UINT, byval as WPARAM, byval as LPARAM, byval as LPVOID) as SNMPAPI_STATUS

type smiENTITYINFO
	hEntity as HSNMP_ENTITY
	hSession as HSNMP_SESSION
	nTranslateMode as smiUINT32
	nSnmpVersion as smiUINT32
	dFriendlyName as smiOCTETS
	nAddressFamily as smiUINT32
	dAddressString as smiOCTETS
	nRequestPort as smiUINT32
	nNotificationPort as smiUINT32
	nMaxMsgSize as smiUINT32
	dEngineID as smiOCTETS
	nEngineBoots as smiUINT32
	nEngineTime as smiUINT32
	nEngineSeconds as smiUINT32
	nRetransmitMode as smiUINT32
	nPolicyTimeout as smiTIMETICKS
	nPolicyRetry as smiUINT32
	nActualTimeout as smiTIMETICKS
	nActualRetry as smiUINT32
end type

type smiLPENTITYINFO as smiENTITYINFO ptr

type smiCONTEXTINFO
	hContext as HSNMP_CONTEXT
	hSession as HSNMP_SESSION
	nTranslateMode as smiUINT32
	nSnmpVersion as smiUINT32
	dFriendlyName as smiOCTETS
	dContextEngineID as smiOCTETS
	dContextName as smiOCTETS
	dSecurityName as smiOCTETS
	nSecurityModel as smiUINT32
	nSecurityLevel as smiUINT32
	nSecurityAuthProtocol as smiUINT32
	dSecurityAuthKey as smiOCTETS
	nSecurityPrivProtocol as smiUINT32
	dSecurityPrivKey as smiOCTETS
end type

type smiLPCONTEXTINFO as smiCONTEXTINFO ptr

declare function SnmpCancelMsg alias "SnmpCancelMsg" (byval as HSNMP_SESSION, byval as smiINT32) as SNMPAPI_STATUS
declare function SnmpCleanup alias "SnmpCleanup" () as SNMPAPI_STATUS
declare function SnmpClose alias "SnmpClose" (byval as HSNMP_SESSION) as SNMPAPI_STATUS
declare function SnmpContextToStr alias "SnmpContextToStr" (byval as HSNMP_CONTEXT, byval as smiLPOCTETS) as SNMPAPI_STATUS
declare function SnmpCountVbl alias "SnmpCountVbl" (byval as HSNMP_VBL) as SNMPAPI_STATUS
declare function SnmpCreatePdu alias "SnmpCreatePdu" (byval as HSNMP_SESSION, byval as smiINT, byval as smiINT32, byval as smiINT, byval as smiINT, byval as HSNMP_VBL) as HSNMP_PDU
declare function SnmpCreateSession alias "SnmpCreateSession" (byval as HWND, byval as UINT, byval as SNMPAPI_CALLBACK, byval as LPVOID) as HSNMP_SESSION
declare function SnmpCreateVbl alias "SnmpCreateVbl" (byval as HSNMP_SESSION, byval as smiLPCOID, byval as smiLPCVALUE) as HSNMP_VBL
declare function SnmpDecodeMsg alias "SnmpDecodeMsg" (byval as HSNMP_SESSION, byval as LPHSNMP_ENTITY, byval as LPHSNMP_ENTITY, byval as LPHSNMP_CONTEXT, byval as LPHSNMP_PDU, byval as smiLPCOCTETS) as SNMPAPI_STATUS
declare function SnmpDeleteVb alias "SnmpDeleteVb" (byval as HSNMP_VBL, byval as smiUINT32) as SNMPAPI_STATUS
declare function SnmpDuplicatePdu alias "SnmpDuplicatePdu" (byval as HSNMP_SESSION, byval as HSNMP_PDU) as HSNMP_PDU
declare function SnmpDuplicateVbl alias "SnmpDuplicateVbl" (byval as HSNMP_SESSION, byval as HSNMP_VBL) as HSNMP_VBL
declare function SnmpEncodeMsg alias "SnmpEncodeMsg" (byval as HSNMP_SESSION, byval as HSNMP_ENTITY, byval as HSNMP_ENTITY, byval as HSNMP_CONTEXT, byval as HSNMP_PDU, byval as smiLPOCTETS) as SNMPAPI_STATUS
declare function SnmpEntityToStr alias "SnmpEntityToStr" (byval as HSNMP_ENTITY, byval as smiUINT32, byval as LPSTR) as SNMPAPI_STATUS
declare function SnmpFreeContext alias "SnmpFreeContext" (byval as HSNMP_CONTEXT) as SNMPAPI_STATUS
declare function SnmpFreeDescriptor alias "SnmpFreeDescriptor" (byval as smiUINT32, byval as smiLPOPAQUE) as SNMPAPI_STATUS
declare function SnmpFreeEntity alias "SnmpFreeEntity" (byval as HSNMP_ENTITY) as SNMPAPI_STATUS
declare function SnmpFreePdu alias "SnmpFreePdu" (byval as HSNMP_PDU) as SNMPAPI_STATUS
declare function SnmpFreeVbl alias "SnmpFreeVbl" (byval as HSNMP_VBL) as SNMPAPI_STATUS
declare function SnmpGetLastError alias "SnmpGetLastError" (byval as HSNMP_SESSION) as SNMPAPI_STATUS
declare function SnmpGetPduData alias "SnmpGetPduData" (byval as HSNMP_PDU, byval as smiLPINT, byval as smiLPINT32, byval as smiLPINT, byval as smiLPINT, byval as LPHSNMP_VBL) as SNMPAPI_STATUS
declare function SnmpGetRetransmitMode alias "SnmpGetRetransmitMode" (byval as smiLPUINT32) as SNMPAPI_STATUS
declare function SnmpGetRetry alias "SnmpGetRetry" (byval as HSNMP_ENTITY, byval as smiLPUINT32, byval as smiLPUINT32) as SNMPAPI_STATUS
declare function SnmpGetTimeout alias "SnmpGetTimeout" (byval as HSNMP_ENTITY, byval as smiLPTIMETICKS, byval as smiLPTIMETICKS) as SNMPAPI_STATUS
declare function SnmpGetTranslateMode alias "SnmpGetTranslateMode" (byval as smiLPUINT32) as SNMPAPI_STATUS
declare function SnmpGetVb alias "SnmpGetVb" (byval as HSNMP_VBL, byval as smiUINT32, byval as smiLPOID, byval as smiLPVALUE) as SNMPAPI_STATUS
declare function SnmpGetVendorInfo alias "SnmpGetVendorInfo" (byval as smiLPVENDORINFO) as SNMPAPI_STATUS
declare function SnmpListen alias "SnmpListen" (byval as HSNMP_ENTITY, byval as SNMPAPI_STATUS) as SNMPAPI_STATUS
declare function SnmpOidCompare alias "SnmpOidCompare" (byval as smiLPCOID, byval as smiLPCOID, byval as smiUINT32, byval as smiLPINT) as SNMPAPI_STATUS
declare function SnmpOidCopy alias "SnmpOidCopy" (byval as smiLPCOID, byval as smiLPOID) as SNMPAPI_STATUS
declare function SnmpOidToStr alias "SnmpOidToStr" (byval as smiLPCOID, byval as smiUINT32, byval as LPSTR) as SNMPAPI_STATUS
declare function SnmpOpen alias "SnmpOpen" (byval as HWND, byval as UINT) as HSNMP_SESSION
declare function SnmpRecvMsg alias "SnmpRecvMsg" (byval as HSNMP_SESSION, byval as LPHSNMP_ENTITY, byval as LPHSNMP_ENTITY, byval as LPHSNMP_CONTEXT, byval as LPHSNMP_PDU) as SNMPAPI_STATUS
declare function SnmpRegister alias "SnmpRegister" (byval as HSNMP_SESSION, byval as HSNMP_ENTITY, byval as HSNMP_ENTITY, byval as HSNMP_CONTEXT, byval as smiLPCOID, byval as smiUINT32) as SNMPAPI_STATUS
declare function SnmpSendMsg alias "SnmpSendMsg" (byval as HSNMP_SESSION, byval as HSNMP_ENTITY, byval as HSNMP_ENTITY, byval as HSNMP_CONTEXT, byval as HSNMP_PDU) as SNMPAPI_STATUS
declare function SnmpSetPduData alias "SnmpSetPduData" (byval as HSNMP_PDU, byval as smiINT ptr, byval as smiINT32 ptr, byval as smiINT ptr, byval as smiINT ptr, byval as HSNMP_VBL ptr) as SNMPAPI_STATUS
declare function SnmpSetPort alias "SnmpSetPort" (byval as HSNMP_ENTITY, byval as UINT) as SNMPAPI_STATUS
declare function SnmpSetRetransmitMode alias "SnmpSetRetransmitMode" (byval as smiUINT32) as SNMPAPI_STATUS
declare function SnmpSetRetry alias "SnmpSetRetry" (byval as HSNMP_ENTITY, byval as smiUINT32) as SNMPAPI_STATUS
declare function SnmpSetTimeout alias "SnmpSetTimeout" (byval as HSNMP_ENTITY, byval as smiTIMETICKS) as SNMPAPI_STATUS
declare function SnmpSetTranslateMode alias "SnmpSetTranslateMode" (byval as smiUINT32) as SNMPAPI_STATUS
declare function SnmpSetVb alias "SnmpSetVb" (byval as HSNMP_VBL, byval as smiUINT32, byval as smiLPCOID, byval as smiLPCVALUE) as SNMPAPI_STATUS
declare function SnmpStartup alias "SnmpStartup" (byval as smiLPUINT32, byval as smiLPUINT32, byval as smiLPUINT32, byval as smiLPUINT32, byval as smiLPUINT32) as SNMPAPI_STATUS
declare function SnmpStrToContext alias "SnmpStrToContext" (byval as HSNMP_SESSION, byval as smiLPCOCTETS) as HSNMP_CONTEXT
declare function SnmpStrToEntity alias "SnmpStrToEntity" (byval as HSNMP_SESSION, byval as LPCSTR) as HSNMP_ENTITY
declare function SnmpStrToOid alias "SnmpStrToOid" (byval as LPCSTR, byval as smiLPOID) as SNMPAPI_STATUS
declare function SnmpCreateEntity alias "SnmpCreateEntity" (byval as HSNMP_SESSION, byval as smiLPENTITYINFO) as HSNMP_ENTITY
declare function SnmpGetEntityInfo alias "SnmpGetEntityInfo" (byval as HSNMP_ENTITY, byval as smiLPENTITYINFO) as SNMPAPI_STATUS
declare function SnmpSetEntityInfo alias "SnmpSetEntityInfo" (byval as HSNMP_ENTITY, byval as smiLPENTITYINFO) as SNMPAPI_STATUS
declare function SnmpFreeEntityInfo alias "SnmpFreeEntityInfo" (byval as smiLPENTITYINFO) as SNMPAPI_STATUS
declare function SnmpCreateContext alias "SnmpCreateContext" (byval as HSNMP_SESSION, byval as smiLPCONTEXTINFO) as HSNMP_CONTEXT
declare function SnmpGetContextInfo alias "SnmpGetContextInfo" (byval as HSNMP_CONTEXT, byval as smiLPCONTEXTINFO) as SNMPAPI_STATUS
declare function SnmpSetContextInfo alias "SnmpSetContextInfo" (byval as HSNMP_CONTEXT, byval as smiLPCONTEXTINFO) as SNMPAPI_STATUS
declare function SnmpFreeContextInfo alias "SnmpFreeContextInfo" (byval as smiLPCONTEXTINFO) as SNMPAPI_STATUS
declare function SnmpPasswordToKey alias "SnmpPasswordToKey" (byval as smiLPOCTETS, byval as smiINT32, byval as smiLPOCTETS) as SNMPAPI_STATUS

#endif
