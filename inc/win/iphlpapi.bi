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

#inclib "iphlpapi"

#include once "winapifamily.bi"
#include once "iprtrmib.bi"
#include once "ipexport.bi"
#include once "iptypes.bi"
#include once "tcpestats.bi"

#if _WIN32_WINNT >= &h0600
	#include once "netioapi.bi"
#endif

extern "Windows"

#define __IPHLPAPI_H__
declare function GetNumberOfInterfaces(byval pdwNumIf as PDWORD) as DWORD
declare function GetIfEntry(byval pIfRow as PMIB_IFROW) as DWORD
declare function GetIfTable(byval pIfTable as PMIB_IFTABLE, byval pdwSize as PULONG, byval bOrder as WINBOOL) as DWORD
declare function GetIpAddrTable(byval pIpAddrTable as PMIB_IPADDRTABLE, byval pdwSize as PULONG, byval bOrder as WINBOOL) as DWORD
declare function GetIpNetTable(byval IpNetTable as PMIB_IPNETTABLE, byval SizePointer as PULONG, byval Order as WINBOOL) as ULONG
declare function GetIpForwardTable(byval pIpForwardTable as PMIB_IPFORWARDTABLE, byval pdwSize as PULONG, byval bOrder as WINBOOL) as DWORD
declare function GetTcpTable(byval TcpTable as PMIB_TCPTABLE, byval SizePointer as PULONG, byval Order as WINBOOL) as ULONG
declare function GetExtendedTcpTable(byval pTcpTable as PVOID, byval pdwSize as PDWORD, byval bOrder as WINBOOL, byval ulAf as ULONG, byval TableClass as TCP_TABLE_CLASS, byval Reserved as ULONG) as DWORD
declare function GetOwnerModuleFromTcpEntry(byval pTcpEntry as PMIB_TCPROW_OWNER_MODULE, byval Class as TCPIP_OWNER_MODULE_INFO_CLASS, byval pBuffer as PVOID, byval pdwSize as PDWORD) as DWORD
declare function GetUdpTable(byval UdpTable as PMIB_UDPTABLE, byval SizePointer as PULONG, byval Order as WINBOOL) as ULONG
declare function GetExtendedUdpTable(byval pUdpTable as PVOID, byval pdwSize as PDWORD, byval bOrder as WINBOOL, byval ulAf as ULONG, byval TableClass as UDP_TABLE_CLASS, byval Reserved as ULONG) as DWORD
declare function GetOwnerModuleFromUdpEntry(byval pUdpEntry as PMIB_UDPROW_OWNER_MODULE, byval Class as TCPIP_OWNER_MODULE_INFO_CLASS, byval pBuffer as PVOID, byval pdwSize as PDWORD) as DWORD

#if _WIN32_WINNT <= &h0502
	declare function AllocateAndGetTcpExTableFromStack cdecl(byval ppTcpTable as PVOID ptr, byval bOrder as WINBOOL, byval hHeap as HANDLE, byval dwFlags as DWORD, byval dwFamily as DWORD) as DWORD
	declare function AllocateAndGetUdpExTableFromStack cdecl(byval ppUdpTable as PVOID ptr, byval bOrder as WINBOOL, byval hHeap as HANDLE, byval dwFlags as DWORD, byval dwFamily as DWORD) as DWORD
#else
	declare function GetTcpTable2(byval TcpTable as PMIB_TCPTABLE2, byval SizePointer as PULONG, byval Order as WINBOOL) as ULONG
#endif

