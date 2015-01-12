#pragma once

#include once "crt/limits.bi"

#inclib "wsnmp32"

extern "Windows"

#define _INC_WINSNMP

type HSNMP_SESSION as HANDLE
type LPHSNMP_SESSION as HANDLE ptr
type HSNMP_ENTITY as HANDLE
type LPHSNMP_ENTITY as HANDLE ptr
type HSNMP_CONTEXT as HANDLE
type LPHSNMP_CONTEXT as HANDLE ptr
type HSNMP_PDU as HANDLE
type LPHSNMP_PDU as HANDLE ptr
type HSNMP_VBL as HANDLE
type LPHSNMP_VBL as HANDLE ptr
type smiBYTE as ubyte
type smiLPBYTE as ubyte ptr
type smiINT as long
type smiLPINT as long ptr
type smiINT32 as smiINT
type smiLPINT32 as smiINT ptr
type smiUINT32 as ulong
type smiLPUINT32 as ulong ptr

type smiOCTETS
	len as smiUINT32
	ptr as smiLPBYTE
end type

type smiLPOCTETS as smiOCTETS ptr
type smiLPCOCTETS as const smiOCTETS ptr
type smiBITS as smiOCTETS
type smiLPBITS as smiOCTETS ptr

type smiOID
	len as smiUINT32
	ptr as smiLPUINT32
end type

type smiLPOID as smiOID ptr
type smiLPCOID as const smiOID ptr
type smiIPADDR as smiOCTETS
type smiLPIPADDR as smiOCTETS ptr
type smiCNTR32 as smiUINT32
type smiLPCNTR32 as smiUINT32 ptr
type smiGAUGE32 as smiUINT32
type smiLPGAUGE32 as smiUINT32 ptr
type smiTIMETICKS as smiUINT32
type smiLPTIMETICKS as smiUINT32 ptr
type smiOPAQUE as smiOCTETS
type smiLPOPAQUE as smiOCTETS ptr
type smiNSAPADDR as smiOCTETS
type smiLPNSAPADDR as smiOCTETS ptr

type smiCNTR64
	hipart as smiUINT32
	lopart as smiUINT32
end type

type smiLPCNTR64 as smiCNTR64 ptr

#define ASN_UNIVERSAL &h00
#define ASN_APPLICATION &h40
#define ASN_CONTEXT &h80
#define ASN_PRIVATE &hC0
#define ASN_PRIMITIVE &h00
#define ASN_CONSTRUCTOR &h20
#define SNMP_SYNTAX_SEQUENCE ((ASN_UNIVERSAL or ASN_CONSTRUCTOR) or &h10)
#define SNMP_SYNTAX_INT ((ASN_UNIVERSAL or ASN_PRIMITIVE) or &h02)
#define SNMP_SYNTAX_BITS ((ASN_UNIVERSAL or ASN_PRIMITIVE) or &h03)
#define SNMP_SYNTAX_OCTETS ((ASN_UNIVERSAL or ASN_PRIMITIVE) or &h04)
#define SNMP_SYNTAX_NULL ((ASN_UNIVERSAL or ASN_PRIMITIVE) or &h05)
#define SNMP_SYNTAX_OID ((ASN_UNIVERSAL or ASN_PRIMITIVE) or &h06)
#define SNMP_SYNTAX_INT32 SNMP_SYNTAX_INT
#define SNMP_SYNTAX_IPADDR ((ASN_APPLICATION or ASN_PRIMITIVE) or &h00)
#define SNMP_SYNTAX_CNTR32 ((ASN_APPLICATION or ASN_PRIMITIVE) or &h01)
#define SNMP_SYNTAX_GAUGE32 ((ASN_APPLICATION or ASN_PRIMITIVE) or &h02)
#define SNMP_SYNTAX_TIMETICKS ((ASN_APPLICATION or ASN_PRIMITIVE) or &h03)
#define SNMP_SYNTAX_OPAQUE ((ASN_APPLICATION or ASN_PRIMITIVE) or &h04)
#define SNMP_SYNTAX_NSAPADDR ((ASN_APPLICATION or ASN_PRIMITIVE) or &h05)
#define SNMP_SYNTAX_CNTR64 ((ASN_APPLICATION or ASN_PRIMITIVE) or &h06)
#define SNMP_SYNTAX_UINT32 ((ASN_APPLICATION or ASN_PRIMITIVE) or &h07)
#define SNMP_SYNTAX_UNSIGNED32 SNMP_SYNTAX_GAUGE32
#define SNMP_SYNTAX_NOSUCHOBJECT ((ASN_CONTEXT or ASN_PRIMITIVE) or &h00)
#define SNMP_SYNTAX_NOSUCHINSTANCE ((ASN_CONTEXT or ASN_PRIMITIVE) or &h01)
#define SNMP_SYNTAX_ENDOFMIBVIEW ((ASN_CONTEXT or ASN_PRIMITIVE) or &h02)

