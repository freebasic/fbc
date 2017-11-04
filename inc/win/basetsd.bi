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

'' The following symbols have been renamed:
''     typedef SIZE_T => SIZE_T_
''     typedef SSIZE_T => SSIZE_T_

#define _BASETSD_H_

#ifdef __FB_64BIT__
	type POINTER_64_INT as ulongint
#else
	type POINTER_64_INT as ulong
#endif

#define POINTER_32
#define POINTER_64
#define FIRMWARE_PTR
#define POINTER_SIGNED
#define POINTER_UNSIGNED
#define SPOINTER_32 POINTER_SIGNED
#define UPOINTER_32 POINTER_UNSIGNED

type INT8 as byte
type PINT8 as byte ptr
type INT16 as short
type PINT16 as short ptr
type INT32 as long
type PINT32 as long ptr
type INT64 as longint
type PINT64 as longint ptr
type UINT8 as ubyte
type PUINT8 as ubyte ptr
type UINT16 as ushort
type PUINT16 as ushort ptr
type UINT32 as ulong
type PUINT32 as ulong ptr
type UINT64 as ulongint
type PUINT64 as ulongint ptr
type LONG32 as long
type PLONG32 as long ptr
type ULONG32 as ulong
type PULONG32 as ulong ptr
type DWORD32 as ulong
type PDWORD32 as ulong ptr

#ifdef __FB_64BIT__
	type INT_PTR as longint
	type PINT_PTR as longint ptr
	type UINT_PTR as ulongint
	type PUINT_PTR as ulongint ptr
	type LONG_PTR as longint
	type PLONG_PTR as longint ptr
	type ULONG_PTR as ulongint
	type PULONG_PTR as ulongint ptr
	type __int3264 as longint
	const ADDRESS_TAG_BIT = &h40000000000ull
	type SHANDLE_PTR as longint
	type HANDLE_PTR as ulongint
	type UHALF_PTR as ulong
	type PUHALF_PTR as ulong ptr
	type HALF_PTR as long
	type PHALF_PTR as long ptr

	#define HandleToULong(h) culng(cast(ULONG_PTR, (h)))
	#define HandleToLong(h) clng(cast(LONG_PTR, (h)))
	#define ULongToHandle(h) cptr(any ptr, cast(UINT_PTR, (h)))
	#define LongToHandle(h) cptr(any ptr, cast(INT_PTR, (h)))
	#define PtrToUlong(p) culng(cast(ULONG_PTR, (p)))
	#define PtrToUint(p) culng(cast(UINT_PTR, (p)))
	#define PtrToUshort(p) cushort(culng(cast(ULONG_PTR, (p))))
	#define PtrToLong(p) clng(cast(LONG_PTR, (p)))
	#define PtrToInt(p) clng(cast(INT_PTR, (p)))
	#define PtrToShort(p) cshort(clng(cast(LONG_PTR, (p))))
	#define IntToPtr(i) cptr(any ptr, cast(INT_PTR, (i)))
	#define UIntToPtr(ui) cptr(any ptr, cast(UINT_PTR, (ui)))
	#define LongToPtr(l) cptr(any ptr, cast(LONG_PTR, (l)))
	#define ULongToPtr(ul) cptr(any ptr, cast(ULONG_PTR, (ul)))
	#define PtrToPtr64(p) cptr(any ptr, p)
	#define Ptr64ToPtr(p) cptr(any ptr, p)
	#define HandleToHandle64(h) PtrToPtr64(h)
	#define Handle64ToHandle(h) Ptr64ToPtr(h)
	#define Ptr32ToPtr(p) cptr(any ptr, cast(ULONG_PTR, culng(cast(ULONG_PTR, (p)))))
	#define Handle32ToHandle(h) cptr(any ptr, cast(LONG_PTR, clng(cast(ULONG_PTR, (h)))))
	#define PtrToPtr32(p) cptr(any ptr, cast(ULONG_PTR, culng(cast(ULONG_PTR, (p)))))
