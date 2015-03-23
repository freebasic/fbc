#pragma once

#inclib "iphlpapi"

#include once "iprtrmib.bi"
#include once "ipexport.bi"
#include once "iptypes.bi"
#include once "netioapi.bi"
#include once "tcpmib.bi"
#include once "udpmib.bi"
#include once "tcpestats.bi"

#if _WIN32_WINNT = &h0602
	#include once "windns.bi"
#endif

extern "Windows"

#define __IPHLPAPI_H__
declare function GetNumberOfInterfaces(byval pdwNumIf as PDWORD) as DWORD
declare function GetIfEntry(byval pIfRow as PMIB_IFROW) as DWORD
declare function GetIfTable(byval pIfTable as PMIB_IFTABLE, byval pdwSize as PULONG, byval bOrder as WINBOOL) as DWORD
declare function GetIpAddrTable(byval pIpAddrTable as PMIB_IPADDRTABLE, byval pdwSize as PULONG, byval bOrder as WINBOOL) as DWORD
declare function GetIpNetTable(byval pIpNetTable as PMIB_IPNETTABLE, byval pdwSize as PULONG, byval bOrder as WINBOOL) as DWORD
declare function GetIpForwardTable(byval pIpForwardTable as PMIB_IPFORWARDTABLE, byval pdwSize as PULONG, byval bOrder as WINBOOL) as DWORD
declare function GetTcpTable(byval pTcpTable as PMIB_TCPTABLE, byval pdwSize as PDWORD, byval bOrder as WINBOOL) as DWORD
declare function GetUdpTable(byval pUdpTable as PMIB_UDPTABLE, byval pdwSize as PDWORD, byval bOrder as WINBOOL) as DWORD
declare function GetIpStatistics(byval pStats as PMIB_IPSTATS) as DWORD
declare function GetIpStatisticsEx(byval pStats as PMIB_IPSTATS, byval dwFamily as DWORD) as DWORD
declare function GetIcmpStatistics(byval pStats as PMIB_ICMP) as DWORD
declare function GetIcmpStatisticsEx(byval pStats as PMIB_ICMP_EX, byval dwFamily as DWORD) as DWORD
declare function GetTcpStatistics(byval pStats as PMIB_TCPSTATS) as DWORD
declare function GetTcpStatisticsEx(byval pStats as PMIB_TCPSTATS, byval dwFamily as DWORD) as DWORD
declare function GetUdpStatistics(byval pStats as PMIB_UDPSTATS) as DWORD
declare function GetUdpStatisticsEx(byval pStats as PMIB_UDPSTATS, byval dwFamily as DWORD) as DWORD
declare function SetIfEntry(byval pIfRow as PMIB_IFROW) as DWORD
declare function CreateIpForwardEntry(byval pRoute as PMIB_IPFORWARDROW) as DWORD
declare function SetIpForwardEntry(byval pRoute as PMIB_IPFORWARDROW) as DWORD
declare function DeleteIpForwardEntry(byval pRoute as PMIB_IPFORWARDROW) as DWORD
declare function SetIpStatistics(byval pIpStats as PMIB_IPSTATS) as DWORD
declare function SetIpTTL(byval nTTL as UINT) as DWORD
declare function CreateIpNetEntry(byval pArpEntry as PMIB_IPNETROW) as DWORD
declare function SetIpNetEntry(byval pArpEntry as PMIB_IPNETROW) as DWORD
declare function DeleteIpNetEntry(byval pArpEntry as PMIB_IPNETROW) as DWORD
declare function FlushIpNetTable(byval dwIfIndex as DWORD) as DWORD
declare function CreateProxyArpEntry(byval dwAddress as DWORD, byval dwMask as DWORD, byval dwIfIndex as DWORD) as DWORD
declare function DeleteProxyArpEntry(byval dwAddress as DWORD, byval dwMask as DWORD, byval dwIfIndex as DWORD) as DWORD
declare function SetTcpEntry(byval pTcpRow as PMIB_TCPROW) as DWORD
declare function GetInterfaceInfo(byval pIfTable as PIP_INTERFACE_INFO, byval dwOutBufLen as PULONG) as DWORD
declare function GetUniDirectionalAdapterInfo(byval pIPIfInfo as PIP_UNIDIRECTIONAL_ADAPTER_ADDRESS, byval dwOutBufLen as PULONG) as DWORD
#define NhpAllocateAndGetInterfaceInfoFromStack_DEFINED
declare function NhpAllocateAndGetInterfaceInfoFromStack(byval ppTable as IP_INTERFACE_NAME_INFO ptr ptr, byval pdwCount as PDWORD, byval bOrder as WINBOOL, byval hHeap as HANDLE, byval dwFlags as DWORD) as DWORD
declare function GetBestInterface(byval dwDestAddr as IPAddr, byval pdwBestIfIndex as PDWORD) as DWORD
declare function GetBestInterfaceEx(byval pDestAddr as SOCKADDR ptr, byval pdwBestIfIndex as PDWORD) as DWORD
declare function GetBestRoute(byval dwDestAddr as DWORD, byval dwSourceAddr as DWORD, byval pBestRoute as PMIB_IPFORWARDROW) as DWORD
declare function GetExtendedTcpTable(byval pTcpTable as PVOID, byval pdwSize as PDWORD, byval bOrder as BOOL, byval ulAf as ULONG, byval TableClass as TCP_TABLE_CLASS, byval Reserved as ULONG) as DWORD
declare function NotifyAddrChange(byval Handle as PHANDLE, byval overlapped as LPOVERLAPPED) as DWORD
declare function NotifyRouteChange(byval Handle as PHANDLE, byval overlapped as LPOVERLAPPED) as DWORD
declare function CancelIPChangeNotify(byval notifyOverlapped as LPOVERLAPPED) as WINBOOL
declare function GetAdapterIndex(byval AdapterName as LPWSTR, byval IfIndex as PULONG) as DWORD
declare function AddIPAddress(byval Address as IPAddr, byval IpMask as IPMask, byval IfIndex as DWORD, byval NTEContext as PULONG, byval NTEInstance as PULONG) as DWORD
declare function DeleteIPAddress(byval NTEContext as ULONG) as DWORD
declare function GetNetworkParams(byval pFixedInfo as PFIXED_INFO, byval pOutBufLen as PULONG) as DWORD
declare function GetAdaptersInfo(byval pAdapterInfo as PIP_ADAPTER_INFO, byval pOutBufLen as PULONG) as DWORD
declare function GetAdapterOrderMap() as PIP_ADAPTER_ORDER_MAP
declare function GetAdaptersAddresses(byval Family as ULONG, byval Flags as DWORD, byval Reserved as PVOID, byval pAdapterAddresses as PIP_ADAPTER_ADDRESSES, byval pOutBufLen as PULONG) as DWORD
declare function GetPerAdapterInfo(byval IfIndex as ULONG, byval pPerAdapterInfo as PIP_PER_ADAPTER_INFO, byval pOutBufLen as PULONG) as DWORD
declare function IpReleaseAddress(byval AdapterInfo as PIP_ADAPTER_INDEX_MAP) as DWORD
declare function IpRenewAddress(byval AdapterInfo as PIP_ADAPTER_INDEX_MAP) as DWORD
declare function SendARP(byval DestIP as IPAddr, byval SrcIP as IPAddr, byval pMacAddr as PULONG, byval PhyAddrLen as PULONG) as DWORD
declare function GetRTTAndHopCount(byval DestIpAddress as IPAddr, byval HopCount as PULONG, byval MaxHops as ULONG, byval RTT as PULONG) as WINBOOL
declare function GetFriendlyIfIndex(byval IfIndex as DWORD) as DWORD
declare function EnableRouter(byval pHandle as HANDLE ptr, byval pOverlapped as OVERLAPPED ptr) as DWORD
declare function UnenableRouter(byval pOverlapped as OVERLAPPED ptr, byval lpdwEnableCount as LPDWORD) as DWORD
declare function DisableMediaSense(byval pHandle as HANDLE ptr, byval pOverLapped as OVERLAPPED ptr) as DWORD
declare function RestoreMediaSense(byval pOverlapped as OVERLAPPED ptr, byval lpdwEnableCount as LPDWORD) as DWORD
declare function GetIpErrorString(byval ErrorCode as IP_STATUS, byval Buffer as PWCHAR, byval Size as PDWORD) as DWORD
declare function GetExtendedUdpTable(byval pUdpTable as PVOID, byval pdwSize as PDWORD, byval bOrder as WINBOOL, byval ulAf as ULONG, byval TableClass as UDP_TABLE_CLASS, byval Reserved as ULONG) as DWORD
declare function GetOwnerModuleFromTcp6Entry(byval pTcpEntry as PMIB_TCP6ROW_OWNER_MODULE, byval Class as TCPIP_OWNER_MODULE_INFO_CLASS, byval Buffer as PVOID, byval pdwSize as PDWORD) as DWORD
declare function GetOwnerModuleFromTcpEntry(byval pTcpEntry as PMIB_TCPROW_OWNER_MODULE, byval Class as TCPIP_OWNER_MODULE_INFO_CLASS, byval Buffer as PVOID, byval pdwSize as PDWORD) as DWORD
declare function GetOwnerModuleFromUdp6Entry(byval pUdpEntry as PMIB_UDP6ROW_OWNER_MODULE, byval Class as TCPIP_OWNER_MODULE_INFO_CLASS, byval Buffer as PVOID, byval pdwSize as PDWORD) as DWORD
declare function GetOwnerModuleFromUdpEntry(byval pUdpEntry as PMIB_UDPROW_OWNER_MODULE, byval Class as TCPIP_OWNER_MODULE_INFO_CLASS, byval Buffer as PVOID, byval pdwSize as PDWORD) as DWORD

