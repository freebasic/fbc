''
''
'' snmp -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_snmp_bi__
#define __win_snmp_bi__

#inclib "snmpapi"
#inclib "igmpagnt"

#define DEFAULT_SNMP_PORT_UDP 161
#define DEFAULT_SNMP_PORT_IPX 36879
#define DEFAULT_SNMPTRAP_PORT_UDP 162
#define DEFAULT_SNMPTRAP_PORT_IPX 36880
#define ASN_UNIVERSAL &h00
#define ASN_PRIMITIVE &h00
#define ASN_CONSTRUCTOR &h20
#define ASN_APPLICATION &h40
#define ASN_CONTEXT &h80
#define ASN_PRIVATE &hC0
#define SNMP_PDU_GET (&h80 or &h20 or 0)
#define SNMP_PDU_GETNEXT (&h80 or &h20 or 1)
#define SNMP_PDU_RESPONSE (&h80 or &h20 or 2)
#define SNMP_PDU_SET (&h80 or &h20 or 3)
#define SNMP_PDU_GETBULK (&h80 or &h20 or 4)
#define SNMP_PDU_V1TRAP (&h80 or &h20 or 4)
#define SNMP_PDU_INFORM (&h80 or &h20 or 6)
#define SNMP_PDU_TRAP (&h80 or &h20 or 7)
#define SNMP_PDU_REPORT (&h80 or &h20 or 8)
#define ASN_INTEGER (&h00 or &h00 or 2)
#define ASN_BITS (&h00 or &h00 or 3)
#define ASN_OCTETSTRING (&h00 or &h00 or 4)
#define ASN_NULL (&h00 or &h00 or 5)
#define ASN_OBJECTIDENTIFIER (&h00 or &h00 or 6)
#define ASN_INTEGER32 (&h00 or &h00 or 2)
#define ASN_SEQUENCE (&h00 or &h20 or &h10)
#define ASN_SEQUENCEOF (&h00 or &h20 or &h10)
#define ASN_IPADDRESS (&h40 or &h00 or &h00)
#define ASN_COUNTER32 (&h40 or &h00 or &h01)
#define ASN_GAUGE32 (&h40 or &h00 or &h02)
#define ASN_TIMETICKS (&h40 or &h00 or &h03)
#define ASN_OPAQUE (&h40 or &h00 or &h04)
#define ASN_COUNTER64 (&h40 or &h00 or &h06)
#define ASN_UNSIGNED32 (&h40 or &h00 or &h07)
#define SNMP_EXCEPTION_NOSUCHOBJECT (&h80 or &h00 or &h00)
#define SNMP_EXCEPTION_NOSUCHINSTANCE (&h80 or &h00 or &h01)
#define SNMP_EXCEPTION_ENDOFMIBVIEW (&h80 or &h00 or &h02)
#define SNMP_EXTENSION_GET (&h80 or &h20 or 0)
#define SNMP_EXTENSION_GET_NEXT (&h80 or &h20 or 1)
#define SNMP_EXTENSION_GET_BULK (&h80 or &h20 or 4)
#define SNMP_EXTENSION_SET_TEST (&hC0 or &h20 or &h0)
#define SNMP_EXTENSION_SET_COMMIT (&h80 or &h20 or 3)
#define SNMP_EXTENSION_SET_UNDO (&hC0 or &h20 or &h1)
#define SNMP_EXTENSION_SET_CLEANUP (&hC0 or &h20 or &h2)
#define SNMP_ERRORSTATUS_NOERROR 0
#define SNMP_ERRORSTATUS_TOOBIG 1
#define SNMP_ERRORSTATUS_NOSUCHNAME 2
#define SNMP_ERRORSTATUS_BADVALUE 3
#define SNMP_ERRORSTATUS_READONLY 4
#define SNMP_ERRORSTATUS_GENERR 5
#define SNMP_ERRORSTATUS_NOACCESS 6
#define SNMP_ERRORSTATUS_WRONGTYPE 7
#define SNMP_ERRORSTATUS_WRONGLENGTH 8
#define SNMP_ERRORSTATUS_WRONGENCODING 9
#define SNMP_ERRORSTATUS_WRONGVALUE 10
#define SNMP_ERRORSTATUS_NOCREATION 11
#define SNMP_ERRORSTATUS_INCONSISTENTVALUE 12
#define SNMP_ERRORSTATUS_RESOURCEUNAVAILABLE 13
#define SNMP_ERRORSTATUS_COMMITFAILED 14
#define SNMP_ERRORSTATUS_UNDOFAILED 15
#define SNMP_ERRORSTATUS_AUTHORIZATIONERROR 16
#define SNMP_ERRORSTATUS_NOTWRITABLE 17
#define SNMP_ERRORSTATUS_INCONSISTENTNAME 18
#define SNMP_GENERICTRAP_COLDSTART 0
#define SNMP_GENERICTRAP_WARMSTART 1
#define SNMP_GENERICTRAP_LINKDOWN 2
#define SNMP_GENERICTRAP_LINKUP 3
#define SNMP_GENERICTRAP_AUTHFAILURE 4
#define SNMP_GENERICTRAP_EGPNEIGHLOSS 5
#define SNMP_GENERICTRAP_ENTERSPECIFIC 6
#define SNMP_ACCESS_NONE 0
#define SNMP_ACCESS_NOTIFY 1
#define SNMP_ACCESS_READ_ONLY 2
#define SNMP_ACCESS_READ_WRITE 3
#define SNMP_ACCESS_READ_CREATE 4
#define SNMPAPI_ERROR 0
#define SNMPAPI_NOERROR 1
#define SNMP_LOG_SILENT 0
#define SNMP_LOG_FATAL 1
#define SNMP_LOG_ERROR 2
#define SNMP_LOG_WARNING 3
#define SNMP_LOG_TRACE 4
#define SNMP_LOG_VERBOSE 5
#define SNMP_OUTPUT_TO_CONSOLE 1
#define SNMP_OUTPUT_TO_LOGFILE 2
#define SNMP_OUTPUT_TO_EVENTLOG 4
#define SNMP_OUTPUT_TO_DEBUGGER 8
#define SNMP_MAX_OID_LEN 128
#define SNMP_MEM_ALLOC_ERROR 1
#define SNMP_BERAPI_INVALID_LENGTH 10
#define SNMP_BERAPI_INVALID_TAG 11
#define SNMP_BERAPI_OVERFLOW 12
#define SNMP_BERAPI_SHORT_BUFFER 13
#define SNMP_BERAPI_INVALID_OBJELEM 14
#define SNMP_PDUAPI_UNRECOGNIZED_PDU 20
#define SNMP_PDUAPI_INVALID_ES 21
#define SNMP_PDUAPI_INVALID_GT 22
#define SNMP_AUTHAPI_INVALID_VERSION 30
#define SNMP_AUTHAPI_INVALID_MSG_TYPE 31
#define SNMP_AUTHAPI_TRIV_AUTH_FAILED 32

