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

#include once "winapifamily.bi"

#define _ADTGEN_H
const AUDIT_TYPE_LEGACY = 1
const AUDIT_TYPE_WMI = 2

type _AUDIT_PARAM_TYPE as long
enum
	APT_None = 1
	APT_String
	APT_Ulong
	APT_Pointer
	APT_Sid
	APT_LogonId
	APT_ObjectTypeList
	APT_Luid
	APT_Guid
	APT_Time
	APT_Int64
	APT_IpAddress
	APT_LogonIdWithSid
end enum

type AUDIT_PARAM_TYPE as _AUDIT_PARAM_TYPE
const AP_ParamTypeBits = 8
const AP_ParamTypeMask = &hff
const AP_FormatHex = &h1 shl AP_ParamTypeBits
const AP_AccessMask = &h2 shl AP_ParamTypeBits
const AP_Filespec = &h1 shl AP_ParamTypeBits
const AP_SidAsLogonId = &h1 shl AP_ParamTypeBits
const AP_PrimaryLogonId = &h1 shl AP_ParamTypeBits
const AP_ClientLogonId = &h2 shl AP_ParamTypeBits
#define ApExtractType(TypeFlags) cast(AUDIT_PARAM_TYPE, TypeFlags and AP_ParamTypeMask)
#define ApExtractFlags(TypeFlags) (TypeFlags and (not AP_ParamTypeMask))
const _AUTHZ_SS_MAXSIZE = 128
const APF_AuditFailure = &h0
const APF_AuditSuccess = &h1
const APF_ValidFlags = APF_AuditSuccess
const AUTHZ_ALLOW_MULTIPLE_SOURCE_INSTANCES = &h1
const AUTHZ_MIGRATED_LEGACY_PUBLISHER = &h2
const AUTHZ_AUDIT_INSTANCE_INFORMATION = &h2

type _AUDIT_OBJECT_TYPE
	ObjectType as GUID
	Flags as USHORT
	Level as USHORT
	AccessMask as ACCESS_MASK
end type

type AUDIT_OBJECT_TYPE as _AUDIT_OBJECT_TYPE
type PAUDIT_OBJECT_TYPE as _AUDIT_OBJECT_TYPE ptr

type _AUDIT_OBJECT_TYPES
	Count as USHORT
	Flags as USHORT
	pObjectTypes as AUDIT_OBJECT_TYPE ptr
end type

type AUDIT_OBJECT_TYPES as _AUDIT_OBJECT_TYPES
type PAUDIT_OBJECT_TYPES as _AUDIT_OBJECT_TYPES ptr

type _AUDIT_IP_ADDRESS
	pIpAddress(0 to 127) as UBYTE
end type

type AUDIT_IP_ADDRESS as _AUDIT_IP_ADDRESS
type PAUDIT_IP_ADDRESS as _AUDIT_IP_ADDRESS ptr

type _AUDIT_PARAM
	as AUDIT_PARAM_TYPE Type
	Length as ULONG
	Flags as DWORD

	union
		Data0 as ULONG_PTR
		String as PWSTR
		u as ULONG_PTR
		psid as SID ptr
		pguid as GUID ptr
		LogonId_LowPart as ULONG
		pObjectTypes as AUDIT_OBJECT_TYPES ptr
		pIpAddress as AUDIT_IP_ADDRESS ptr
	end union

	union
		Data1 as ULONG_PTR
		LogonId_HighPart as LONG
	end union
end type

type AUDIT_PARAM as _AUDIT_PARAM
type PAUDIT_PARAM as _AUDIT_PARAM ptr

type _AUDIT_PARAMS
	Length as ULONG
	Flags as DWORD
	Count as USHORT
	Parameters as AUDIT_PARAM ptr
end type

type AUDIT_PARAMS as _AUDIT_PARAMS
type PAUDIT_PARAMS as _AUDIT_PARAMS ptr

type _AUTHZ_AUDIT_EVENT_TYPE_LEGACY
	CategoryId as USHORT
	AuditId as USHORT
	ParameterCount as USHORT
end type

type AUTHZ_AUDIT_EVENT_TYPE_LEGACY as _AUTHZ_AUDIT_EVENT_TYPE_LEGACY
type PAUTHZ_AUDIT_EVENT_TYPE_LEGACY as _AUTHZ_AUDIT_EVENT_TYPE_LEGACY ptr

union _AUTHZ_AUDIT_EVENT_TYPE_UNION
	Legacy as AUTHZ_AUDIT_EVENT_TYPE_LEGACY
end union

type AUTHZ_AUDIT_EVENT_TYPE_UNION as _AUTHZ_AUDIT_EVENT_TYPE_UNION
type PAUTHZ_AUDIT_EVENT_TYPE_UNION as _AUTHZ_AUDIT_EVENT_TYPE_UNION ptr

type _AUTHZ_AUDIT_EVENT_TYPE_OLD
	Version as ULONG
	dwFlags as DWORD
	RefCount as LONG
	hAudit as ULONG_PTR
	LinkId as LUID
	u as AUTHZ_AUDIT_EVENT_TYPE_UNION
end type

type AUTHZ_AUDIT_EVENT_TYPE_OLD as _AUTHZ_AUDIT_EVENT_TYPE_OLD
type PAUTHZ_AUDIT_EVENT_TYPE_OLD as AUTHZ_AUDIT_EVENT_TYPE_OLD ptr
const AUTHZP_WPD_EVENT = &h10
type AUDIT_HANDLE as PVOID
type PAUDIT_HANDLE as PVOID ptr