#if _WIN32_WINNT = &h0502
	declare function CancelSecurityHealthChangeNotify(byval notifyOverlapped as LPOVERLAPPED) as WINBOOL
#elseif _WIN32_WINNT = &h0602
	type _NET_ADDRESS_FORMAT as long
	enum
		NET_ADDRESS_FORMAT_UNSPECIFIED = 0
		NET_ADDRESS_DNS_NAME
		NET_ADDRESS_IPV4
		NET_ADDRESS_IPV6
	end enum

	type NET_ADDRESS_FORMAT as _NET_ADDRESS_FORMAT

	type _NET_ADDRESS_INFO_NamedAddress
		Address as wstring * 256
		Port as wstring * 6
	end type

	type _NET_ADDRESS_INFO
		Format as NET_ADDRESS_FORMAT

		union
			NamedAddress as _NET_ADDRESS_INFO_NamedAddress
			Ipv4Address as SOCKADDR_IN
			Ipv6Address as SOCKADDR_IN6
			IpAddress as SOCKADDR
		end union
	end type

	type NET_ADDRESS_INFO as _NET_ADDRESS_INFO
	type PNET_ADDRESS_INFO as _NET_ADDRESS_INFO ptr
	declare function GetPerTcp6ConnectionEStats(byval Row as PMIB_TCP6ROW, byval EstatsType as TCP_ESTATS_TYPE, byval Rw as PUCHAR, byval RwVersion as ULONG, byval RwSize as ULONG, byval Ros as PUCHAR, byval RosVersion as ULONG, byval RosSize as ULONG, byval Rod as PUCHAR, byval RodVersion as ULONG, byval RodSize as ULONG) as ULONG
	declare function SetPerTcp6ConnectionEStats(byval Row as PMIB_TCP6ROW, byval EstatsType as TCP_ESTATS_TYPE, byval Rw as PUCHAR, byval RwVersion as ULONG, byval RwSize as ULONG, byval Offset as ULONG) as ULONG
	declare function SetPerTcpConnectionEStats(byval Row as PMIB_TCPROW, byval EstatsType as TCP_ESTATS_TYPE, byval Rw as PUCHAR, byval RwVersion as ULONG, byval RwSize as ULONG, byval Offset as ULONG) as ULONG
	declare function GetTcp6Table(byval TcpTable as PMIB_TCP6TABLE, byval SizePointer as PULONG, byval Order as WINBOOL) as ULONG
	declare function GetPerTcpConnectionEStats(byval Row as PMIB_TCPROW, byval EstatsType as TCP_ESTATS_TYPE, byval Rw as PUCHAR, byval RwVersion as ULONG, byval RwSize as ULONG, byval Ros as PUCHAR, byval RosVersion as ULONG, byval RosSize as ULONG, byval Rod as PUCHAR, byval RodVersion as ULONG, byval RodSize as ULONG) as ULONG
	declare function GetTcp6Table2(byval TcpTable as PMIB_TCP6TABLE2, byval SizePointer as PULONG, byval Order as WINBOOL) as ULONG
	declare function GetTcpTable2(byval TcpTable as PMIB_TCPTABLE2, byval SizePointer as PULONG, byval Order as WINBOOL) as ULONG
	declare function GetUdp6Table(byval Udp6Table as PMIB_UDP6TABLE, byval SizePointer as PULONG, byval Order as WINBOOL) as ULONG
	declare function NotifySecurityHealthChange(byval pHandle as PHANDLE, byval pOverLapped as LPOVERLAPPED, byval SecurityHealthFlags as PULONG) as DWORD
	declare function ResolveNeighbor(byval NetworkAddress as SOCKADDR ptr, byval PhysicalAddress as PVOID, byval PhysicalAddressLength as PULONG) as ULONG
	declare function SetIpStatisticsEx(byval pIpStats as PMIB_IPSTATS, byval Family as ULONG) as DWORD
#endif

end extern
