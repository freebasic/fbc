'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   DISCLAIMER
''   This file has no copyright assigned and is placed in the Public Domain.
''   This file is part of the mingw-w64 runtime package.
''
''   The mingw-w64 runtime package and its code is distributed in the hope that it 
''   will be useful but WITHOUT ANY WARRANTY.  ALL WARRANTIES, EXPRESSED OR 
''   IMPLIED ARE HEREBY DISCLAIMED.  This includes but is not limited to 
''   warranties of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "snmpapi"
#inclib "igmpagnt"

#include once "windows.bi"

extern "Windows"

#define _INC_SNMP

type AsnOctetString field = 4
	stream as UBYTE ptr
	length as UINT
	dynamic as WINBOOL
end type

type AsnObjectIdentifier field = 4
	idLength as UINT
	ids as UINT ptr
end type

type AsnInteger32 as LONG
type AsnUnsigned32 as ULONG
type AsnCounter64 as ULARGE_INTEGER
type AsnCounter32 as AsnUnsigned32
type AsnGauge32 as AsnUnsigned32
type AsnTimeticks as AsnUnsigned32
type AsnBits as AsnOctetString
type AsnSequence as AsnOctetString
type AsnImplicitSequence as AsnOctetString
type AsnIPAddress as AsnOctetString
type AsnNetworkAddress as AsnOctetString
type AsnDisplayString as AsnOctetString
type AsnOpaque as AsnOctetString

union AsnAny_asnValue field = 4
	number as AsnInteger32
	unsigned32 as AsnUnsigned32
	counter64 as AsnCounter64
	string as AsnOctetString
	bits as AsnBits
	object as AsnObjectIdentifier
	sequence as AsnSequence
	address as AsnIPAddress
	counter as AsnCounter32
	gauge as AsnGauge32
	ticks as AsnTimeticks
	arbitrary as AsnOpaque
end union

type AsnAny field = 4
	asnType as UBYTE
	asnValue as AsnAny_asnValue
end type

type AsnObjectName as AsnObjectIdentifier
type AsnObjectSyntax as AsnAny

type SnmpVarBind field = 4
	name as AsnObjectName
	value as AsnObjectSyntax
end type

type SnmpVarBindList field = 4
	list as SnmpVarBind ptr
	len as UINT
end type

