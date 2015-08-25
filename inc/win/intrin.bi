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

#include once "crtdefs.bi"
#include once "crt/setjmp.bi"
#include once "crt/stddef.bi"
#include once "crt/stdlib.bi"
#include once "crt/errno.bi"

'' The following symbols have been renamed:
''     procedure inp => inp_
''     #define _rotl64 => _rotl64_
''     #define _rotr64 => _rotr64_

extern "C"

#define _INTRIN_MAC_

#ifdef __FB_64BIT__
	declare sub __faststorefence()
	#define __INTRINSIC_DEFINED___faststorefence
	declare sub __stosq(byval as ulongint ptr, byval as ulongint, byval as uinteger)
	#define __INTRINSIC_DEFINED___stosq
	declare function _interlockedbittestandset64(byval a as longint ptr, byval b as longint) as ubyte
	#define __INTRINSIC_DEFINED__interlockedbittestandset64
	declare function _interlockedbittestandreset64(byval a as longint ptr, byval b as longint) as ubyte
	#define __INTRINSIC_DEFINED__interlockedbittestandreset64
	declare function _interlockedbittestandcomplement64(byval a as longint ptr, byval b as longint) as ubyte
	#define __INTRINSIC_DEFINED__interlockedbittestandcomplement64
	declare function InterlockedBitTestAndSet64(byval a as longint ptr, byval b as longint) as ubyte
	#define __INTRINSIC_DEFINED_InterlockedBitTestAndSet64
	declare function InterlockedBitTestAndReset64(byval a as longint ptr, byval b as longint) as ubyte
	#define __INTRINSIC_DEFINED_InterlockedBitTestAndReset64
	declare function InterlockedBitTestAndComplement64(byval a as longint ptr, byval b as longint) as ubyte
	#define __INTRINSIC_DEFINED_InterlockedBitTestAndComplement64
	declare function _InterlockedAnd64(byval as longint ptr, byval as longint) as longint
	#define __INTRINSIC_DEFINED__InterlockedAnd64
	declare function _InterlockedOr64(byval as longint ptr, byval as longint) as longint
	#define __INTRINSIC_DEFINED__InterlockedOr64
	declare function _InterlockedXor64(byval as longint ptr, byval as longint) as longint
	#define __INTRINSIC_DEFINED__InterlockedXor64
	declare function _InterlockedIncrement64(byval Addend as longint ptr) as longint
	#define __INTRINSIC_DEFINED__InterlockedIncrement64
	declare function _InterlockedDecrement64(byval Addend as longint ptr) as longint
	#define __INTRINSIC_DEFINED__InterlockedDecrement64
	declare function _InterlockedExchange64(byval Target as longint ptr, byval Value as longint) as longint
	#define __INTRINSIC_DEFINED__InterlockedExchange64
	declare function _InterlockedExchangeAdd64(byval Addend as longint ptr, byval Value as longint) as longint
	#define __INTRINSIC_DEFINED__InterlockedExchangeAdd64
	declare function __readgsbyte(byval Offset as ulong) as ubyte
	#define __INTRINSIC_DEFINED___readgsbyte
	declare function __readgsword(byval Offset as ulong) as ushort
	#define __INTRINSIC_DEFINED___readgsword
	declare function __readgsdword(byval Offset as ulong) as ulong
	#define __INTRINSIC_DEFINED___readgsdword
	declare function __readgsqword(byval Offset as ulong) as ulongint
	#define __INTRINSIC_DEFINED___readgsqword
	declare sub __writegsbyte(byval Offset as ulong, byval Data as ubyte)
	#define __INTRINSIC_DEFINED___writegsbyte
	declare sub __writegsword(byval Offset as ulong, byval Data as ushort)
	#define __INTRINSIC_DEFINED___writegsword
	declare sub __writegsdword(byval Offset as ulong, byval Data as ulong)
	#define __INTRINSIC_DEFINED___writegsdword
	declare sub __writegsqword(byval Offset as ulong, byval Data as ulongint)
	#define __INTRINSIC_DEFINED___writegsqword
	declare function _BitScanForward64(byval Index as ulong ptr, byval Mask as ulongint) as ubyte
	#define __INTRINSIC_DEFINED__BitScanForward64
	declare function _BitScanReverse64(byval Index as ulong ptr, byval Mask as ulongint) as ubyte
	#define __INTRINSIC_DEFINED__BitScanReverse64
	declare function _bittest64(byval a as const longint ptr, byval b as longint) as ubyte
	#define __INTRINSIC_DEFINED__bittest64
	declare function _bittestandset64(byval a as longint ptr, byval b as longint) as ubyte
	#define __INTRINSIC_DEFINED__bittestandset64
	declare function _bittestandreset64(byval a as longint ptr, byval b as longint) as ubyte
	#define __INTRINSIC_DEFINED__bittestandreset64
	declare function _bittestandcomplement64(byval a as longint ptr, byval b as longint) as ubyte
	#define __INTRINSIC_DEFINED__bittestandcomplement64
	declare sub __movsq(byval Dest as ulongint ptr, byval Source as const ulongint ptr, byval Count as uinteger)
	#define __INTRINSIC_DEFINED___movsq
