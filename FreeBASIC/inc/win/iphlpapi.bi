''
''
'' iphlpapi -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_iphlpapi_bi__
#define __win_iphlpapi_bi__

#include once "win/iprtrmib.bi"
#include once "win/ipexport.bi"
#include once "win/iptypes.bi"

#inclib "iphlpapi"

declare function AddIPAddress alias "AddIPAddress" (byval as IPAddr, byval as IPMask, byval as DWORD, byval as PULONG, byval as PULONG) as DWORD
declare function CreateIpForwardEntry alias "CreateIpForwardEntry" (byval as PMIB_IPFORWARDROW) as DWORD
declare function CreateIpNetEntry alias "CreateIpNetEntry" (byval as PMIB_IPNETROW) as DWORD
declare function CreateProxyArpEntry alias "CreateProxyArpEntry" (byval as DWORD, byval as DWORD, byval as DWORD) as DWORD
declare function DeleteIPAddress alias "DeleteIPAddress" (byval as ULONG) as DWORD
declare function DeleteIpForwardEntry alias "DeleteIpForwardEntry" (byval as PMIB_IPFORWARDROW) as DWORD
declare function DeleteIpNetEntry alias "DeleteIpNetEntry" (byval as PMIB_IPNETROW) as DWORD
declare function DeleteProxyArpEntry alias "DeleteProxyArpEntry" (byval as DWORD, byval as DWORD, byval as DWORD) as DWORD
declare function EnableRouter alias "EnableRouter" (byval as HANDLE ptr, byval as OVERLAPPED ptr) as DWORD
declare function FlushIpNetTable alias "FlushIpNetTable" (byval as DWORD) as DWORD
declare function GetAdapterIndex alias "GetAdapterIndex" (byval as LPWSTR, byval as PULONG) as DWORD
declare function GetAdaptersInfo alias "GetAdaptersInfo" (byval as PIP_ADAPTER_INFO, byval as PULONG) as DWORD
declare function GetBestInterface alias "GetBestInterface" (byval as IPAddr, byval as PDWORD) as DWORD
declare function GetBestRoute alias "GetBestRoute" (byval as DWORD, byval as DWORD, byval as PMIB_IPFORWARDROW) as DWORD
declare function GetFriendlyIfIndex alias "GetFriendlyIfIndex" (byval as DWORD) as DWORD
declare function GetIcmpStatistics alias "GetIcmpStatistics" (byval as PMIB_ICMP) as DWORD
declare function GetIfEntry alias "GetIfEntry" (byval as PMIB_IFROW) as DWORD
declare function GetIfTable alias "GetIfTable" (byval as PMIB_IFTABLE, byval as PULONG, byval as BOOL) as DWORD
declare function GetInterfaceInfo alias "GetInterfaceInfo" (byval as PIP_INTERFACE_INFO, byval as PULONG) as DWORD
declare function GetIpAddrTable alias "GetIpAddrTable" (byval as PMIB_IPADDRTABLE, byval as PULONG, byval as BOOL) as DWORD
declare function GetIpForwardTable alias "GetIpForwardTable" (byval as PMIB_IPFORWARDTABLE, byval as PULONG, byval as BOOL) as DWORD
declare function GetIpNetTable alias "GetIpNetTable" (byval as PMIB_IPNETTABLE, byval as PULONG, byval as BOOL) as DWORD
declare function GetIpStatistics alias "GetIpStatistics" (byval as PMIB_IPSTATS) as DWORD
declare function GetNetworkParams alias "GetNetworkParams" (byval as PFIXED_INFO, byval as PULONG) as DWORD
declare function GetNumberOfInterfaces alias "GetNumberOfInterfaces" (byval as PDWORD) as DWORD
declare function GetPerAdapterInfo alias "GetPerAdapterInfo" (byval as ULONG, byval as PIP_PER_ADAPTER_INFO, byval as PULONG) as DWORD
declare function GetRTTAndHopCount alias "GetRTTAndHopCount" (byval as IPAddr, byval as PULONG, byval as ULONG, byval as PULONG) as BOOL
declare function GetTcpStatistics alias "GetTcpStatistics" (byval as PMIB_TCPSTATS) as DWORD
declare function GetTcpTable alias "GetTcpTable" (byval as PMIB_TCPTABLE, byval as PDWORD, byval as BOOL) as DWORD
declare function GetUniDirectionalAdapterInfo alias "GetUniDirectionalAdapterInfo" (byval as PIP_UNIDIRECTIONAL_ADAPTER_ADDRESS, byval as PULONG) as DWORD
declare function GetUdpStatistics alias "GetUdpStatistics" (byval as PMIB_UDPSTATS) as DWORD
declare function GetUdpTable alias "GetUdpTable" (byval as PMIB_UDPTABLE, byval as PDWORD, byval as BOOL) as DWORD
declare function IpReleaseAddress alias "IpReleaseAddress" (byval as PIP_ADAPTER_INDEX_MAP) as DWORD
declare function IpRenewAddress alias "IpRenewAddress" (byval as PIP_ADAPTER_INDEX_MAP) as DWORD
declare function NotifyAddrChange alias "NotifyAddrChange" (byval as PHANDLE, byval as LPOVERLAPPED) as DWORD
declare function NotifyRouteChange alias "NotifyRouteChange" (byval as PHANDLE, byval as LPOVERLAPPED) as DWORD
declare function SendARP alias "SendARP" (byval as IPAddr, byval as IPAddr, byval as PULONG, byval as PULONG) as DWORD
declare function SetIfEntry alias "SetIfEntry" (byval as PMIB_IFROW) as DWORD
declare function SetIpForwardEntry alias "SetIpForwardEntry" (byval as PMIB_IPFORWARDROW) as DWORD
declare function SetIpNetEntry alias "SetIpNetEntry" (byval as PMIB_IPNETROW) as DWORD
declare function SetIpStatistics alias "SetIpStatistics" (byval as PMIB_IPSTATS) as DWORD
declare function SetIpTTL alias "SetIpTTL" (byval as UINT) as DWORD
declare function SetTcpEntry alias "SetTcpEntry" (byval as PMIB_TCPROW) as DWORD
declare function UnenableRouter alias "UnenableRouter" (byval as OVERLAPPED ptr, byval as LPDWORD) as DWORD

#endif