declare function GetOwnerModuleFromPidAndInfo cdecl(byval ulPid as ULONG, byval pInfo as ULONGLONG ptr, byval Class as TCPIP_OWNER_MODULE_INFO_CLASS, byval pBuffer as PVOID, byval pdwSize as PDWORD) as DWORD
declare function GetIpStatistics(byval Statistics as PMIB_IPSTATS) as ULONG
declare function GetIcmpStatistics(byval Statistics as PMIB_ICMP) as ULONG
declare function GetTcpStatistics(byval Statistics as PMIB_TCPSTATS) as ULONG
declare function GetUdpStatistics(byval Stats as PMIB_UDPSTATS) as ULONG
declare function GetIpStatisticsEx(byval Statistics as PMIB_IPSTATS, byval Family as ULONG) as ULONG
declare function SetIpStatisticsEx(byval Statistics as PMIB_IPSTATS, byval Family as ULONG) as ULONG
declare function GetIcmpStatisticsEx(byval Statistics as PMIB_ICMP_EX, byval Family as ULONG) as ULONG
declare function GetTcpStatisticsEx(byval Statistics as PMIB_TCPSTATS, byval Family as ULONG) as ULONG
declare function GetUdpStatisticsEx(byval Statistics as PMIB_UDPSTATS, byval Family as ULONG) as ULONG
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
#define NHPALLOCATEANDGETINTERFACEINFOFROMSTACK_DEFINED
declare function NhpAllocateAndGetInterfaceInfoFromStack(byval ppTable as IP_INTERFACE_NAME_INFO ptr ptr, byval pdwCount as PDWORD, byval bOrder as WINBOOL, byval hHeap as HANDLE, byval dwFlags as DWORD) as DWORD
declare function GetBestInterface(byval dwDestAddr as IPAddr, byval pdwBestIfIndex as PDWORD) as DWORD
declare function GetBestInterfaceEx(byval pDestAddr as SOCKADDR ptr, byval pdwBestIfIndex as PDWORD) as DWORD
declare function GetBestRoute(byval dwDestAddr as DWORD, byval dwSourceAddr as DWORD, byval pBestRoute as PMIB_IPFORWARDROW) as DWORD
declare function NotifyAddrChange(byval Handle as PHANDLE, byval overlapped as LPOVERLAPPED) as DWORD
declare function NotifyRouteChange(byval Handle as PHANDLE, byval overlapped as LPOVERLAPPED) as DWORD
declare function CancelIPChangeNotify(byval notifyOverlapped as LPOVERLAPPED) as WINBOOL
declare function GetAdapterIndex(byval AdapterName as LPWSTR, byval IfIndex as PULONG) as DWORD
declare function AddIPAddress(byval Address as IPAddr, byval IpMask as IPMask, byval IfIndex as DWORD, byval NTEContext as PULONG, byval NTEInstance as PULONG) as DWORD
declare function DeleteIPAddress(byval NTEContext as ULONG) as DWORD
declare function GetNetworkParams(byval pFixedInfo as PFIXED_INFO, byval pOutBufLen as PULONG) as DWORD
declare function GetAdaptersInfo(byval AdapterInfo as PIP_ADAPTER_INFO, byval SizePointer as PULONG) as ULONG
declare function GetAdapterOrderMap() as PIP_ADAPTER_ORDER_MAP
declare function GetAdaptersAddresses(byval Family as ULONG, byval Flags as ULONG, byval Reserved as PVOID, byval AdapterAddresses as PIP_ADAPTER_ADDRESSES, byval SizePointer as PULONG) as ULONG
declare function GetPerAdapterInfo(byval IfIndex as ULONG, byval pPerAdapterInfo as PIP_PER_ADAPTER_INFO, byval pOutBufLen as PULONG) as DWORD
declare function IpReleaseAddress(byval AdapterInfo as PIP_ADAPTER_INDEX_MAP) as DWORD
declare function IpRenewAddress(byval AdapterInfo as PIP_ADAPTER_INDEX_MAP) as DWORD
declare function SendARP(byval DestIP as IPAddr, byval SrcIP as IPAddr, byval pMacAddr as PVOID, byval PhyAddrLen as PULONG) as DWORD
declare function GetRTTAndHopCount(byval DestIpAddress as IPAddr, byval HopCount as PULONG, byval MaxHops as ULONG, byval RTT as PULONG) as WINBOOL
declare function GetFriendlyIfIndex(byval IfIndex as DWORD) as DWORD
declare function EnableRouter(byval pHandle as HANDLE ptr, byval pOverlapped as OVERLAPPED ptr) as DWORD
declare function UnenableRouter(byval pOverlapped as OVERLAPPED ptr, byval lpdwEnableCount as LPDWORD) as DWORD
declare function DisableMediaSense(byval pHandle as HANDLE ptr, byval pOverLapped as OVERLAPPED ptr) as DWORD
declare function RestoreMediaSense(byval pOverlapped as OVERLAPPED ptr, byval lpdwEnableCount as LPDWORD) as DWORD

