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

#if _WIN32_WINNT >= &h0600
	#include once "winapifamily.bi"

	extern "Windows"

	#define _NETIOAPI_H_
	type NETIO_STATUS as DWORD
	#define NETIO_SUCCESS(x) ((x) = NO_ERROR)
	#define _NETIOAPI_SUCCESS_

	type _MIB_NOTIFICATION_TYPE as long
	enum
		MibParameterNotification
		MibAddInstance
		MibDeleteInstance
		MibInitialNotification
	end enum

	type MIB_NOTIFICATION_TYPE as _MIB_NOTIFICATION_TYPE
	type PMIB_NOTIFICATION_TYPE as _MIB_NOTIFICATION_TYPE ptr
	declare function ConvertInterfaceNameToLuidA(byval InterfaceName as const zstring ptr, byval InterfaceLuid as NET_LUID ptr) as DWORD
	declare function ConvertInterfaceNameToLuidW(byval InterfaceName as const wstring ptr, byval InterfaceLuid as NET_LUID ptr) as DWORD
	declare function ConvertInterfaceLuidToNameA(byval InterfaceLuid as const NET_LUID ptr, byval InterfaceName as PSTR, byval Length as SIZE_T_) as DWORD
	declare function ConvertInterfaceLuidToNameW(byval InterfaceLuid as const NET_LUID ptr, byval InterfaceName as PWSTR, byval Length as SIZE_T_) as DWORD
	declare function ConvertInterfaceLuidToIndex(byval InterfaceLuid as const NET_LUID ptr, byval InterfaceIndex as PNET_IFINDEX) as DWORD
	declare function ConvertInterfaceIndexToLuid(byval InterfaceIndex as NET_IFINDEX, byval InterfaceLuid as PNET_LUID) as DWORD
	declare function ConvertInterfaceLuidToAlias(byval InterfaceLuid as const NET_LUID ptr, byval InterfaceAlias as PWSTR, byval Length as SIZE_T_) as DWORD
	declare function ConvertInterfaceAliasToLuid(byval InterfaceAlias as const wstring ptr, byval InterfaceLuid as PNET_LUID) as DWORD
	declare function ConvertInterfaceLuidToGuid(byval InterfaceLuid as const NET_LUID ptr, byval InterfaceGuid as GUID ptr) as DWORD
	declare function ConvertInterfaceGuidToLuid(byval InterfaceGuid as const GUID ptr, byval InterfaceLuid as PNET_LUID) as DWORD
	declare function if_nametoindex(byval InterfaceName as PCSTR) as NET_IFINDEX
	declare function if_indextoname(byval InterfaceIndex as NET_IFINDEX, byval InterfaceName as PCHAR) as PCHAR
	declare function GetCurrentThreadCompartmentId() as NET_IF_COMPARTMENT_ID
	declare function SetCurrentThreadCompartmentId(byval CompartmentId as NET_IF_COMPARTMENT_ID) as DWORD
	declare function GetSessionCompartmentId(byval SessionId as ULONG) as NET_IF_COMPARTMENT_ID
	declare function SetSessionCompartmentId(byval SessionId as ULONG, byval CompartmentId as NET_IF_COMPARTMENT_ID) as DWORD
	declare function GetNetworkInformation(byval NetworkGuid as const NET_IF_NETWORK_GUID ptr, byval CompartmentId as PNET_IF_COMPARTMENT_ID, byval SiteId as PULONG, byval NetworkName as PWCHAR, byval Length as ULONG) as DWORD
	declare function SetNetworkInformation(byval NetworkGuid as const NET_IF_NETWORK_GUID ptr, byval CompartmentId as NET_IF_COMPARTMENT_ID, byval NetworkName as const wstring ptr) as DWORD
	declare function ConvertLengthToIpv4Mask(byval MaskLength as ULONG, byval Mask as PULONG) as DWORD
	declare function ConvertIpv4MaskToLength(byval Mask as ULONG, byval MaskLength as PUINT8) as DWORD

	end extern
#endif