#else
	type INT_PTR as long
	type PINT_PTR as long ptr
	type UINT_PTR as ulong
	type PUINT_PTR as ulong ptr
	type LONG_PTR as long
	type PLONG_PTR as long ptr
	type ULONG_PTR as ulong
	type PULONG_PTR as ulong ptr
	type __int3264 as long
	const ADDRESS_TAG_BIT = &h80000000u
	type UHALF_PTR as ushort
	type PUHALF_PTR as ushort ptr
	type HALF_PTR as short
	type PHALF_PTR as short ptr
	type SHANDLE_PTR as long
	type HANDLE_PTR as ulong

	#define HandleToULong(h) cast(ULONG, cast(ULONG_PTR, (h)))
	#define HandleToLong(h) cast(LONG, cast(LONG_PTR, (h)))
	#define ULongToHandle(ul) cast(HANDLE, cast(ULONG_PTR, (ul)))
	#define LongToHandle(h) cast(HANDLE, cast(LONG_PTR, (h)))
	#define PtrToUlong(p) cast(ULONG, cast(ULONG_PTR, (p)))
	#define PtrToLong(p) cast(LONG, cast(LONG_PTR, (p)))
	#define PtrToUint(p) cast(UINT, cast(UINT_PTR, (p)))
	#define PtrToInt(p) cast(INT_, cast(INT_PTR, (p)))
	#define PtrToUshort(p) cushort(cast(ULONG_PTR, (p)))
	#define PtrToShort(p) cshort(cast(LONG_PTR, (p)))
	#define IntToPtr(i) cptr(VOID ptr, cast(INT_PTR, clng(i)))
	#define UIntToPtr(ui) cptr(VOID ptr, cast(UINT_PTR, culng(ui)))
	#define LongToPtr(l) cptr(VOID ptr, cast(LONG_PTR, clng(l)))
	#define ULongToPtr(ul) cptr(VOID ptr, cast(ULONG_PTR, culng(ul)))
	#define PtrToPtr64(p) cptr(any ptr, cast(ULONG_PTR, (p)))
	#define Ptr64ToPtr(p) cptr(any ptr, cast(ULONG_PTR, (p)))
	#define HandleToHandle64(h) cptr(any ptr, cast(LONG_PTR, (h)))
	#define Handle64ToHandle(h) cptr(any ptr, cast(ULONG_PTR, (h)))
	#define Ptr32ToPtr(p) cptr(any ptr, p)
	#define Handle32ToHandle(h) Ptr32ToPtr(h)
	#define PtrToPtr32(p) cptr(any ptr, p)
#endif

#define HandleToHandle32(h) PtrToPtr32(h)
const MAXUINT_PTR = not cast(UINT_PTR, 0)
const MAXINT_PTR = cast(INT_PTR, MAXUINT_PTR shr 1)
const MININT_PTR = not MAXINT_PTR
const MAXULONG_PTR = not cast(ULONG_PTR, 0)
const MAXLONG_PTR = cast(LONG_PTR, MAXULONG_PTR shr 1)
const MINLONG_PTR = not MAXLONG_PTR
const MAXUHALF_PTR = cast(UHALF_PTR, not 0)
const MAXHALF_PTR = cast(HALF_PTR, MAXUHALF_PTR shr 1)
const MINHALF_PTR = not MAXHALF_PTR

type SIZE_T_ as ULONG_PTR
type PSIZE_T as ULONG_PTR ptr
type SSIZE_T_ as LONG_PTR
type PSSIZE_T as LONG_PTR ptr

#if _WIN32_WINNT >= &h0600
	const MAXUINT8 = cast(UINT8, not cast(UINT8, 0))
	const MAXINT8 = cast(INT8, MAXUINT8 shr 1)
	const MININT8 = cast(INT8, not MAXINT8)
	#define MAXUINT16 cast(UINT16, not cast(UINT16, 0))
	#define MAXINT16 cast(INT16, MAXUINT16 shr 1)
	#define MININT16 cast(INT16, not MAXINT16)
	const MAXUINT32 = cast(UINT32, not cast(UINT32, 0))
	const MAXINT32 = cast(INT32, MAXUINT32 shr 1)
	const MININT32 = cast(INT32, not MAXINT32)
	const MAXUINT64 = cast(UINT64, not cast(UINT64, 0))
	const MAXINT64 = cast(INT64, MAXUINT64 shr 1)
	const MININT64 = cast(INT64, not MAXINT64)
	const MAXULONG32 = cast(ULONG32, not cast(ULONG32, 0))
	const MAXLONG32 = cast(LONG32, MAXULONG32 shr 1)
	const MINLONG32 = cast(LONG32, not MAXLONG32)
	#define MAXULONG64 cast(ULONG64, not cast(ULONG64, 0))
	#define MAXLONG64 cast(LONG64, MAXULONG64 shr 1)
	#define MINLONG64 cast(LONG64, not MAXLONG64)
	#define MAXULONGLONG cast(ULONGLONG, not cast(ULONGLONG, 0))
	#define MINLONGLONG cast(LONGLONG, not MAXLONGLONG)
	const MAXSIZE_T = cast(SIZE_T_, not cast(SIZE_T_, 0))
	const MAXSSIZE_T = cast(SSIZE_T_, MAXSIZE_T shr 1)
	const MINSSIZE_T = cast(SSIZE_T_, not MAXSSIZE_T)
	const MAXUINT = cast(UINT, not cast(UINT, 0))
	#define MAXINT cast(INT_, MAXUINT shr 1)
	#define MININT cast(INT_, not MAXINT)
	const MAXDWORD32 = cast(DWORD32, not cast(DWORD32, 0))
	#define MAXDWORD64 cast(DWORD64, not cast(DWORD64, 0))
#endif

type DWORD_PTR as ULONG_PTR
type PDWORD_PTR as ULONG_PTR ptr
type LONG64 as longint
type PLONG64 as longint ptr
type ULONG64 as ulongint
type PULONG64 as ulongint ptr
type DWORD64 as ulongint
type PDWORD64 as ulongint ptr
type KAFFINITY as ULONG_PTR
type PKAFFINITY as KAFFINITY ptr
