''
''
'' basetyps -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_basetyps_bi__
#define __win_basetyps_bi__

#define STDMETHOD(m) m as function
#define PURE
#define THIS_ INTERFACE ptr,
#define THIS INTERFACE ptr
#define DECLARE_INTERFACE(i) 		_
	type ##i##Vtbl_ as ##i##Vtbl	:_
	type i							:_
		lpVtbl as ##i##Vtbl_ ptr	: _
	end type						:_
	type ##i##Vtbl
#define DECLARE_INTERFACE_(i,b) DECLARE_INTERFACE(i)
#define BEGIN_INTERFACE
#define END_INTERFACE

#ifndef GUID
type GUID
    Data1 as uinteger
    Data2 as ushort 
    Data3 as ushort 
    Data4(0 to 8-1) as ubyte
end type

type REFGUID as GUID ptr
type LPGUID as GUID ptr
#endif

type UUID as GUID
type IID as GUID
type CLSID as GUID
type LPCLSID as CLSID ptr
type LPIID as IID ptr
type REFIID as IID ptr
type REFCLSID as CLSID ptr
type FMTID as GUID
type REFFMTID as FMTID ptr
type error_status_t as uinteger
type PROPID as uinteger

#ifdef INITGUID
#define DEFINE_GUID(n,l,w1,w2,b1,b2,b3,b4,b5,b6,b7,b8) extern n alias #n as GUID :_
													   dim n as GUID = (l,w1,w2,{b1,b2,b3,b4,b5,b6,b7,b8})
#define DEFINE_OLEGUID(n,l,w1,w2) DEFINE_GUID(n,l,w1,w2,&hC0,0,0,0,0,0,0,&h46)
#else
#define DEFINE_GUID(n,l,w1,w2,b1,b2,b3,b4,b5,b6,b7,b8) extern n alias #n as GUID
#define DEFINE_OLEGUID(n,l,w1,w2) DEFINE_GUID(n,l,w1,w2,&hC0,0,0,0,0,0,0,&h46)
#endif

#endif