#endif

#define __INTRINSIC_DEFINED__InterlockedAnd
#define __INTRINSIC_DEFINED__InterlockedOr
#define __INTRINSIC_DEFINED__InterlockedXor
declare function _InterlockedIncrement16(byval Addend as short ptr) as short
#define __INTRINSIC_DEFINED__InterlockedIncrement16
declare function _InterlockedDecrement16(byval Addend as short ptr) as short
#define __INTRINSIC_DEFINED__InterlockedDecrement16
declare function _InterlockedCompareExchange16(byval Destination as short ptr, byval ExChange as short, byval Comperand as short) as short
#define __INTRINSIC_DEFINED__InterlockedCompareExchange16
declare function _InterlockedExchangeAdd(byval Addend as long ptr, byval Value as long) as long
#define __INTRINSIC_DEFINED__InterlockedExchangeAdd
declare function _InterlockedCompareExchange(byval Destination as long ptr, byval ExChange as long, byval Comperand as long) as long
#define __INTRINSIC_DEFINED__InterlockedCompareExchange
declare function _InterlockedIncrement(byval Addend as long ptr) as long
#define __INTRINSIC_DEFINED__InterlockedIncrement
declare function _InterlockedDecrement(byval Addend as long ptr) as long
#define __INTRINSIC_DEFINED__InterlockedDecrement
declare function _InterlockedExchange(byval Target as long ptr, byval Value as long) as long
#define __INTRINSIC_DEFINED__InterlockedExchange
declare function _InterlockedCompareExchange64(byval Destination as longint ptr, byval ExChange as longint, byval Comperand as longint) as longint
#define __INTRINSIC_DEFINED__InterlockedCompareExchange64
declare function _InterlockedCompareExchangePointer(byval Destination as any ptr ptr, byval ExChange as any ptr, byval Comperand as any ptr) as any ptr
#define __INTRINSIC_DEFINED__InterlockedCompareExchangePointer
declare function _InterlockedExchangePointer(byval Target as any ptr ptr, byval Value as any ptr) as any ptr
#define __INTRINSIC_DEFINED__InterlockedExchangePointer
declare sub __int2c()
#define __INTRINSIC_DEFINED___int2c
declare sub __stosb(byval Dest as ubyte ptr, byval Data as ubyte, byval Count as uinteger)
#define __INTRINSIC_DEFINED___stosb
declare sub __stosw(byval Dest as ushort ptr, byval Data as ushort, byval Count as uinteger)
#define __INTRINSIC_DEFINED___stosw
declare sub __stosd(byval Dest as ulong ptr, byval Data as ulong, byval Count as uinteger)
#define __INTRINSIC_DEFINED___stosd
declare function _interlockedbittestandset(byval Base as long ptr, byval Offset as long) as ubyte
#define __INTRINSIC_DEFINED__interlockedbittestandset
declare function _interlockedbittestandreset(byval Base as long ptr, byval Offset as long) as ubyte
#define __INTRINSIC_DEFINED__interlockedbittestandreset
declare function _interlockedbittestandcomplement(byval Base as long ptr, byval Offset as long) as ubyte
#define __INTRINSIC_DEFINED__interlockedbittestandcomplement
declare function InterlockedBitTestAndSet(byval Base as long ptr, byval Offset as long) as ubyte
#define __INTRINSIC_DEFINED_InterlockedBitTestAndSet
declare function InterlockedBitTestAndReset(byval Base as long ptr, byval Offset as long) as ubyte
#define __INTRINSIC_DEFINED_InterlockedBitTestAndReset
declare function InterlockedBitTestAndComplement(byval Base as long ptr, byval Offset as long) as ubyte
#define __INTRINSIC_DEFINED_InterlockedBitTestAndComplement
declare function _BitScanForward(byval Index as ulong ptr, byval Mask as ulong) as ubyte
#define __INTRINSIC_DEFINED__BitScanForward
declare function _BitScanReverse(byval Index as ulong ptr, byval Mask as ulong) as ubyte
#define __INTRINSIC_DEFINED__BitScanReverse
declare function _bittest(byval a as const long ptr, byval b as long) as ubyte
#define __INTRINSIC_DEFINED__bittest
declare function _bittestandset(byval a as long ptr, byval b as long) as ubyte
#define __INTRINSIC_DEFINED__bittestandset
declare function _bittestandreset(byval a as long ptr, byval b as long) as ubyte
#define __INTRINSIC_DEFINED__bittestandreset
declare function _bittestandcomplement(byval a as long ptr, byval b as long) as ubyte
#define __INTRINSIC_DEFINED__bittestandcomplement
declare sub __movsb(byval Destination as ubyte ptr, byval Source as const ubyte ptr, byval Count as uinteger)
#define __INTRINSIC_DEFINED___movsb
declare sub __movsw(byval Dest as ushort ptr, byval Source as const ushort ptr, byval Count as uinteger)
#define __INTRINSIC_DEFINED___movsw
declare sub __movsd(byval Dest as ulong ptr, byval Source as const ulong ptr, byval Count as uinteger)
#define __INTRINSIC_DEFINED___movsd

