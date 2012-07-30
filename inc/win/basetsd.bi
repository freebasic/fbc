''
''
'' basetsd -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_basetsd_bi__
#define __win_basetsd_bi__

#define ADDRESS_TAG_BIT &h80000000UL

#define HandleToUlong( h ) cuint( h )
#define HandleToLong( h ) cint( h )
#define LongToHandle( h) cptr( HANDLE, cint( h ) )
#define PtrToUlong( p ) cuint( p )
#define PtrToLong( p ) cint( p )
#define PtrToUint( p ) cuint( p )
#define PtrToInt( p ) cint( p )
#define PtrToUshort( p ) cushort( p )
#define PtrToShort( p ) cshort( p )
#define IntToPtr( i ) cptr( VOID ptr, cint(i) )
#define UIntToPtr( ui ) cptr( VOID ptr, cuint(ui) )
#define LongToPtr( l ) cptr( VOID ptr, cint(l) )
#define ULongToPtr( ul ) cptr( VOID ptr, cuint(ul) )

type LONG32 as integer
type PLONG32 as integer ptr
type INT32 as integer
type PINT32 as integer ptr
type ULONG32 as uinteger
type PULONG32 as uinteger ptr
type DWORD32 as uinteger
type PDWORD32 as uinteger ptr
type UINT32 as uinteger
type PUINT32 as uinteger ptr
type INT_PTR as integer
type PINT_PTR as integer ptr
type UINT_PTR as uinteger
type PUINT_PTR as uinteger ptr
type LONG_PTR as integer
type PLONG_PTR as integer ptr
type ULONG_PTR as uinteger
type PULONG_PTR as uinteger ptr
type UHALF_PTR as ushort
type PUHALF_PTR as ushort ptr
type HALF_PTR as short
type PHALF_PTR as short ptr
type HANDLE_PTR as uinteger
#ifndef SIZE_T
type SIZE_T as ULONG_PTR
#endif
type PSIZE_T as ULONG_PTR ptr
type SSIZE_T as LONG_PTR
type PSSIZE_T as LONG_PTR ptr
type DWORD_PTR as ULONG_PTR
type PDWORD_PTR as ULONG_PTR ptr
type LONG64 as longint
type PLONG64 as longint ptr
type INT64 as longint
type PINT64 as longint ptr
type ULONG64 as ulongint
type PULONG64 as ulongint ptr
type DWORD64 as ulongint
type PDWORD64 as ulongint ptr
type UINT64 as ulongint
type PUINT64 as ulongint ptr

#endif