const ASN_UNIVERSAL = &h00
const ASN_APPLICATION = &h40
const ASN_CONTEXT = &h80
const ASN_PRIVATE = &hC0
const ASN_PRIMITIVE = &h00
const ASN_CONSTRUCTOR = &h20
#define SNMP_PDU_GET ((ASN_CONTEXT or ASN_CONSTRUCTOR) or &h0)
#define SNMP_PDU_GETNEXT ((ASN_CONTEXT or ASN_CONSTRUCTOR) or &h1)
#define SNMP_PDU_RESPONSE ((ASN_CONTEXT or ASN_CONSTRUCTOR) or &h2)
#define SNMP_PDU_SET ((ASN_CONTEXT or ASN_CONSTRUCTOR) or &h3)
#define SNMP_PDU_V1TRAP ((ASN_CONTEXT or ASN_CONSTRUCTOR) or &h4)
#define SNMP_PDU_GETBULK ((ASN_CONTEXT or ASN_CONSTRUCTOR) or &h5)
#define SNMP_PDU_INFORM ((ASN_CONTEXT or ASN_CONSTRUCTOR) or &h6)
#define SNMP_PDU_TRAP ((ASN_CONTEXT or ASN_CONSTRUCTOR) or &h7)
#define ASN_INTEGER ((ASN_UNIVERSAL or ASN_PRIMITIVE) or &h02)
#define ASN_BITS ((ASN_UNIVERSAL or ASN_PRIMITIVE) or &h03)
#define ASN_OCTETSTRING ((ASN_UNIVERSAL or ASN_PRIMITIVE) or &h04)
#define ASN_NULL ((ASN_UNIVERSAL or ASN_PRIMITIVE) or &h05)
#define ASN_OBJECTIDENTIFIER ((ASN_UNIVERSAL or ASN_PRIMITIVE) or &h06)
#define ASN_INTEGER32 ASN_INTEGER
#define ASN_SEQUENCE ((ASN_UNIVERSAL or ASN_CONSTRUCTOR) or &h10)
#define ASN_SEQUENCEOF ASN_SEQUENCE
#define ASN_IPADDRESS ((ASN_APPLICATION or ASN_PRIMITIVE) or &h00)
#define ASN_COUNTER32 ((ASN_APPLICATION or ASN_PRIMITIVE) or &h01)
#define ASN_GAUGE32 ((ASN_APPLICATION or ASN_PRIMITIVE) or &h02)
#define ASN_TIMETICKS ((ASN_APPLICATION or ASN_PRIMITIVE) or &h03)
#define ASN_OPAQUE ((ASN_APPLICATION or ASN_PRIMITIVE) or &h04)
#define ASN_COUNTER64 ((ASN_APPLICATION or ASN_PRIMITIVE) or &h06)
#define ASN_UINTEGER32 ((ASN_APPLICATION or ASN_PRIMITIVE) or &h07)
#define ASN_RFC2578_UNSIGNED32 ASN_GAUGE32
#define SNMP_EXCEPTION_NOSUCHOBJECT ((ASN_CONTEXT or ASN_PRIMITIVE) or &h00)
#define SNMP_EXCEPTION_NOSUCHINSTANCE ((ASN_CONTEXT or ASN_PRIMITIVE) or &h01)
#define SNMP_EXCEPTION_ENDOFMIBVIEW ((ASN_CONTEXT or ASN_PRIMITIVE) or &h02)
#define SNMP_EXTENSION_GET SNMP_PDU_GET
#define SNMP_EXTENSION_GET_NEXT SNMP_PDU_GETNEXT
#define SNMP_EXTENSION_GET_BULK SNMP_PDU_GETBULK
#define SNMP_EXTENSION_SET_TEST ((ASN_PRIVATE or ASN_CONSTRUCTOR) or &h0)
#define SNMP_EXTENSION_SET_COMMIT SNMP_PDU_SET
#define SNMP_EXTENSION_SET_UNDO ((ASN_PRIVATE or ASN_CONSTRUCTOR) or &h1)
#define SNMP_EXTENSION_SET_CLEANUP ((ASN_PRIVATE or ASN_CONSTRUCTOR) or &h2)
const SNMP_ERRORSTATUS_NOERROR = 0
const SNMP_ERRORSTATUS_TOOBIG = 1
const SNMP_ERRORSTATUS_NOSUCHNAME = 2
const SNMP_ERRORSTATUS_BADVALUE = 3
const SNMP_ERRORSTATUS_READONLY = 4
const SNMP_ERRORSTATUS_GENERR = 5
const SNMP_ERRORSTATUS_NOACCESS = 6
const SNMP_ERRORSTATUS_WRONGTYPE = 7
const SNMP_ERRORSTATUS_WRONGLENGTH = 8
const SNMP_ERRORSTATUS_WRONGENCODING = 9
const SNMP_ERRORSTATUS_WRONGVALUE = 10
const SNMP_ERRORSTATUS_NOCREATION = 11
const SNMP_ERRORSTATUS_INCONSISTENTVALUE = 12
const SNMP_ERRORSTATUS_RESOURCEUNAVAILABLE = 13
const SNMP_ERRORSTATUS_COMMITFAILED = 14
const SNMP_ERRORSTATUS_UNDOFAILED = 15
const SNMP_ERRORSTATUS_AUTHORIZATIONERROR = 16
const SNMP_ERRORSTATUS_NOTWRITABLE = 17
const SNMP_ERRORSTATUS_INCONSISTENTNAME = 18
const SNMP_GENERICTRAP_COLDSTART = 0
const SNMP_GENERICTRAP_WARMSTART = 1
const SNMP_GENERICTRAP_LINKDOWN = 2
const SNMP_GENERICTRAP_LINKUP = 3
const SNMP_GENERICTRAP_AUTHFAILURE = 4
const SNMP_GENERICTRAP_EGPNEIGHLOSS = 5
const SNMP_GENERICTRAP_ENTERSPECIFIC = 6
const SNMP_ACCESS_NONE = 0
const SNMP_ACCESS_NOTIFY = 1
const SNMP_ACCESS_READ_ONLY = 2
const SNMP_ACCESS_READ_WRITE = 3
const SNMP_ACCESS_READ_CREATE = 4
type SNMPAPI as INT_
const SNMPAPI_NOERROR = CTRUE
const SNMPAPI_ERROR = FALSE

