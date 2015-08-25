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

#include once "snmp.bi"
#include once "winsock.bi"

extern "Windows"

#define _INC_MGMTAPI
const SNMP_MGMTAPI_TIMEOUT = 40
const SNMP_MGMTAPI_SELECT_FDERRORS = 41
const SNMP_MGMTAPI_TRAP_ERRORS = 42
const SNMP_MGMTAPI_TRAP_DUPINIT = 43
const SNMP_MGMTAPI_NOTRAPS = 44
const SNMP_MGMTAPI_AGAIN = 45
const SNMP_MGMTAPI_INVALID_CTL = 46
const SNMP_MGMTAPI_INVALID_SESSION = 47
const SNMP_MGMTAPI_INVALID_BUFFER = 48
const MGMCTL_SETAGENTPORT = &h01
type LPSNMP_MGR_SESSION as PVOID

declare function SnmpMgrOpen(byval lpAgentAddress as LPSTR, byval lpAgentCommunity as LPSTR, byval nTimeOut as INT_, byval nRetries as INT_) as LPSNMP_MGR_SESSION
declare function SnmpMgrCtl(byval session as LPSNMP_MGR_SESSION, byval dwCtlCode as DWORD, byval lpvInBuffer as LPVOID, byval cbInBuffer as DWORD, byval lpvOUTBuffer as LPVOID, byval cbOUTBuffer as DWORD, byval lpcbBytesReturned as LPDWORD) as WINBOOL
declare function SnmpMgrClose(byval session as LPSNMP_MGR_SESSION) as WINBOOL
declare function SnmpMgrRequest(byval session as LPSNMP_MGR_SESSION, byval requestType as UBYTE, byval variableBindings as SnmpVarBindList ptr, byval errorStatus as AsnInteger32 ptr, byval errorIndex as AsnInteger32 ptr) as INT_
declare function SnmpMgrStrToOid(byval string as LPSTR, byval oid as AsnObjectIdentifier ptr) as WINBOOL
declare function SnmpMgrOidToStr(byval oid as AsnObjectIdentifier ptr, byval string as LPSTR ptr) as WINBOOL
declare function SnmpMgrTrapListen(byval phTrapAvailable as HANDLE ptr) as WINBOOL
declare function SnmpMgrGetTrap(byval enterprise as AsnObjectIdentifier ptr, byval IPAddress as AsnNetworkAddress ptr, byval genericTrap as AsnInteger32 ptr, byval specificTrap as AsnInteger32 ptr, byval timeStamp as AsnTimeticks ptr, byval variableBindings as SnmpVarBindList ptr) as WINBOOL
declare function SnmpMgrGetTrapEx(byval enterprise as AsnObjectIdentifier ptr, byval agentAddress as AsnNetworkAddress ptr, byval sourceAddress as AsnNetworkAddress ptr, byval genericTrap as AsnInteger32 ptr, byval specificTrap as AsnInteger32 ptr, byval community as AsnOctetString ptr, byval timeStamp as AsnTimeticks ptr, byval variableBindings as SnmpVarBindList ptr) as WINBOOL

end extern