union __value
	sNumber as smiINT
	uNumber as smiUINT32
	hNumber as smiCNTR64
	string as smiOCTETS
	oid as smiOID
	empty as smiBYTE
end union

type smiVALUE
	syntax as smiUINT32
	value as __value
end type

type smiLPVALUE as smiVALUE ptr
type smiLPCVALUE as const smiVALUE ptr

#define MAXOBJIDSIZE 128
#define MAXOBJIDSTRSIZE 1408
#define SNMP_PDU_GET ((ASN_CONTEXT or ASN_CONSTRUCTOR) or &h0)
#define SNMP_PDU_GETNEXT ((ASN_CONTEXT or ASN_CONSTRUCTOR) or &h1)
#define SNMP_PDU_RESPONSE ((ASN_CONTEXT or ASN_CONSTRUCTOR) or &h2)
#define SNMP_PDU_SET ((ASN_CONTEXT or ASN_CONSTRUCTOR) or &h3)
#define SNMP_PDU_V1TRAP ((ASN_CONTEXT or ASN_CONSTRUCTOR) or &h4)
#define SNMP_PDU_GETBULK ((ASN_CONTEXT or ASN_CONSTRUCTOR) or &h5)
#define SNMP_PDU_INFORM ((ASN_CONTEXT or ASN_CONSTRUCTOR) or &h6)
#define SNMP_PDU_TRAP ((ASN_CONTEXT or ASN_CONSTRUCTOR) or &h7)
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
#define SNMPAPI_TRANSLATED 0
#define SNMPAPI_UNTRANSLATED_V1 1
#define SNMPAPI_UNTRANSLATED_V2 2
#define SNMPAPI_NO_SUPPORT 0
#define SNMPAPI_V1_SUPPORT 1
#define SNMPAPI_V2_SUPPORT 2
#define SNMPAPI_M2M_SUPPORT 3
#define SNMPAPI_OFF 0
#define SNMPAPI_ON 1

type SNMPAPI_STATUS as smiUINT32

#define SNMPAPI_FAILURE 0
#define SNMPAPI_SUCCESS 1
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
#define MAXVENDORINFO 32

type smiVENDORINFO
	vendorName as zstring * 32 * 2
	vendorContact as zstring * 32 * 2
	vendorVersionId as zstring * 32
	vendorVersionDate as zstring * 32
	vendorEnterprise as smiUINT32
end type

type smiLPVENDORINFO as smiVENDORINFO ptr
type SNMPAPI_CALLBACK as function(byval hSession as HSNMP_SESSION, byval hWnd as HWND, byval wMsg as UINT, byval wParam as WPARAM, byval lParam as LPARAM, byval lpClientData as LPVOID) as SNMPAPI_STATUS

