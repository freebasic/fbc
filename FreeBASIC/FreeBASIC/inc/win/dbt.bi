''
''
'' dbt -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_dbt_bi__
#define __win_dbt_bi__

#define DBT_NO_DISK_SPACE &h47
#define DBT_CONFIGMGPRIVATE &h7FFF
#define DBT_DEVICEARRIVAL &h8000
#define DBT_DEVICEQUERYREMOVE &h8001
#define DBT_DEVICEQUERYREMOVEFAILED &h8002
#define DBT_DEVICEREMOVEPENDING &h8003
#define DBT_DEVICEREMOVECOMPLETE &h8004
#define DBT_DEVICETYPESPECIFIC &h8005
#define DBT_DEVTYP_OEM 0
#define DBT_DEVTYP_DEVNODE 1
#define DBT_DEVTYP_VOLUME 2
#define DBT_DEVTYP_PORT 3
#define DBT_DEVTYP_NET 4
#define DBT_DEVTYP_DEVICEINTERFACE 5
#define DBT_DEVTYP_HANDLE 6
#define DBT_APPYBEGIN 0
#define DBT_APPYEND 1
#define DBT_DEVNODES_CHANGED 7
#define DBT_QUERYCHANGECONFIG &h17
#define DBT_CONFIGCHANGED &h18
#define DBT_CONFIGCHANGECANCELED &h19
#define DBT_MONITORCHANGE &h1B
#define DBT_SHELLLOGGEDON 32
#define DBT_CONFIGMGAPI32 34
#define DBT_VXDINITCOMPLETE 35
#define DBT_VOLLOCKQUERYLOCK &h8041
#define DBT_VOLLOCKLOCKTAKEN &h8042
#define DBT_VOLLOCKLOCKFAILED &h8043
#define DBT_VOLLOCKQUERYUNLOCK &h8044
#define DBT_VOLLOCKLOCKRELEASED &h8045
#define DBT_VOLLOCKUNLOCKFAILED &h8046
#define DBT_USERDEFINED &hFFFF
#define DBTF_MEDIA 1
#define DBTF_NET 2
#define BSM_ALLCOMPONENTS 0
#define BSM_APPLICATIONS 8
#define BSM_ALLDESKTOPS 16
#define BSM_INSTALLABLEDRIVERS 4
#define BSM_NETDRIVER 2
#define BSM_VXDS 1
#define BSF_FLUSHDISK &h00000004
#define BSF_FORCEIFHUNG &h00000020
#define BSF_IGNORECURRENTTASK &h00000002
#define BSF_NOHANG &h00000008
#define BSF_NOTIMEOUTIFNOTHUNG &h00000040
#define BSF_POSTMESSAGE &h00000010
#define BSF_QUERY &h00000001
#define BSF_ALLOWSFW &h00000080
#define BSF_SENDNOTIFYMESSAGE &h00000100
#define BSF_LUID &h00000400
#define BSF_RETURNHDESK &h00000200
#define BSF_MSGSRV32ISOK_BIT 31
#define BSF_MSGSRV32ISOK &h80000000

type DEV_BROADCAST_HDR
	dbch_size as DWORD
	dbch_devicetype as DWORD
	dbch_reserved as DWORD
end type

type PDEV_BROADCAST_HDR as DEV_BROADCAST_HDR ptr

type DEV_BROADCAST_OEM
	dbco_size as DWORD
	dbco_devicetype as DWORD
	dbco_reserved as DWORD
	dbco_identifier as DWORD
	dbco_suppfunc as DWORD
end type

type PDEV_BROADCAST_OEM as DEV_BROADCAST_OEM ptr

#ifndef UNICODE
type DEV_BROADCAST_PORT_A
	dbcp_size as DWORD
	dbcp_devicetype as DWORD
	dbcp_reserved as DWORD
	dbcp_name as zstring * 1
end type

type PDEV_BROADCAST_PORT_A as DEV_BROADCAST_PORT_A ptr

#else
type DEV_BROADCAST_PORT_W
	dbcp_size as DWORD
	dbcp_devicetype as DWORD
	dbcp_reserved as DWORD
	dbcp_name as wstring * 1
end type

type PDEV_BROADCAST_PORT_W as DEV_BROADCAST_PORT_W ptr
#endif

type DEV_BROADCAST_USERDEFINED
	dbud_dbh as DEV_BROADCAST_HDR
	dbud_szName as zstring * 1
end type

type DEV_BROADCAST_VOLUME
	dbcv_size as DWORD
	dbcv_devicetype as DWORD
	dbcv_reserved as DWORD
	dbcv_unitmask as DWORD
	dbcv_flags as WORD
end type

type PDEV_BROADCAST_VOLUME as DEV_BROADCAST_VOLUME ptr

#ifndef UNICODE
type DEV_BROADCAST_PORT as DEV_BROADCAST_PORT_A
type PDEV_BROADCAST_PORT as DEV_BROADCAST_PORT_A ptr

type DEV_BROADCAST_DEVICEINTERFACE_A
	dbcc_size as DWORD
	dbcc_devicetype as DWORD
	dbcc_reserved as DWORD
	dbcc_classguid as GUID
	dbcc_name as zstring * 1
end type

type PDEV_BROADCAST_DEVICEINTERFACE_A as DEV_BROADCAST_DEVICEINTERFACE_A ptr
type DEV_BROADCAST_DEVICEINTERFACE as DEV_BROADCAST_DEVICEINTERFACE_A
type PDEV_BROADCAST_DEVICEINTERFACE as PDEV_BROADCAST_DEVICEINTERFACE_A

#else
type DEV_BROADCAST_PORT as DEV_BROADCAST_PORT_W
type PDEV_BROADCAST_PORT as DEV_BROADCAST_PORT_W ptr

type DEV_BROADCAST_DEVICEINTERFACE_W
	dbcc_size as DWORD
	dbcc_devicetype as DWORD
	dbcc_reserved as DWORD
	dbcc_classguid as GUID
	dbcc_name as wstring * 1
end type

type PDEV_BROADCAST_DEVICEINTERFACE_W as DEV_BROADCAST_DEVICEINTERFACE_W ptr
type DEV_BROADCAST_DEVICEINTERFACE as DEV_BROADCAST_DEVICEINTERFACE_W
type PDEV_BROADCAST_DEVICEINTERFACE as PDEV_BROADCAST_DEVICEINTERFACE_W
#endif

type DEV_BROADCAST_HANDLE
	dbch_size as DWORD
	dbch_devicetype as DWORD
	dbch_reserved as DWORD
	dbch_handle as HANDLE
	dbch_hdevnotify as DWORD
	dbch_eventguid as GUID
	dbch_nameoffset as LONG
	dbch_data(0 to 1-1) as UBYTE
end type

type PDEV_BROADCAST_HANDLE as DEV_BROADCAST_HANDLE ptr

#endif
