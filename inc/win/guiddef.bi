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

#include once "_mingw.bi"

#define GUID_DEFINED

type _GUID
	Data1 as ulong
	Data2 as ushort
	Data3 as ushort
	Data4(0 to 7) as ubyte
end type

type GUID as _GUID
#define _GUIDDEF_H_
#define __LPGUID_DEFINED__
type LPGUID as GUID ptr
#define __LPCGUID_DEFINED__
type LPCGUID as const GUID ptr
#define __IID_DEFINED__
type IID as GUID
type LPIID as IID ptr
#define CLSID_DEFINED
type CLSID as GUID
type LPCLSID as CLSID ptr
type FMTID as GUID
type LPFMTID as FMTID ptr
#define IsEqualFMTID(rfmtid1, rfmtid2) IsEqualGUID(rfmtid1, rfmtid2)
#define _REFGUID_DEFINED
type REFGUID as const GUID const ptr
#define _REFIID_DEFINED
type REFIID as const IID const ptr
#define _REFCLSID_DEFINED
type REFCLSID as const IID const ptr
#define _REFFMTID_DEFINED
type REFFMTID as const IID const ptr

#define _SYS_GUID_OPERATORS_
#define InlineIsEqualGUID(rguid1, rguid2) (((((@(rguid1)->Data1)[0] = (@(rguid2)->Data1)[0]) andalso ((@(rguid1)->Data1)[1] = (@(rguid2)->Data1)[1])) andalso ((@(rguid1)->Data1)[2] = (@(rguid2)->Data1)[2])) andalso ((@(rguid1)->Data1)[3] = (@(rguid2)->Data1)[3]))
#define IsEqualGUID(rguid1, rguid2) (memcmp(rguid1, rguid2, sizeof(GUID)) = 0)
#define IsEqualIID(riid1, riid2) IsEqualGUID(riid1, riid2)
#define IsEqualCLSID(rclsid1, rclsid2) IsEqualGUID(rclsid1, rclsid2)
#define _SYS_GUID_OPERATOR_EQ_
