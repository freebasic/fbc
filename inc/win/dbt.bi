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

#include once "_mingw_unicode.bi"
#include once "guiddef.bi"

#define _DBT_H
const WM_DEVICECHANGE = &h0219
#define DBTFAR far
const BSF_QUERY = &h00000001
const BSF_IGNORECURRENTTASK = &h00000002
const BSF_FLUSHDISK = &h00000004
const BSF_NOHANG = &h00000008
const BSF_POSTMESSAGE = &h00000010
const BSF_FORCEIFHUNG = &h00000020
const BSF_NOTIMEOUTIFNOTHUNG = &h00000040
const BSF_MSGSRV32ISOK = &h80000000
const BSF_MSGSRV32ISOK_BIT = 31
const BSM_ALLCOMPONENTS = &h00000000
const BSM_VXDS = &h00000001
const BSM_NETDRIVER = &h00000002
const BSM_INSTALLABLEDRIVERS = &h00000004
const BSM_APPLICATIONS = &h00000008
const DBT_APPYBEGIN = &h0000
const DBT_APPYEND = &h0001
const DBT_DEVNODES_CHANGED = &h0007
const DBT_QUERYCHANGECONFIG = &h0017
const DBT_CONFIGCHANGED = &h0018
const DBT_CONFIGCHANGECANCELED = &h0019
const DBT_MONITORCHANGE = &h001B
const DBT_SHELLLOGGEDON = &h0020
const DBT_CONFIGMGAPI32 = &h0022
const DBT_VXDINITCOMPLETE = &h0023
const DBT_VOLLOCKQUERYLOCK = &h8041
const DBT_VOLLOCKLOCKTAKEN = &h8042
const DBT_VOLLOCKLOCKFAILED = &h8043
const DBT_VOLLOCKQUERYUNLOCK = &h8044
const DBT_VOLLOCKLOCKRELEASED = &h8045
const DBT_VOLLOCKUNLOCKFAILED = &h8046

type _DEV_BROADCAST_HDR
	dbch_size as DWORD
	dbch_devicetype as DWORD
	dbch_reserved as DWORD
end type

type DEV_BROADCAST_HDR as _DEV_BROADCAST_HDR
type PDEV_BROADCAST_HDR as DEV_BROADCAST_HDR ptr
type pVolLockBroadcast as VolLockBroadcast ptr

type VolLockBroadcast
	vlb_dbh as _DEV_BROADCAST_HDR
	vlb_owner as DWORD
	vlb_perms as UBYTE
	vlb_lockType as UBYTE
	vlb_drive as UBYTE
	vlb_flags as UBYTE
end type

const LOCKP_ALLOW_WRITES = &h01
const LOCKP_FAIL_WRITES = &h00
const LOCKP_FAIL_MEM_MAPPING = &h02
const LOCKP_ALLOW_MEM_MAPPING = &h00
const LOCKP_USER_MASK = &h03
const LOCKP_LOCK_FOR_FORMAT = &h04
const LOCKF_LOGICAL_LOCK = &h00
const LOCKF_PHYSICAL_LOCK = &h01
const DBT_NO_DISK_SPACE = &h0047
const DBT_LOW_DISK_SPACE = &h0048
const DBT_CONFIGMGPRIVATE = &h7FFF
const DBT_DEVICEARRIVAL = &h8000
const DBT_DEVICEQUERYREMOVE = &h8001
const DBT_DEVICEQUERYREMOVEFAILED = &h8002
const DBT_DEVICEREMOVEPENDING = &h8003
const DBT_DEVICEREMOVECOMPLETE = &h8004
const DBT_DEVICETYPESPECIFIC = &h8005
const DBT_CUSTOMEVENT = &h8006
const DBT_DEVTYP_OEM = &h00000000
const DBT_DEVTYP_DEVNODE = &h00000001
const DBT_DEVTYP_VOLUME = &h00000002
const DBT_DEVTYP_PORT = &h00000003
const DBT_DEVTYP_NET = &h00000004
const DBT_DEVTYP_DEVICEINTERFACE = &h00000005
const DBT_DEVTYP_HANDLE = &h00000006

type _DEV_BROADCAST_HEADER
	dbcd_size as DWORD
	dbcd_devicetype as DWORD
	dbcd_reserved as DWORD
end type

type _DEV_BROADCAST_OEM
	dbco_size as DWORD
	dbco_devicetype as DWORD
	dbco_reserved as DWORD
	dbco_identifier as DWORD
	dbco_suppfunc as DWORD
end type

type DEV_BROADCAST_OEM as _DEV_BROADCAST_OEM
type PDEV_BROADCAST_OEM as DEV_BROADCAST_OEM ptr

type _DEV_BROADCAST_DEVNODE
	dbcd_size as DWORD
	dbcd_devicetype as DWORD
	dbcd_reserved as DWORD
	dbcd_devnode as DWORD
end type

type DEV_BROADCAST_DEVNODE as _DEV_BROADCAST_DEVNODE
type PDEV_BROADCAST_DEVNODE as DEV_BROADCAST_DEVNODE ptr

type _DEV_BROADCAST_VOLUME
	dbcv_size as DWORD
	dbcv_devicetype as DWORD
	dbcv_reserved as DWORD
	dbcv_unitmask as DWORD
	dbcv_flags as WORD
end type