declare function SnmpGetTranslateMode(byval nTranslateMode as smiLPUINT32) as SNMPAPI_STATUS
declare function SnmpSetTranslateMode(byval nTranslateMode as smiUINT32) as SNMPAPI_STATUS
declare function SnmpGetRetransmitMode(byval nRetransmitMode as smiLPUINT32) as SNMPAPI_STATUS
declare function SnmpSetRetransmitMode(byval nRetransmitMode as smiUINT32) as SNMPAPI_STATUS
declare function SnmpGetTimeout(byval hEntity as HSNMP_ENTITY, byval nPolicyTimeout as smiLPTIMETICKS, byval nActualTimeout as smiLPTIMETICKS) as SNMPAPI_STATUS
declare function SnmpSetTimeout(byval hEntity as HSNMP_ENTITY, byval nPolicyTimeout as smiTIMETICKS) as SNMPAPI_STATUS
declare function SnmpGetRetry(byval hEntity as HSNMP_ENTITY, byval nPolicyRetry as smiLPUINT32, byval nActualRetry as smiLPUINT32) as SNMPAPI_STATUS
declare function SnmpSetRetry(byval hEntity as HSNMP_ENTITY, byval nPolicyRetry as smiUINT32) as SNMPAPI_STATUS
declare function SnmpGetVendorInfo(byval vendorInfo as smiLPVENDORINFO) as SNMPAPI_STATUS
declare function SnmpStartup(byval nMajorVersion as smiLPUINT32, byval nMinorVersion as smiLPUINT32, byval nLevel as smiLPUINT32, byval nTranslateMode as smiLPUINT32, byval nRetransmitMode as smiLPUINT32) as SNMPAPI_STATUS
declare function SnmpCleanup() as SNMPAPI_STATUS
declare function SnmpOpen(byval hWnd as HWND, byval wMsg as UINT) as HSNMP_SESSION
declare function SnmpClose(byval session as HSNMP_SESSION) as SNMPAPI_STATUS
declare function SnmpSendMsg(byval session as HSNMP_SESSION, byval srcEntity as HSNMP_ENTITY, byval dstEntity as HSNMP_ENTITY, byval context as HSNMP_CONTEXT, byval PDU as HSNMP_PDU) as SNMPAPI_STATUS
declare function SnmpRecvMsg(byval session as HSNMP_SESSION, byval srcEntity as LPHSNMP_ENTITY, byval dstEntity as LPHSNMP_ENTITY, byval context as LPHSNMP_CONTEXT, byval PDU as LPHSNMP_PDU) as SNMPAPI_STATUS
declare function SnmpRegister(byval session as HSNMP_SESSION, byval srcEntity as HSNMP_ENTITY, byval dstEntity as HSNMP_ENTITY, byval context as HSNMP_CONTEXT, byval notification as smiLPCOID, byval state as smiUINT32) as SNMPAPI_STATUS
declare function SnmpCreateSession(byval hWnd as HWND, byval wMsg as UINT, byval fCallBack as SNMPAPI_CALLBACK, byval lpClientData as LPVOID) as HSNMP_SESSION
declare function SnmpListen(byval hEntity as HSNMP_ENTITY, byval lStatus as SNMPAPI_STATUS) as SNMPAPI_STATUS
declare function SnmpCancelMsg(byval session as HSNMP_SESSION, byval reqId as smiINT32) as SNMPAPI_STATUS
declare function SnmpStartupEx(byval nMajorVersion as smiLPUINT32, byval nMinorVersion as smiLPUINT32, byval nLevel as smiLPUINT32, byval nTranslateMode as smiLPUINT32, byval nRetransmitMode as smiLPUINT32) as SNMPAPI_STATUS

type PFNSNMPSTARTUPEX as function(byval as smiLPUINT32, byval as smiLPUINT32, byval as smiLPUINT32, byval as smiLPUINT32, byval as smiLPUINT32) as SNMPAPI_STATUS

declare function SnmpCleanupEx() as SNMPAPI_STATUS

type PFNSNMPCLEANUPEX as function() as SNMPAPI_STATUS

