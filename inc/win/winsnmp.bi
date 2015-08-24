'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   This Software is provided under the Zope Public License (ZPL) Version 2.1.
''
''   Copyright (c) 2009, 2010 by the mingw-w64 project
''
''   See the AUTHORS file for the list of contributors to the mingw-w64 project.
''
''   This license has been certified as open source. It has also been designated
''   as GPL compatible by the Free Software Foundation (FSF).
''
''   Redistribution and use in source and binary forms, with or without
''   modification, are permitted provided that the following conditions are met:
''
''     1. Redistributions in source code must retain the accompanying copyright
''        notice, this list of conditions, and the following disclaimer.
''     2. Redistributions in binary form must reproduce the accompanying
''        copyright notice, this list of conditions, and the following disclaimer
''        in the documentation and/or other materials provided with the
''        distribution.
''     3. Names of the copyright holders must not be used to endorse or promote
''        products derived from this software without prior written permission
''        from the copyright holders.
''     4. The right to distribute this software or to use it for any purpose does
''        not give you the right to use Servicemarks (sm) or Trademarks (tm) of
''        the copyright holders.  Use of them is covered by separate agreement
''        with the copyright holders.
''     5. If any files are modified, you must cause the modified files to carry
''        prominent notices stating that you changed the files and the date of
''        any change.
''
''   Disclaimer
''
''   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS ``AS IS'' AND ANY EXPRESSED
''   OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
''   OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
''   EVENT SHALL THE COPYRIGHT HOLDERS BE LIABLE FOR ANY DIRECT, INDIRECT,
''   INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
''   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, 
''   OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
''   LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
''   NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
''   EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "wsnmp32"