#ifndef __FB_64BIT__
	declare function __readfsbyte(byval Offset as ulong) as ubyte
	#define __INTRINSIC_DEFINED___readfsbyte
	declare function __readfsword(byval Offset as ulong) as ushort
	#define __INTRINSIC_DEFINED___readfsword
	declare function __readfsdword(byval Offset as ulong) as ulong
	#define __INTRINSIC_DEFINED___readfsdword
	declare sub __writefsbyte(byval Offset as ulong, byval Data as ubyte)
	#define __INTRINSIC_DEFINED___writefsbyte
	declare sub __writefsword(byval Offset as ulong, byval Data as ushort)
	#define __INTRINSIC_DEFINED___writefsword
	declare sub __writefsdword(byval Offset as ulong, byval Data as ulong)
	#define __INTRINSIC_DEFINED___writefsdword
#endif

#define __INTRINSIC_SPECIAL__InterlockedIncrement
#define __INTRINSIC_SPECIAL__InterlockedDecrement
#define __INTRINSIC_SPECIAL__InterlockedExchange
#define __INTRINSIC_SPECIAL__InterlockedExchangeAdd
#define __INTRINSIC_SPECIAL__InterlockedCompareExchange
#define __INTRINSIC_SPECIAL__InterlockedCompareExchangePointer
#define __INTRINSIC_SPECIAL__InterlockedExchangePointer
#define __INTRINSIC_SPECIAL__InterlockedAnd64
#define __INTRINSIC_SPECIAL__InterlockedOr64
#define __INTRINSIC_SPECIAL__InterlockedXor64
#define __INTRINSIC_SPECIAL__InterlockedIncrement64
#define __INTRINSIC_SPECIAL__InterlockedDecrement64
#define __INTRINSIC_SPECIAL__InterlockedExchange64
#define __INTRINSIC_SPECIAL__InterlockedExchangeAdd64
#define __INTRINSIC_SPECIAL__InterlockedCompareExchange64
#define __INTRIN_H_

#ifdef __FB_64BIT__
	declare function __readcr0() as ulongint
	#define __INTRINSIC_DEFINED___readcr0
	declare function __readcr2() as ulongint
	#define __INTRINSIC_DEFINED___readcr2
	declare function __readcr3() as ulongint
	#define __INTRINSIC_DEFINED___readcr3
	declare function __readcr4() as ulongint
	#define __INTRINSIC_DEFINED___readcr4
	declare function __readcr8() as ulongint
	#define __INTRINSIC_DEFINED___readcr8
	declare sub __writecr0(byval as ulongint)
	#define __INTRINSIC_DEFINED___writecr0
	declare sub __writecr3(byval as ulongint)
	#define __INTRINSIC_DEFINED___writecr3
	declare sub __writecr4(byval as ulongint)
	#define __INTRINSIC_DEFINED___writecr4
	declare sub __writecr8(byval as ulongint)
	#define __INTRINSIC_DEFINED___writecr8
	#define __INTRINSIC_DEFINED__umul128
	#define __INTRINSIC_DEFINED__mul128
	#define __INTRINSIC_DEFINED___shiftleft128
	#define __INTRINSIC_DEFINED___shiftright128