declare function SnmpStrToEntity(byval session as HSNMP_SESSION, byval string_ as LPCSTR) as HSNMP_ENTITY
declare function SnmpEntityToStr(byval entity as HSNMP_ENTITY, byval size as smiUINT32, byval string_ as LPSTR) as SNMPAPI_STATUS
declare function SnmpFreeEntity(byval entity as HSNMP_ENTITY) as SNMPAPI_STATUS
declare function SnmpStrToContext(byval session as HSNMP_SESSION, byval string_ as smiLPCOCTETS) as HSNMP_CONTEXT
declare function SnmpContextToStr(byval context as HSNMP_CONTEXT, byval string_ as smiLPOCTETS) as SNMPAPI_STATUS
declare function SnmpFreeContext(byval context as HSNMP_CONTEXT) as SNMPAPI_STATUS
declare function SnmpSetPort(byval hEntity as HSNMP_ENTITY, byval nPort as UINT) as SNMPAPI_STATUS
declare function SnmpCreatePdu(byval session as HSNMP_SESSION, byval PDU_type as smiINT, byval request_id as smiINT32, byval error_status as smiINT, byval error_index as smiINT, byval varbindlist as HSNMP_VBL) as HSNMP_PDU
declare function SnmpGetPduData(byval PDU as HSNMP_PDU, byval PDU_type as smiLPINT, byval request_id as smiLPINT32, byval error_status as smiLPINT, byval error_index as smiLPINT, byval varbindlist as LPHSNMP_VBL) as SNMPAPI_STATUS
declare function SnmpSetPduData(byval PDU as HSNMP_PDU, byval PDU_type as const smiINT ptr, byval request_id as const smiINT32 ptr, byval non_repeaters as const smiINT ptr, byval max_repetitions as const smiINT ptr, byval varbindlist as const HSNMP_VBL ptr) as SNMPAPI_STATUS
declare function SnmpDuplicatePdu(byval session as HSNMP_SESSION, byval PDU as HSNMP_PDU) as HSNMP_PDU
declare function SnmpFreePdu(byval PDU as HSNMP_PDU) as SNMPAPI_STATUS
declare function SnmpCreateVbl(byval session as HSNMP_SESSION, byval name_ as smiLPCOID, byval value as smiLPCVALUE) as HSNMP_VBL
declare function SnmpDuplicateVbl(byval session as HSNMP_SESSION, byval vbl as HSNMP_VBL) as HSNMP_VBL
declare function SnmpFreeVbl(byval vbl as HSNMP_VBL) as SNMPAPI_STATUS
declare function SnmpCountVbl(byval vbl as HSNMP_VBL) as SNMPAPI_STATUS
declare function SnmpGetVb(byval vbl as HSNMP_VBL, byval index as smiUINT32, byval name_ as smiLPOID, byval value as smiLPVALUE) as SNMPAPI_STATUS
declare function SnmpSetVb(byval vbl as HSNMP_VBL, byval index as smiUINT32, byval name_ as smiLPCOID, byval value as smiLPCVALUE) as SNMPAPI_STATUS
declare function SnmpDeleteVb(byval vbl as HSNMP_VBL, byval index as smiUINT32) as SNMPAPI_STATUS
declare function SnmpGetLastError(byval session as HSNMP_SESSION) as SNMPAPI_STATUS
declare function SnmpStrToOid(byval string_ as LPCSTR, byval dstOID as smiLPOID) as SNMPAPI_STATUS
declare function SnmpOidToStr(byval srcOID as smiLPCOID, byval size as smiUINT32, byval string_ as LPSTR) as SNMPAPI_STATUS
declare function SnmpOidCopy(byval srcOID as smiLPCOID, byval dstOID as smiLPOID) as SNMPAPI_STATUS
declare function SnmpOidCompare(byval xOID as smiLPCOID, byval yOID as smiLPCOID, byval maxlen as smiUINT32, byval result as smiLPINT) as SNMPAPI_STATUS
declare function SnmpEncodeMsg(byval session as HSNMP_SESSION, byval srcEntity as HSNMP_ENTITY, byval dstEntity as HSNMP_ENTITY, byval context as HSNMP_CONTEXT, byval pdu as HSNMP_PDU, byval msgBufDesc as smiLPOCTETS) as SNMPAPI_STATUS
declare function SnmpDecodeMsg(byval session as HSNMP_SESSION, byval srcEntity as LPHSNMP_ENTITY, byval dstEntity as LPHSNMP_ENTITY, byval context as LPHSNMP_CONTEXT, byval pdu as LPHSNMP_PDU, byval msgBufDesc as smiLPCOCTETS) as SNMPAPI_STATUS
declare function SnmpFreeDescriptor(byval syntax as smiUINT32, byval descriptor as smiLPOPAQUE) as SNMPAPI_STATUS

end extern