#include once "winapifamily.bi"
#include once "crt/limits.bi"

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
const ASN_UNIVERSAL = &h00
const ASN_APPLICATION = &h40
const ASN_CONTEXT = &h80
const ASN_PRIVATE = &hc0
const ASN_PRIMITIVE = &h00
const ASN_CONSTRUCTOR = &h20
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
type smiLPCVALUE as const smiVALUE ptr
const MAXOBJIDSIZE = 128
const MAXOBJIDSTRSIZE = 1408
#define SNMP_PDU_GET ((ASN_CONTEXT or ASN_CONSTRUCTOR) or &h0)
#define SNMP_PDU_GETNEXT ((ASN_CONTEXT or ASN_CONSTRUCTOR) or &h1)
#define SNMP_PDU_RESPONSE ((ASN_CONTEXT or ASN_CONSTRUCTOR) or &h2)
#define SNMP_PDU_SET ((ASN_CONTEXT or ASN_CONSTRUCTOR) or &h3)
#define SNMP_PDU_V1TRAP ((ASN_CONTEXT or ASN_CONSTRUCTOR) or &h4)
#define SNMP_PDU_GETBULK ((ASN_CONTEXT or ASN_CONSTRUCTOR) or &h5)
#define SNMP_PDU_INFORM ((ASN_CONTEXT or ASN_CONSTRUCTOR) or &h6)
#define SNMP_PDU_TRAP ((ASN_CONTEXT or ASN_CONSTRUCTOR) or &h7)
const SNMPLISTEN_USEENTITY_ADDR = 0
const SNMPLISTEN_ALL_ADDR = 1
const SNMP_TRAP_COLDSTART = 0
const SNMP_TRAP_WARMSTART = 1
const SNMP_TRAP_LINKDOWN = 2
const SNMP_TRAP_LINKUP = 3
const SNMP_TRAP_AUTHFAIL = 4
const SNMP_TRAP_EGPNEIGHBORLOSS = 5
const SNMP_TRAP_ENTERPRISESPECIFIC = 6
const SNMP_ERROR_NOERROR = 0
const SNMP_ERROR_TOOBIG = 1
const SNMP_ERROR_NOSUCHNAME = 2
const SNMP_ERROR_BADVALUE = 3
const SNMP_ERROR_READONLY = 4
const SNMP_ERROR_GENERR = 5
const SNMP_ERROR_NOACCESS = 6
const SNMP_ERROR_WRONGTYPE = 7
const SNMP_ERROR_WRONGLENGTH = 8
const SNMP_ERROR_WRONGENCODING = 9
const SNMP_ERROR_WRONGVALUE = 10
const SNMP_ERROR_NOCREATION = 11
const SNMP_ERROR_INCONSISTENTVALUE = 12
const SNMP_ERROR_RESOURCEUNAVAILABLE = 13
const SNMP_ERROR_COMMITFAILED = 14
const SNMP_ERROR_UNDOFAILED = 15
const SNMP_ERROR_AUTHORIZATIONERROR = 16
const SNMP_ERROR_NOTWRITABLE = 17
const SNMP_ERROR_INCONSISTENTNAME = 18
const SNMPAPI_TRANSLATED = 0
const SNMPAPI_UNTRANSLATED_V1 = 1
const SNMPAPI_UNTRANSLATED_V2 = 2
const SNMPAPI_NO_SUPPORT = 0
const SNMPAPI_V1_SUPPORT = 1
const SNMPAPI_V2_SUPPORT = 2
const SNMPAPI_M2M_SUPPORT = 3
const SNMPAPI_OFF = 0
const SNMPAPI_ON = 1
type SNMPAPI_STATUS as smiUINT32
const SNMPAPI_FAILURE = 0
const SNMPAPI_SUCCESS = 1
const SNMPAPI_ALLOC_ERROR = 2
const SNMPAPI_CONTEXT_INVALID = 3
const SNMPAPI_CONTEXT_UNKNOWN = 4
const SNMPAPI_ENTITY_INVALID = 5
const SNMPAPI_ENTITY_UNKNOWN = 6
const SNMPAPI_INDEX_INVALID = 7
const SNMPAPI_NOOP = 8
const SNMPAPI_OID_INVALID = 9
const SNMPAPI_OPERATION_INVALID = 10
const SNMPAPI_OUTPUT_TRUNCATED = 11
const SNMPAPI_PDU_INVALID = 12
const SNMPAPI_SESSION_INVALID = 13
const SNMPAPI_SYNTAX_INVALID = 14
const SNMPAPI_VBL_INVALID = 15
const SNMPAPI_MODE_INVALID = 16
const SNMPAPI_SIZE_INVALID = 17
const SNMPAPI_NOT_INITIALIZED = 18
const SNMPAPI_MESSAGE_INVALID = 19
const SNMPAPI_HWND_INVALID = 20
const SNMPAPI_OTHER_ERROR = 99
const SNMPAPI_TL_NOT_INITIALIZED = 100
const SNMPAPI_TL_NOT_SUPPORTED = 101
const SNMPAPI_TL_NOT_AVAILABLE = 102
const SNMPAPI_TL_RESOURCE_ERROR = 103
const SNMPAPI_TL_UNDELIVERABLE = 104
const SNMPAPI_TL_SRC_INVALID = 105
const SNMPAPI_TL_INVALID_PARAM = 106
const SNMPAPI_TL_IN_USE = 107
const SNMPAPI_TL_TIMEOUT = 108
const SNMPAPI_TL_PDU_TOO_BIG = 109
const SNMPAPI_TL_OTHER = 199
const MAXVENDORINFO = 32

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
declare function SnmpListenEx(byval hEntity as HSNMP_ENTITY, byval lStatus as SNMPAPI_STATUS, byval nUseEntityAddr as smiUINT32) as SNMPAPI_STATUS
declare function SnmpCancelMsg(byval session as HSNMP_SESSION, byval reqId as smiINT32) as SNMPAPI_STATUS
declare function SnmpStartupEx(byval nMajorVersion as smiLPUINT32, byval nMinorVersion as smiLPUINT32, byval nLevel as smiLPUINT32, byval nTranslateMode as smiLPUINT32, byval nRetransmitMode as smiLPUINT32) as SNMPAPI_STATUS
type PFNSNMPSTARTUPEX as function(byval as smiLPUINT32, byval as smiLPUINT32, byval as smiLPUINT32, byval as smiLPUINT32, byval as smiLPUINT32) as SNMPAPI_STATUS
declare function SnmpCleanupEx() as SNMPAPI_STATUS
type PFNSNMPCLEANUPEX as function() as SNMPAPI_STATUS
declare function SnmpStrToEntity(byval session as HSNMP_SESSION, byval string as LPCSTR) as HSNMP_ENTITY
declare function SnmpEntityToStr(byval entity as HSNMP_ENTITY, byval size as smiUINT32, byval string as LPSTR) as SNMPAPI_STATUS
declare function SnmpFreeEntity(byval entity as HSNMP_ENTITY) as SNMPAPI_STATUS
declare function SnmpStrToContext(byval session as HSNMP_SESSION, byval string as smiLPCOCTETS) as HSNMP_CONTEXT
declare function SnmpContextToStr(byval context as HSNMP_CONTEXT, byval string as smiLPOCTETS) as SNMPAPI_STATUS
declare function SnmpFreeContext(byval context as HSNMP_CONTEXT) as SNMPAPI_STATUS
declare function SnmpSetPort(byval hEntity as HSNMP_ENTITY, byval nPort as UINT) as SNMPAPI_STATUS
declare function SnmpCreatePdu(byval session as HSNMP_SESSION, byval PDU_type as smiINT, byval request_id as smiINT32, byval error_status as smiINT, byval error_index as smiINT, byval varbindlist as HSNMP_VBL) as HSNMP_PDU
declare function SnmpGetPduData(byval PDU as HSNMP_PDU, byval PDU_type as smiLPINT, byval request_id as smiLPINT32, byval error_status as smiLPINT, byval error_index as smiLPINT, byval varbindlist as LPHSNMP_VBL) as SNMPAPI_STATUS
declare function SnmpSetPduData(byval PDU as HSNMP_PDU, byval PDU_type as const smiINT ptr, byval request_id as const smiINT32 ptr, byval non_repeaters as const smiINT ptr, byval max_repetitions as const smiINT ptr, byval varbindlist as const HSNMP_VBL ptr) as SNMPAPI_STATUS
declare function SnmpDuplicatePdu(byval session as HSNMP_SESSION, byval PDU as HSNMP_PDU) as HSNMP_PDU
declare function SnmpFreePdu(byval PDU as HSNMP_PDU) as SNMPAPI_STATUS
declare function SnmpCreateVbl(byval session as HSNMP_SESSION, byval name as smiLPCOID, byval value as smiLPCVALUE) as HSNMP_VBL
declare function SnmpDuplicateVbl(byval session as HSNMP_SESSION, byval vbl as HSNMP_VBL) as HSNMP_VBL
declare function SnmpFreeVbl(byval vbl as HSNMP_VBL) as SNMPAPI_STATUS
declare function SnmpCountVbl(byval vbl as HSNMP_VBL) as SNMPAPI_STATUS
declare function SnmpGetVb(byval vbl as HSNMP_VBL, byval index as smiUINT32, byval name as smiLPOID, byval value as smiLPVALUE) as SNMPAPI_STATUS
declare function SnmpSetVb(byval vbl as HSNMP_VBL, byval index as smiUINT32, byval name as smiLPCOID, byval value as smiLPCVALUE) as SNMPAPI_STATUS
declare function SnmpDeleteVb(byval vbl as HSNMP_VBL, byval index as smiUINT32) as SNMPAPI_STATUS
declare function SnmpGetLastError(byval session as HSNMP_SESSION) as SNMPAPI_STATUS
declare function SnmpStrToOid(byval string as LPCSTR, byval dstOID as smiLPOID) as SNMPAPI_STATUS
declare function SnmpOidToStr(byval srcOID as smiLPCOID, byval size as smiUINT32, byval string as LPSTR) as SNMPAPI_STATUS
declare function SnmpOidCopy(byval srcOID as smiLPCOID, byval dstOID as smiLPOID) as SNMPAPI_STATUS
declare function SnmpOidCompare(byval xOID as smiLPCOID, byval yOID as smiLPCOID, byval maxlen as smiUINT32, byval result as smiLPINT) as SNMPAPI_STATUS
declare function SnmpEncodeMsg(byval session as HSNMP_SESSION, byval srcEntity as HSNMP_ENTITY, byval dstEntity as HSNMP_ENTITY, byval context as HSNMP_CONTEXT, byval pdu as HSNMP_PDU, byval msgBufDesc as smiLPOCTETS) as SNMPAPI_STATUS
declare function SnmpDecodeMsg(byval session as HSNMP_SESSION, byval srcEntity as LPHSNMP_ENTITY, byval dstEntity as LPHSNMP_ENTITY, byval context as LPHSNMP_CONTEXT, byval pdu as LPHSNMP_PDU, byval msgBufDesc as smiLPCOCTETS) as SNMPAPI_STATUS
declare function SnmpFreeDescriptor(byval syntax as smiUINT32, byval descriptor as smiLPOPAQUE) as SNMPAPI_STATUS

end extern