#endif

declare function __inbyte(byval Port as ushort) as ubyte
#define __INTRINSIC_DEFINED___inbyte
declare function __inword(byval Port as ushort) as ushort
#define __INTRINSIC_DEFINED___inword
declare function __indword(byval Port as ushort) as ulong
#define __INTRINSIC_DEFINED___indword
declare sub __outbyte(byval Port as ushort, byval Data_ as ubyte)
#define __INTRINSIC_DEFINED___outbyte
declare sub __outword(byval Port as ushort, byval Data_ as ushort)
#define __INTRINSIC_DEFINED___outword
declare sub __outdword(byval Port as ushort, byval Data_ as ulong)
#define __INTRINSIC_DEFINED___outdword
declare sub __inbytestring(byval Port as ushort, byval Buffer as ubyte ptr, byval Count as ulong)
#define __INTRINSIC_DEFINED___inbytestring
declare sub __inwordstring(byval Port as ushort, byval Buffer as ushort ptr, byval Count as ulong)
#define __INTRINSIC_DEFINED___inwordstring
declare sub __indwordstring(byval Port as ushort, byval Buffer as ulong ptr, byval Count as ulong)
#define __INTRINSIC_DEFINED___indwordstring
declare sub __outbytestring(byval Port as ushort, byval Buffer as ubyte ptr, byval Count as ulong)
#define __INTRINSIC_DEFINED___outbytestring
declare sub __outwordstring(byval Port as ushort, byval Buffer as ushort ptr, byval Count as ulong)
#define __INTRINSIC_DEFINED___outwordstring
declare sub __outdwordstring(byval Port as ushort, byval Buffer as ulong ptr, byval Count as ulong)
#define __INTRINSIC_DEFINED___outdwordstring
declare sub __cpuid(byval CPUInfo as long ptr, byval InfoType as long)
#define __INTRINSIC_DEFINED___cpuid
declare function __readmsr(byval as ulong) as ulongint
#define __INTRINSIC_DEFINED___readmsr
declare sub __writemsr(byval as ulong, byval as ulongint)
#define __INTRINSIC_DEFINED___writemsr

#ifndef __FB_64BIT__
	declare function __readcr0() as ulong
	#define __INTRINSIC_DEFINED___readcr0
	declare function __readcr2() as ulong
	#define __INTRINSIC_DEFINED___readcr2
	declare function __readcr3() as ulong
	#define __INTRINSIC_DEFINED___readcr3
	declare function __readcr4() as ulong
	#define __INTRINSIC_DEFINED___readcr4
	declare function __readcr8() as ulong
	#define __INTRINSIC_DEFINED___readcr8
	declare sub __writecr0(byval as ulong)
	#define __INTRINSIC_DEFINED___writecr0
	declare sub __writecr3(byval as ulong)
	#define __INTRINSIC_DEFINED___writecr3
	declare sub __writecr4(byval as ulong)
	#define __INTRINSIC_DEFINED___writecr4
	declare sub __writecr8(byval as ulong)
	#define __INTRINSIC_DEFINED___writecr8
#endif

#define __MINGW_FORCE_SYS_INTRINS

declare function __builtin_ia32_crc32qi(byval as ulong, byval as ubyte) as ulong
declare function __builtin_ia32_crc32hi(byval as ulong, byval as ushort) as ulong
declare function __builtin_ia32_crc32si(byval as ulong, byval as ulong) as ulong
declare sub _disable()
declare function __emul(byval as long, byval as long) as longint
declare function __emulu(byval as ulong, byval as ulong) as ulongint
declare sub _enable()

#ifdef __FB_64BIT__
	declare function _InterlockedCompare64Exchange128(byval Destination as longint ptr, byval ExchangeHigh as longint, byval ExchangeLow as longint, byval Comparand as longint) as longint
	declare function _InterlockedCompare64Exchange128_acq(byval Destination as longint ptr, byval ExchangeHigh as longint, byval ExchangeLow as longint, byval Comparand as longint) as longint
	declare function _InterlockedCompare64Exchange128_rel(byval Destination as longint ptr, byval ExchangeHigh as longint, byval ExchangeLow as longint, byval Comparand as longint) as longint