type DEV_BROADCAST_VOLUME as _DEV_BROADCAST_VOLUME
type PDEV_BROADCAST_VOLUME as DEV_BROADCAST_VOLUME ptr
const DBTF_MEDIA = &h0001
const DBTF_NET = &h0002

type _DEV_BROADCAST_PORT_A
	dbcp_size as DWORD
	dbcp_devicetype as DWORD
	dbcp_reserved as DWORD
	dbcp_name as zstring * 1
end type

type DEV_BROADCAST_PORT_A as _DEV_BROADCAST_PORT_A
type PDEV_BROADCAST_PORT_A as _DEV_BROADCAST_PORT_A ptr

type _DEV_BROADCAST_PORT_W
	dbcp_size as DWORD
	dbcp_devicetype as DWORD
	dbcp_reserved as DWORD
	dbcp_name as wstring * 1
end type

type DEV_BROADCAST_PORT_W as _DEV_BROADCAST_PORT_W
type PDEV_BROADCAST_PORT_W as _DEV_BROADCAST_PORT_W ptr

#ifdef UNICODE
	type DEV_BROADCAST_PORT as DEV_BROADCAST_PORT_W
	type PDEV_BROADCAST_PORT as PDEV_BROADCAST_PORT_W
#else
	type DEV_BROADCAST_PORT as DEV_BROADCAST_PORT_A
	type PDEV_BROADCAST_PORT as PDEV_BROADCAST_PORT_A
#endif

type _DEV_BROADCAST_NET
	dbcn_size as DWORD
	dbcn_devicetype as DWORD
	dbcn_reserved as DWORD
	dbcn_resource as DWORD
	dbcn_flags as DWORD
end type

type DEV_BROADCAST_NET as _DEV_BROADCAST_NET
type PDEV_BROADCAST_NET as DEV_BROADCAST_NET ptr

type _DEV_BROADCAST_DEVICEINTERFACE_A
	dbcc_size as DWORD
	dbcc_devicetype as DWORD
	dbcc_reserved as DWORD
	dbcc_classguid as GUID
	dbcc_name as zstring * 1
end type

type DEV_BROADCAST_DEVICEINTERFACE_A as _DEV_BROADCAST_DEVICEINTERFACE_A
type PDEV_BROADCAST_DEVICEINTERFACE_A as _DEV_BROADCAST_DEVICEINTERFACE_A ptr

type _DEV_BROADCAST_DEVICEINTERFACE_W
	dbcc_size as DWORD
	dbcc_devicetype as DWORD
	dbcc_reserved as DWORD
	dbcc_classguid as GUID
	dbcc_name as wstring * 1
end type

type DEV_BROADCAST_DEVICEINTERFACE_W as _DEV_BROADCAST_DEVICEINTERFACE_W
type PDEV_BROADCAST_DEVICEINTERFACE_W as _DEV_BROADCAST_DEVICEINTERFACE_W ptr

#ifdef UNICODE
	type DEV_BROADCAST_DEVICEINTERFACE as DEV_BROADCAST_DEVICEINTERFACE_W
	type PDEV_BROADCAST_DEVICEINTERFACE as PDEV_BROADCAST_DEVICEINTERFACE_W
#else
	type DEV_BROADCAST_DEVICEINTERFACE as DEV_BROADCAST_DEVICEINTERFACE_A
	type PDEV_BROADCAST_DEVICEINTERFACE as PDEV_BROADCAST_DEVICEINTERFACE_A
#endif

type _DEV_BROADCAST_HANDLE
	dbch_size as DWORD
	dbch_devicetype as DWORD
	dbch_reserved as DWORD
	dbch_handle as HANDLE
	dbch_hdevnotify as HDEVNOTIFY
	dbch_eventguid as GUID
	dbch_nameoffset as LONG
	dbch_data(0 to 0) as UBYTE
end type

type DEV_BROADCAST_HANDLE as _DEV_BROADCAST_HANDLE
type PDEV_BROADCAST_HANDLE as _DEV_BROADCAST_HANDLE ptr

type _DEV_BROADCAST_HANDLE32
	dbch_size as DWORD
	dbch_devicetype as DWORD
	dbch_reserved as DWORD
	dbch_handle as ULONG32
	dbch_hdevnotify as ULONG32
	dbch_eventguid as GUID
	dbch_nameoffset as LONG
	dbch_data(0 to 0) as UBYTE
end type

type DEV_BROADCAST_HANDLE32 as _DEV_BROADCAST_HANDLE32
type PDEV_BROADCAST_HANDLE32 as _DEV_BROADCAST_HANDLE32 ptr

type _DEV_BROADCAST_HANDLE64
	dbch_size as DWORD
	dbch_devicetype as DWORD
	dbch_reserved as DWORD
	dbch_handle as ULONG64
	dbch_hdevnotify as ULONG64
	dbch_eventguid as GUID
	dbch_nameoffset as LONG
	dbch_data(0 to 0) as UBYTE
end type

type DEV_BROADCAST_HANDLE64 as _DEV_BROADCAST_HANDLE64
type PDEV_BROADCAST_HANDLE64 as _DEV_BROADCAST_HANDLE64 ptr
const DBTF_RESOURCE = &h00000001
const DBTF_XPORT = &h00000002
const DBTF_SLOWNET = &h00000004
const DBT_VPOWERDAPI = &h8100
const DBT_USERDEFINED = &hFFFF

type _DEV_BROADCAST_USERDEFINED
	dbud_dbh as _DEV_BROADCAST_HDR
	dbud_szName as zstring * 1
end type
