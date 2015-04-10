'' FreeBASIC binding for mingw-w64-v3.3.0

#pragma once

#include once "_mingw.bi"

'' The following symbols have been renamed:
''     typedef SIZE_T => SIZE_T_
''     typedef SSIZE_T => SSIZE_T_

extern "C"

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
#define SPOINTER_32 POINTER_SIGNED POINTER_32
#define UPOINTER_32 POINTER_UNSIGNED POINTER_32

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
	#define __int3264 longint
	const ADDRESS_TAG_BIT = &h40000000000ull
	type SHANDLE_PTR as longint
	type HANDLE_PTR as ulongint
	type UHALF_PTR as ulong
	type PUHALF_PTR as ulong ptr
	type HALF_PTR as long
	type PHALF_PTR as long ptr

	private function HandleToULong(byval h as const any ptr) as ulong
		return culng(cast(ULONG_PTR, h))
	end function

	private function HandleToLong(byval h as const any ptr) as long
		return clng(cast(LONG_PTR, h))
	end function

	private function ULongToHandle(byval h as const ulong) as any ptr
		return cptr(any ptr, cast(UINT_PTR, h))
	end function

	private function LongToHandle(byval h as const long) as any ptr
		return cptr(any ptr, cast(INT_PTR, h))
	end function

	private function PtrToUlong(byval p as const any ptr) as ulong
		return culng(cast(ULONG_PTR, p))
	end function

	private function PtrToUint(byval p as const any ptr) as ulong
		return culng(cast(UINT_PTR, p))
	end function

	private function PtrToUshort(byval p as const any ptr) as ushort
		return cushort(culng(cast(ULONG_PTR, p)))
	end function

	private function PtrToLong(byval p as const any ptr) as long
		return clng(cast(LONG_PTR, p))
	end function

	private function PtrToInt(byval p as const any ptr) as long
		return clng(cast(INT_PTR, p))
	end function

	private function PtrToShort(byval p as const any ptr) as short
		return cshort(clng(cast(LONG_PTR, p)))
	end function

	private function IntToPtr(byval i as const long) as any ptr
		return cptr(any ptr, cast(INT_PTR, i))
	end function

	private function UIntToPtr(byval ui as const ulong) as any ptr
		return cptr(any ptr, cast(UINT_PTR, ui))
	end function

	private function LongToPtr(byval l as const long) as any ptr
		return cptr(any ptr, cast(LONG_PTR, l))
	end function

	private function ULongToPtr(byval ul as const ulong) as any ptr
		return cptr(any ptr, cast(ULONG_PTR, ul))
	end function

	#define PtrToPtr64(p) cptr(any ptr, p)
	#define Ptr64ToPtr(p) cptr(any ptr, p)
	#define HandleToHandle64(h) PtrToPtr64(h)
	#define Handle64ToHandle(h) Ptr64ToPtr(h)

	private function Ptr32ToPtr(byval p as const any ptr) as any ptr
		return cptr(any ptr, cast(ULONG_PTR, culng(cast(ULONG_PTR, p))))
	end function

	private function Handle32ToHandle(byval h as const any ptr) as any ptr
		return cptr(any ptr, cast(LONG_PTR, clng(cast(ULONG_PTR, h))))
	end function

	private function PtrToPtr32(byval p as const any ptr) as any ptr
		return cptr(any ptr, cast(ULONG_PTR, culng(cast(ULONG_PTR, p))))
	end function