declare function SnmpExtensionInit(byval dwUptimeReference as DWORD, byval phSubagentTrapEvent as HANDLE ptr, byval pFirstSupportedRegion as AsnObjectIdentifier ptr) as WINBOOL
declare function SnmpExtensionInitEx(byval pNextSupportedRegion as AsnObjectIdentifier ptr) as WINBOOL
declare function SnmpExtensionMonitor(byval pAgentMgmtData as LPVOID) as WINBOOL
declare function SnmpExtensionQuery(byval bPduType as UBYTE, byval pVarBindList as SnmpVarBindList ptr, byval pErrorStatus as AsnInteger32 ptr, byval pErrorIndex as AsnInteger32 ptr) as WINBOOL
declare function SnmpExtensionQueryEx(byval nRequestType as UINT, byval nTransactionId as UINT, byval pVarBindList as SnmpVarBindList ptr, byval pContextInfo as AsnOctetString ptr, byval pErrorStatus as AsnInteger32 ptr, byval pErrorIndex as AsnInteger32 ptr) as WINBOOL
declare function SnmpExtensionTrap(byval pEnterpriseOid as AsnObjectIdentifier ptr, byval pGenericTrapId as AsnInteger32 ptr, byval pSpecificTrapId as AsnInteger32 ptr, byval pTimeStamp as AsnTimeticks ptr, byval pVarBindList as SnmpVarBindList ptr) as WINBOOL
declare sub SnmpExtensionClose()

type PFNSNMPEXTENSIONINIT as function(byval dwUpTimeReference as DWORD, byval phSubagentTrapEvent as HANDLE ptr, byval pFirstSupportedRegion as AsnObjectIdentifier ptr) as WINBOOL
type PFNSNMPEXTENSIONINITEX as function(byval pNextSupportedRegion as AsnObjectIdentifier ptr) as WINBOOL
type PFNSNMPEXTENSIONMONITOR as function(byval pAgentMgmtData as LPVOID) as WINBOOL
type PFNSNMPEXTENSIONQUERY as function(byval bPduType as UBYTE, byval pVarBindList as SnmpVarBindList ptr, byval pErrorStatus as AsnInteger32 ptr, byval pErrorIndex as AsnInteger32 ptr) as WINBOOL
type PFNSNMPEXTENSIONQUERYEX as function(byval nRequestType as UINT, byval nTransactionId as UINT, byval pVarBindList as SnmpVarBindList ptr, byval pContextInfo as AsnOctetString ptr, byval pErrorStatus as AsnInteger32 ptr, byval pErrorIndex as AsnInteger32 ptr) as WINBOOL
type PFNSNMPEXTENSIONTRAP as function(byval pEnterpriseOid as AsnObjectIdentifier ptr, byval pGenericTrapId as AsnInteger32 ptr, byval pSpecificTrapId as AsnInteger32 ptr, byval pTimeStamp as AsnTimeticks ptr, byval pVarBindList as SnmpVarBindList ptr) as WINBOOL
type PFNSNMPEXTENSIONCLOSE as sub()