#else
	declare function _InterlockedOr8(byval as zstring ptr, byval as byte) as byte
	declare function _InterlockedOr16(byval as short ptr, byval as short) as short
	declare function _InterlockedXor8(byval as zstring ptr, byval as byte) as byte
	declare function _InterlockedXor16(byval as short ptr, byval as short) as short
	declare function _InterlockedAnd8(byval as zstring ptr, byval as byte) as byte
	declare function _InterlockedAnd16(byval as short ptr, byval as short) as short
	declare function _InterlockedAddLargeStatistic(byval as longint ptr, byval as long) as long
#endif

declare function _inp(byval as ushort) as long
declare function inp_ alias "inp"(byval as ushort) as long
declare function _inpd(byval as ushort) as ulong
declare function inpd(byval as ushort) as ulong
declare function _inpw(byval as ushort) as ushort
declare function inpw(byval as ushort) as ushort
declare function __ll_lshift(byval as ulongint, byval as long) as ulongint
declare function __ll_rshift(byval as longint, byval as long) as longint
declare function _outp(byval as ushort, byval as long) as long
declare function outp(byval as ushort, byval as long) as long
declare function _outpd(byval as ushort, byval as ulong) as ulong
declare function outpd(byval as ushort, byval as ulong) as ulong
declare function _outpw(byval as ushort, byval as ushort) as ushort
declare function outpw(byval as ushort, byval as ushort) as ushort
declare function _ReturnAddress() as any ptr

#define _rotl64_ __rolq
#define _rotr64_ __rorq

declare function __ull_rshift(byval as ulongint, byval as long) as ulongint
declare function _AddressOfReturnAddress() as any ptr
declare sub __wbinvd()
declare sub __invlpg(byval as any ptr)

#ifndef __FB_64BIT__
	declare function __getcallerseflags() as ulong
#endif

declare function __readpmc(byval a as ulong) as ulongint

#ifndef __FB_64BIT__
	declare function __segmentlimit(byval a as ulong) as ulong
	declare function _rotr8(byval value as ubyte, byval shift as ubyte) as ubyte
	declare function _rotr16(byval value as ushort, byval shift as ubyte) as ushort
	declare function _rotl8(byval value as ubyte, byval shift as ubyte) as ubyte
	declare function _rotl16(byval value as ushort, byval shift as ubyte) as ushort
#endif

declare sub __nvreg_save_fence()
declare sub __nvreg_restore_fence()

#ifdef __FB_64BIT__
	declare function _InterlockedCompareExchange16_np(byval Destination as short ptr, byval Exchange as short, byval Comparand as short) as short
	declare function _InterlockedCompareExchange_np(byval as long ptr, byval as long, byval as long) as long
	declare function _InterlockedCompareExchange64_np(byval as longint ptr, byval as longint, byval as longint) as longint
	declare function _InterlockedCompareExchangePointer_np(byval as any ptr ptr, byval as any ptr, byval as any ptr) as any ptr
	declare function _InterlockedCompare64Exchange128_np(byval Destination as longint ptr, byval ExchangeHigh as longint, byval ExchangeLow as longint, byval Comparand as longint) as longint
	declare function _InterlockedCompare64Exchange128_acq_np(byval Destination as longint ptr, byval ExchangeHigh as longint, byval ExchangeLow as longint, byval Comparand as longint) as longint
	declare function _InterlockedCompare64Exchange128_rel_np(byval Destination as longint ptr, byval ExchangeHigh as longint, byval ExchangeLow as longint, byval Comparand as longint) as longint
	declare function _InterlockedAnd_np(byval as long ptr, byval as long) as long
	declare function _InterlockedAnd8_np(byval as zstring ptr, byval as byte) as byte
	declare function _InterlockedAnd16_np(byval as short ptr, byval as short) as short
	declare function _InterlockedAnd64_np(byval as longint ptr, byval as longint) as longint
	declare function _InterlockedOr_np(byval as long ptr, byval as long) as long
	declare function _InterlockedOr8_np(byval as zstring ptr, byval as byte) as byte
	declare function _InterlockedOr16_np(byval as short ptr, byval as short) as short
	declare function _InterlockedOr64_np(byval as longint ptr, byval as longint) as longint
	declare function _InterlockedXor_np(byval as long ptr, byval as long) as long
	declare function _InterlockedXor8_np(byval as zstring ptr, byval as byte) as byte
	declare function _InterlockedXor16_np(byval as short ptr, byval as short) as short
	declare function _InterlockedXor64_np(byval as longint ptr, byval as longint) as longint
#endif

end extern