type SNMPAPI as INT_
type AsnInteger32 as LONG
type AsnUnsigned32 as ULONG
type AsnCounter64 as ULARGE_INTEGER
type AsnCounter32 as AsnUnsigned32
type AsnGauge32 as AsnUnsigned32
type AsnTimeticks as AsnUnsigned32

type AsnOctetString
	stream as UBYTE ptr
	length as UINT
	dynamic as BOOL
end type

type AsnBits as AsnOctetString
type AsnSequence as AsnOctetString
type AsnImplicitSequence as AsnOctetString
type AsnIPAddress as AsnOctetString
type AsnNetworkAddress as AsnOctetString
type AsnDisplayString as AsnOctetString
type AsnOpaque as AsnOctetString

type AsnObjectIdentifier
	idLength as UINT
	ids as UINT ptr
end type

type AsnObjectName as AsnObjectIdentifier

union AsnAny_asnValue
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

type AsnAny
	asnType as UBYTE
	asnValue as AsnAny_asnValue
end type

type AsnObjectSyntax as AsnAny

type SnmpVarBind
	name as AsnObjectName
	value as AsnObjectSyntax
end type

type SnmpVarBindList
	list as SnmpVarBind ptr
	len as UINT
end type

declare sub SnmpExtensionClose alias "SnmpExtensionClose" ()
declare function SnmpExtensionInit alias "SnmpExtensionInit" (byval as DWORD, byval as HANDLE ptr, byval as AsnObjectIdentifier ptr) as BOOL
declare function SnmpExtensionInitEx alias "SnmpExtensionInitEx" (byval as AsnObjectIdentifier ptr) as BOOL
declare function SnmpExtensionMonitor alias "SnmpExtensionMonitor" (byval as LPVOID) as BOOL
declare function SnmpExtensionQuery alias "SnmpExtensionQuery" (byval as UBYTE, byval as SnmpVarBindList ptr, byval as AsnInteger32 ptr, byval as AsnInteger32 ptr) as BOOL
declare function SnmpExtensionQueryEx alias "SnmpExtensionQueryEx" (byval as DWORD, byval as DWORD, byval as SnmpVarBindList ptr, byval as AsnOctetString ptr, byval as AsnInteger32 ptr, byval as AsnInteger32 ptr) as BOOL
declare function SnmpExtensionTrap alias "SnmpExtensionTrap" (byval as AsnObjectIdentifier ptr, byval as AsnInteger32 ptr, byval as AsnInteger32 ptr, byval as AsnTimeticks ptr, byval as SnmpVarBindList ptr) as BOOL
declare function SnmpSvcGetUptime alias "SnmpSvcGetUptime" () as DWORD
declare sub SnmpSvcSetLogLevel alias "SnmpSvcSetLogLevel" (byval as INT_)
declare sub SnmpSvcSetLogType alias "SnmpSvcSetLogType" (byval as INT_)
declare function SnmpUtilAsnAnyCpy alias "SnmpUtilAsnAnyCpy" (byval as AsnAny ptr, byval as AsnAny ptr) as SNMPAPI
declare sub SnmpUtilAsnAnyFree alias "SnmpUtilAsnAnyFree" (byval as AsnAny ptr)
declare sub SnmpUtilDbgPrint cdecl alias "SnmpUtilDbgPrint" (byval as INT_, byval as LPSTR, ...)
declare function SnmpUtilIdsToA alias "SnmpUtilIdsToA" (byval as UINT ptr, byval as UINT) as LPSTR
declare function SnmpUtilMemAlloc alias "SnmpUtilMemAlloc" (byval as UINT) as LPVOID
declare sub SnmpUtilMemFree alias "SnmpUtilMemFree" (byval as LPVOID)
declare function SnmpUtilMemReAlloc alias "SnmpUtilMemReAlloc" (byval as LPVOID, byval as UINT) as LPVOID
declare function SnmpUtilOctetsCmp alias "SnmpUtilOctetsCmp" (byval as AsnOctetString ptr, byval as AsnOctetString ptr) as SNMPAPI
declare function SnmpUtilOctetsCpy alias "SnmpUtilOctetsCpy" (byval as AsnOctetString ptr, byval as AsnOctetString ptr) as SNMPAPI
declare sub SnmpUtilOctetsFree alias "SnmpUtilOctetsFree" (byval as AsnOctetString ptr)
declare function SnmpUtilOctetsNCmp alias "SnmpUtilOctetsNCmp" (byval as AsnOctetString ptr, byval as AsnOctetString ptr, byval as UINT) as SNMPAPI
declare function SnmpUtilOidAppend alias "SnmpUtilOidAppend" (byval as AsnObjectIdentifier ptr, byval as AsnObjectIdentifier ptr) as SNMPAPI
declare function SnmpUtilOidCmp alias "SnmpUtilOidCmp" (byval as AsnObjectIdentifier ptr, byval as AsnObjectIdentifier ptr) as SNMPAPI
declare function SnmpUtilOidCpy alias "SnmpUtilOidCpy" (byval as AsnObjectIdentifier ptr, byval as AsnObjectIdentifier ptr) as SNMPAPI
declare sub SnmpUtilOidFree alias "SnmpUtilOidFree" (byval as AsnObjectIdentifier ptr)
declare function SnmpUtilOidNCmp alias "SnmpUtilOidNCmp" (byval as AsnObjectIdentifier ptr, byval as AsnObjectIdentifier ptr, byval as UINT) as SNMPAPI
declare function SnmpUtilOidToA alias "SnmpUtilOidToA" (byval as AsnObjectIdentifier ptr) as LPSTR
declare sub SnmpUtilPrintAsnAny alias "SnmpUtilPrintAsnAny" (byval as AsnAny ptr)
declare sub SnmpUtilPrintOid alias "SnmpUtilPrintOid" (byval as AsnObjectIdentifier ptr)
declare function SnmpUtilVarBindCpy alias "SnmpUtilVarBindCpy" (byval as SnmpVarBind ptr, byval as SnmpVarBind ptr) as SNMPAPI
declare function SnmpUtilVarBindListCpy alias "SnmpUtilVarBindListCpy" (byval as SnmpVarBindList ptr, byval as SnmpVarBindList ptr) as SNMPAPI
declare sub SnmpUtilVarBindFree alias "SnmpUtilVarBindFree" (byval as SnmpVarBind ptr)
declare sub SnmpUtilVarBindListFree alias "SnmpUtilVarBindListFree" (byval as SnmpVarBindList ptr)

#define ASN_RFC1155_IPADDRESS (&h40 or &h00 or &h00)
#define ASN_RFC1155_COUNTER (&h40 or &h00 or &h01)
#define ASN_RFC1155_GAUGE (&h40 or &h00 or &h02)
#define ASN_RFC1155_TIMETICKS (&h40 or &h00 or &h03)
#define ASN_RFC1155_OPAQUE (&h40 or &h00 or &h04)
#define ASN_RFC1213_DISPSTRING (&h00 or &h00 or 4)
#define ASN_RFC1157_GETREQUEST (&h80 or &h20 or 0)
#define ASN_RFC1157_GETNEXTREQUEST (&h80 or &h20 or 1)
#define ASN_RFC1157_GETRESPONSE (&h80 or &h20 or 2)
#define ASN_RFC1157_SETREQUEST (&h80 or &h20 or 3)
#define ASN_RFC1157_TRAP (&h80 or &h20 or 4)
#define ASN_CONTEXTSPECIFIC &h80
#define ASN_PRIMATIVE &h00

#endif