declare function SnmpUtilOidCpy(byval pOidDst as AsnObjectIdentifier ptr, byval pOidSrc as AsnObjectIdentifier ptr) as INT_
declare function SnmpUtilOidAppend(byval pOidDst as AsnObjectIdentifier ptr, byval pOidSrc as AsnObjectIdentifier ptr) as INT_
declare function SnmpUtilOidNCmp(byval pOid1 as AsnObjectIdentifier ptr, byval pOid2 as AsnObjectIdentifier ptr, byval nSubIds as UINT) as INT_
declare function SnmpUtilOidCmp(byval pOid1 as AsnObjectIdentifier ptr, byval pOid2 as AsnObjectIdentifier ptr) as INT_
declare sub SnmpUtilOidFree(byval pOid as AsnObjectIdentifier ptr)
declare function SnmpUtilOctetsCmp(byval pOctets1 as AsnOctetString ptr, byval pOctets2 as AsnOctetString ptr) as INT_
declare function SnmpUtilOctetsNCmp(byval pOctets1 as AsnOctetString ptr, byval pOctets2 as AsnOctetString ptr, byval nChars as UINT) as INT_
declare function SnmpUtilOctetsCpy(byval pOctetsDst as AsnOctetString ptr, byval pOctetsSrc as AsnOctetString ptr) as INT_
declare sub SnmpUtilOctetsFree(byval pOctets as AsnOctetString ptr)
declare function SnmpUtilAsnAnyCpy(byval pAnyDst as AsnAny ptr, byval pAnySrc as AsnAny ptr) as INT_
declare sub SnmpUtilAsnAnyFree(byval pAny as AsnAny ptr)
declare function SnmpUtilVarBindCpy(byval pVbDst as SnmpVarBind ptr, byval pVbSrc as SnmpVarBind ptr) as INT_
declare sub SnmpUtilVarBindFree(byval pVb as SnmpVarBind ptr)
declare function SnmpUtilVarBindListCpy(byval pVblDst as SnmpVarBindList ptr, byval pVblSrc as SnmpVarBindList ptr) as INT_
declare sub SnmpUtilVarBindListFree(byval pVbl as SnmpVarBindList ptr)
declare sub SnmpUtilMemFree(byval pMem as LPVOID)
declare function SnmpUtilMemAlloc(byval nBytes as UINT) as LPVOID
declare function SnmpUtilMemReAlloc(byval pMem as LPVOID, byval nBytes as UINT) as LPVOID
declare function SnmpUtilOidToA(byval Oid as AsnObjectIdentifier ptr) as LPSTR
declare function SnmpUtilIdsToA(byval Ids as UINT ptr, byval IdLength as UINT) as LPSTR
declare sub SnmpUtilPrintOid(byval Oid as AsnObjectIdentifier ptr)
declare sub SnmpUtilPrintAsnAny(byval pAny as AsnAny ptr)
declare function SnmpSvcGetUptime() as DWORD
declare sub SnmpSvcSetLogLevel(byval nLogLevel as INT_)
declare sub SnmpSvcSetLogType(byval nLogType as INT_)

const SNMP_LOG_SILENT = &h0
const SNMP_LOG_FATAL = &h1
const SNMP_LOG_ERROR = &h2
const SNMP_LOG_WARNING = &h3
const SNMP_LOG_TRACE = &h4
const SNMP_LOG_VERBOSE = &h5
const SNMP_OUTPUT_TO_CONSOLE = &h1
const SNMP_OUTPUT_TO_LOGFILE = &h2
const SNMP_OUTPUT_TO_EVENTLOG = &h4
const SNMP_OUTPUT_TO_DEBUGGER = &h8
declare sub SnmpUtilDbgPrint cdecl(byval nLogLevel as INT_, byval szFormat as LPSTR, ...)
#define SNMPDBG(_x_)
#define DEFINE_SIZEOF(Array) (ubound(Array) - lbound(Array) + 1)
#define DEFINE_OID(SubIdArray) (DEFINE_SIZEOF(SubIdArray), (SubIdArray))
#define DEFINE_NULLOID() (0, NULL)
#define DEFINE_NULLOCTETS() (NULL, 0, FALSE)
const DEFAULT_SNMP_PORT_UDP = 161
const DEFAULT_SNMP_PORT_IPX = 36879
const DEFAULT_SNMPTRAP_PORT_UDP = 162
const DEFAULT_SNMPTRAP_PORT_IPX = 36880
const SNMP_MAX_OID_LEN = 128
const SNMP_MEM_ALLOC_ERROR = 1
const SNMP_BERAPI_INVALID_LENGTH = 10
const SNMP_BERAPI_INVALID_TAG = 11
const SNMP_BERAPI_OVERFLOW = 12
const SNMP_BERAPI_SHORT_BUFFER = 13
const SNMP_BERAPI_INVALID_OBJELEM = 14
const SNMP_PDUAPI_UNRECOGNIZED_PDU = 20
const SNMP_PDUAPI_INVALID_ES = 21
const SNMP_PDUAPI_INVALID_GT = 22
const SNMP_AUTHAPI_INVALID_VERSION = 30
const SNMP_AUTHAPI_INVALID_MSG_TYPE = 31
const SNMP_AUTHAPI_TRIV_AUTH_FAILED = 32