#else
	type INT_PTR as long
	type PINT_PTR as long ptr
	type UINT_PTR as ulong
	type PUINT_PTR as ulong ptr
	type LONG_PTR as long
	type PLONG_PTR as long ptr
	type ULONG_PTR as ulong
	type PULONG_PTR as ulong ptr
	#define __int3264 long
	#define ADDRESS_TAG_BIT __MSABI_LONG(&h80000000u)
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

	private function PtrToPtr64(byval p as const any ptr) as any ptr
		return cptr(any ptr, cast(ULONG_PTR, p))
	end function

	private function Ptr64ToPtr(byval p as const any ptr) as any ptr
		return cptr(any ptr, cast(ULONG_PTR, p))
	end function

	private function HandleToHandle64(byval h as const any ptr) as any ptr
		return cptr(any ptr, cast(LONG_PTR, h))
	end function

	private function Handle64ToHandle(byval h as const any ptr) as any ptr
		return cptr(any ptr, cast(ULONG_PTR, h))
	end function

	#define Ptr32ToPtr(p) cptr(any ptr, p)
	#define Handle32ToHandle(h) Ptr32ToPtr(h)
	#define PtrToPtr32(p) cptr(any ptr, p)
#endif

#define HandleToHandle32(h) PtrToPtr32(h)
#define MAXUINT_PTR (not cast(UINT_PTR, 0))
#define MAXINT_PTR cast(INT_PTR, MAXUINT_PTR shr 1)
#define MININT_PTR (not MAXINT_PTR)
#define MAXULONG_PTR (not cast(ULONG_PTR, 0))
#define MAXLONG_PTR cast(LONG_PTR, MAXULONG_PTR shr 1)
#define MINLONG_PTR (not MAXLONG_PTR)
#define MAXUHALF_PTR cast(UHALF_PTR, not 0)
#define MAXHALF_PTR cast(HALF_PTR, MAXUHALF_PTR shr 1)
#define MINHALF_PTR (not MAXHALF_PTR)

type SIZE_T_ as ULONG_PTR
type PSIZE_T as ULONG_PTR ptr
type SSIZE_T_ as LONG_PTR
type PSSIZE_T as LONG_PTR ptr

#if _WIN32_WINNT = &h0602
	#define MAXUINT8 cast(UINT8, not cast(UINT8, 0))
	#define MAXINT8 cast(INT8, MAXUINT8 shr 1)
	#define MININT8 cast(INT8, not MAXINT8)
	#define MAXUINT16 cast(UINT16, not cast(UINT16, 0))
	#define MAXINT16 cast(INT16, MAXUINT16 shr 1)
	#define MININT16 cast(INT16, not MAXINT16)
	#define MAXUINT32 cast(UINT32, not cast(UINT32, 0))
	#define MAXINT32 cast(INT32, MAXUINT32 shr 1)
	#define MININT32 cast(INT32, not MAXINT32)
	#define MAXUINT64 cast(UINT64, not cast(UINT64, 0))
	#define MAXINT64 cast(INT64, MAXUINT64 shr 1)
	#define MININT64 cast(INT64, not MAXINT64)
	#define MAXULONG32 cast(ULONG32, not cast(ULONG32, 0))
	#define MAXLONG32 cast(LONG32, MAXULONG32 shr 1)
	#define MINLONG32 cast(LONG32, not MAXLONG32)
	#define MAXULONG64 cast(ULONG64, not cast(ULONG64, 0))
	#define MAXLONG64 cast(LONG64, MAXULONG64 shr 1)
	#define MINLONG64 cast(LONG64, not MAXLONG64)
	#define MAXULONGLONG cast(ULONGLONG, not cast(ULONGLONG, 0))
	#define MINLONGLONG cast(LONGLONG, not MAXLONGLONG)
	#define MAXSIZE_T cast(SIZE_T_, not cast(SIZE_T_, 0))
	#define MAXSSIZE_T cast(SSIZE_T_, MAXSIZE_T shr 1)
	#define MINSSIZE_T cast(SSIZE_T_, not MAXSSIZE_T)
	#define MAXUINT cast(UINT, not cast(UINT, 0))
	#define MAXINT cast(INT_, MAXUINT shr 1)
	#define MININT cast(INT_, not MAXINT)
	#define MAXDWORD32 cast(DWORD32, not cast(DWORD32, 0))
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

end extern