#if _WIN32_WINNT >= &h0600
	const NET_STRING_IPV4_ADDRESS = &h00000001
	const NET_STRING_IPV4_SERVICE = &h00000002
	const NET_STRING_IPV4_NETWORK = &h00000004
	const NET_STRING_IPV6_ADDRESS = &h00000008
	const NET_STRING_IPV6_ADDRESS_NO_SCOPE = &h00000010
	const NET_STRING_IPV6_SERVICE = &h00000020
	const NET_STRING_IPV6_SERVICE_NO_SCOPE = &h00000040
	const NET_STRING_IPV6_NETWORK = &h00000080
	const NET_STRING_NAMED_ADDRESS = &h00000100
	const NET_STRING_NAMED_SERVICE = &h00000200
	const NET_STRING_IP_ADDRESS = NET_STRING_IPV4_ADDRESS or NET_STRING_IPV6_ADDRESS
	const NET_STRING_IP_ADDRESS_NO_SCOPE = NET_STRING_IPV4_ADDRESS or NET_STRING_IPV6_ADDRESS_NO_SCOPE
	const NET_STRING_IP_SERVICE = NET_STRING_IPV4_SERVICE or NET_STRING_IPV6_SERVICE
	const NET_STRING_IP_SERVICE_NO_SCOPE = NET_STRING_IPV4_SERVICE or NET_STRING_IPV6_SERVICE_NO_SCOPE
	const NET_STRING_IP_NETWORK = NET_STRING_IPV4_NETWORK or NET_STRING_IPV6_NETWORK
	const NET_STRING_ANY_ADDRESS = NET_STRING_NAMED_ADDRESS or NET_STRING_IP_ADDRESS
	const NET_STRING_ANY_ADDRESS_NO_SCOPE = NET_STRING_NAMED_ADDRESS or NET_STRING_IP_ADDRESS_NO_SCOPE
	const NET_STRING_ANY_SERVICE = NET_STRING_NAMED_SERVICE or NET_STRING_IP_SERVICE
	const NET_STRING_ANY_SERVICE_NO_SCOPE = NET_STRING_NAMED_SERVICE or NET_STRING_IP_SERVICE_NO_SCOPE

	type NET_ADDRESS_FORMAT_ as long
	enum
		NET_ADDRESS_FORMAT_UNSPECIFIED = 0
		NET_ADDRESS_DNS_NAME
		NET_ADDRESS_IPV4
		NET_ADDRESS_IPV6
	end enum

	type NET_ADDRESS_FORMAT as NET_ADDRESS_FORMAT_
	declare function GetIpErrorString(byval ErrorCode as IP_STATUS, byval Buffer as PWSTR, byval Size as PDWORD) as DWORD
	declare function ResolveNeighbor(byval NetworkAddress as SOCKADDR ptr, byval PhysicalAddress as PVOID, byval PhysicalAddressLength as PULONG) as ULONG
	declare function CreatePersistentTcpPortReservation(byval StartPort as USHORT, byval NumberOfPorts as USHORT, byval Token as PULONG64) as ULONG
	declare function CreatePersistentUdpPortReservation(byval StartPort as USHORT, byval NumberOfPorts as USHORT, byval Token as PULONG64) as ULONG
	declare function DeletePersistentTcpPortReservation(byval StartPort as USHORT, byval NumberOfPorts as USHORT) as ULONG
	declare function DeletePersistentUdpPortReservation(byval StartPort as USHORT, byval NumberOfPorts as USHORT) as ULONG
	declare function LookupPersistentTcpPortReservation(byval StartPort as USHORT, byval NumberOfPorts as USHORT, byval Token as PULONG64) as ULONG
	declare function LookupPersistentUdpPortReservation(byval StartPort as USHORT, byval NumberOfPorts as USHORT, byval Token as PULONG64) as ULONG
#endif

end extern
