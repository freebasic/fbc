'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   devpropdef.h
''
''   This file is part of the ReactOS PSDK package.
''
''   Contributors:
''     Created by Amine Khaldi.
''
''   THIS SOFTWARE IS NOT COPYRIGHTED
''
''   This source code is offered for use in the public domain. You may
''   use, modify or distribute it freely.
''
''   This code is distributed in the hope that it will be useful but
''   WITHOUT ANY WARRANTY. ALL WARRANTIES, EXPRESS OR IMPLIED ARE HEREBY
''   DISCLAIMED. This includes but is not limited to warranties of
''   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
''
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#if _WIN32_WINNT >= &h0600
	#include once "winapifamily.bi"

	#define _DEVPROPDEF_H_
	type DEVPROPTYPE as ULONG
	type PDEVPROPTYPE as ULONG ptr
	const DEVPROP_TYPEMOD_ARRAY = &h00001000
	const DEVPROP_TYPEMOD_LIST = &h00002000
	const DEVPROP_TYPE_EMPTY = &h00000000
	const DEVPROP_TYPE_NULL = &h00000001
	const DEVPROP_TYPE_SBYTE = &h00000002
	const DEVPROP_TYPE_BYTE = &h00000003
	const DEVPROP_TYPE_INT16 = &h00000004
	const DEVPROP_TYPE_UINT16 = &h00000005
	const DEVPROP_TYPE_INT32 = &h00000006
	const DEVPROP_TYPE_UINT32 = &h00000007
	const DEVPROP_TYPE_INT64 = &h00000008
	const DEVPROP_TYPE_UINT64 = &h00000009
	const DEVPROP_TYPE_FLOAT = &h0000000A
	const DEVPROP_TYPE_DOUBLE = &h0000000B
	const DEVPROP_TYPE_DECIMAL = &h0000000C
	const DEVPROP_TYPE_GUID = &h0000000D
	const DEVPROP_TYPE_CURRENCY = &h0000000E
	const DEVPROP_TYPE_DATE = &h0000000F
	const DEVPROP_TYPE_FILETIME = &h00000010
	const DEVPROP_TYPE_BOOLEAN = &h00000011
	const DEVPROP_TYPE_STRING = &h00000012
	const DEVPROP_TYPE_STRING_LIST = DEVPROP_TYPE_STRING or DEVPROP_TYPEMOD_LIST
	const DEVPROP_TYPE_SECURITY_DESCRIPTOR = &h00000013
	const DEVPROP_TYPE_SECURITY_DESCRIPTOR_STRING = &h00000014
	const DEVPROP_TYPE_DEVPROPKEY = &h00000015
	const DEVPROP_TYPE_DEVPROPTYPE = &h00000016
	const DEVPROP_TYPE_BINARY = DEVPROP_TYPE_BYTE or DEVPROP_TYPEMOD_ARRAY
	const DEVPROP_TYPE_ERROR = &h00000017
	const DEVPROP_TYPE_NTSTATUS = &h00000018
	const DEVPROP_TYPE_STRING_INDIRECT = &h00000019
	const MAX_DEVPROP_TYPE = &h00000019
	const MAX_DEVPROP_TYPEMOD = &h00002000
	const DEVPROP_MASK_TYPE = &h00000FFF
	const DEVPROP_MASK_TYPEMOD = &h0000F000
	type DEVPROP_BOOLEAN as CHAR
	type PDEVPROP_BOOLEAN as CHAR ptr
	const DEVPROP_TRUE = cast(DEVPROP_BOOLEAN, -1)
	const DEVPROP_FALSE = cast(DEVPROP_BOOLEAN, 0)
	#define DEVPROPKEY_DEFINED

	type DEVPROPGUID as GUID
	type PDEVPROPGUID as GUID ptr
	type DEVPROPID as ULONG
	type PDEVPROPID as ULONG ptr

	type _DEVPROPKEY
		fmtid as DEVPROPGUID
		pid as DEVPROPID
	end type

	type DEVPROPKEY as _DEVPROPKEY
	type PDEVPROPKEY as _DEVPROPKEY ptr
	const DEVPROPID_FIRST_USABLE = 2
	#define IsEqualDevPropKey(a, b) (((a).pid = (b).pid) andalso IsEqualIID(@(a).fmtid, @(b).fmtid))
#endif
