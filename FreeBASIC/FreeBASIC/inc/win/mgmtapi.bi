''
''
'' mgmtapi -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_mgmtapi_bi__
#define __win_mgmtapi_bi__

#include once "win/snmp.bi"

#define SNMP_MGMTAPI_TIMEOUT 40
#define SNMP_MGMTAPI_SELECT_FDERRORS 41
#define SNMP_MGMTAPI_TRAP_ERRORS 42
#define SNMP_MGMTAPI_TRAP_DUPINIT 43
#define SNMP_MGMTAPI_NOTRAPS 44
#define SNMP_MGMTAPI_AGAIN 45
#define SNMP_MGMTAPI_INVALID_CTL 46
#define SNMP_MGMTAPI_INVALID_SESSION 47
#define SNMP_MGMTAPI_INVALID_BUFFER 48
#define MGMCTL_SETAGENTPORT 1

type LPSNMP_MGR_SESSION as PVOID

declare function SnmpMgrClose alias "SnmpMgrClose" (byval as LPSNMP_MGR_SESSION) as BOOL
declare function SnmpMgrCtl alias "SnmpMgrCtl" (byval as LPSNMP_MGR_SESSION, byval as DWORD, byval as LPVOID, byval as DWORD, byval as LPVOID, byval as DWORD, byval as LPDWORD) as BOOL
declare function SnmpMgrGetTrap alias "SnmpMgrGetTrap" (byval as AsnObjectIdentifier ptr, byval as AsnNetworkAddress ptr, byval as AsnInteger32 ptr, byval as AsnInteger32 ptr, byval as AsnTimeticks ptr, byval as SnmpVarBindList ptr) as BOOL
declare function SnmpMgrGetTrapEx alias "SnmpMgrGetTrapEx" (byval as AsnObjectIdentifier ptr, byval as AsnNetworkAddress ptr, byval as AsnNetworkAddress ptr, byval as AsnInteger32 ptr, byval as AsnInteger32 ptr, byval as AsnOctetString ptr, byval as AsnTimeticks ptr, byval as SnmpVarBindList ptr) as BOOL
declare function SnmpMgrOidToStr alias "SnmpMgrOidToStr" (byval as AsnObjectIdentifier ptr, byval as LPSTR ptr) as BOOL
declare function SnmpMgrOpen alias "SnmpMgrOpen" (byval as LPSTR, byval as LPSTR, byval as INT_, byval as INT_) as LPSNMP_MGR_SESSION
declare function SnmpMgrRequest alias "SnmpMgrRequest" (byval as LPSNMP_MGR_SESSION, byval as UBYTE, byval as SnmpVarBindList ptr, byval as AsnInteger32 ptr, byval as AsnInteger32 ptr) as INT_
declare function SnmpMgrStrToOid alias "SnmpMgrStrToOid" (byval as LPSTR, byval as AsnObjectIdentifier ptr) as BOOL
declare function SnmpMgrTrapListen alias "SnmpMgrTrapListen" (byval as HANDLE ptr) as BOOL

#endif