declare function SNMP_oidcpy alias "SnmpUtilOidCpy"(byval pOidDst as AsnObjectIdentifier ptr, byval pOidSrc as AsnObjectIdentifier ptr) as INT_
declare function SNMP_oidappend alias "SnmpUtilOidAppend"(byval pOidDst as AsnObjectIdentifier ptr, byval pOidSrc as AsnObjectIdentifier ptr) as INT_
declare function SNMP_oidncmp alias "SnmpUtilOidNCmp"(byval pOid1 as AsnObjectIdentifier ptr, byval pOid2 as AsnObjectIdentifier ptr, byval nSubIds as UINT) as INT_
declare function SNMP_oidcmp alias "SnmpUtilOidCmp"(byval pOid1 as AsnObjectIdentifier ptr, byval pOid2 as AsnObjectIdentifier ptr) as INT_
declare sub SNMP_oidfree alias "SnmpUtilOidFree"(byval pOid as AsnObjectIdentifier ptr)
declare function SNMP_CopyVarBindList alias "SnmpUtilVarBindListCpy"(byval pVblDst as SnmpVarBindList ptr, byval pVblSrc as SnmpVarBindList ptr) as INT_
declare sub SNMP_FreeVarBindList alias "SnmpUtilVarBindListFree"(byval pVbl as SnmpVarBindList ptr)
declare function SNMP_CopyVarBind alias "SnmpUtilVarBindCpy"(byval pVbDst as SnmpVarBind ptr, byval pVbSrc as SnmpVarBind ptr) as INT_
declare sub SNMP_FreeVarBind alias "SnmpUtilVarBindFree"(byval pVb as SnmpVarBind ptr)
declare sub SNMP_printany alias "SnmpUtilPrintAsnAny"(byval pAny as AsnAny ptr)
declare sub SNMP_free alias "SnmpUtilMemFree"(byval pMem as LPVOID)
declare function SNMP_malloc alias "SnmpUtilMemAlloc"(byval nBytes as UINT) as LPVOID
declare function SNMP_realloc alias "SnmpUtilMemReAlloc"(byval pMem as LPVOID, byval nBytes as UINT) as LPVOID
declare sub SNMP_DBG_free alias "SnmpUtilMemFree"(byval pMem as LPVOID)
declare function SNMP_DBG_malloc alias "SnmpUtilMemAlloc"(byval nBytes as UINT) as LPVOID
declare function SNMP_DBG_realloc alias "SnmpUtilMemReAlloc"(byval pMem as LPVOID, byval nBytes as UINT) as LPVOID

#define ASN_RFC1155_IPADDRESS ASN_IPADDRESS
#define ASN_RFC1155_COUNTER ASN_COUNTER32
#define ASN_RFC1155_GAUGE ASN_GAUGE32
#define ASN_RFC1155_TIMETICKS ASN_TIMETICKS
#define ASN_RFC1155_OPAQUE ASN_OPAQUE
#define ASN_RFC1213_DISPSTRING ASN_OCTETSTRING
#define ASN_RFC1157_GETREQUEST SNMP_PDU_GET
#define ASN_RFC1157_GETNEXTREQUEST SNMP_PDU_GETNEXT
#define ASN_RFC1157_GETRESPONSE SNMP_PDU_RESPONSE
#define ASN_RFC1157_SETREQUEST SNMP_PDU_SET
#define ASN_RFC1157_TRAP SNMP_PDU_V1TRAP
#define ASN_CONTEXTSPECIFIC ASN_CONTEXT
#define ASN_PRIMATIVE ASN_PRIMITIVE

type RFC1157VarBindList as SnmpVarBindList
type RFC1157VarBind as SnmpVarBind
type AsnInteger as AsnInteger32
type AsnCounter as AsnCounter32
type AsnGauge as AsnGauge32
#define ASN_UNSIGNED32 ASN_UINTEGER32

end extern
