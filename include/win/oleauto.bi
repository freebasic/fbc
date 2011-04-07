''
''
'' oleauto -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_oleauto_bi__
#define __win_oleauto_bi__

#inclib "oleaut32"

#define STDOLE_MAJORVERNUM 1
#define STDOLE_MINORVERNUM 0
#define STDOLE_LCID 0
#define VARIANT_NOVALUEPROP &h01
#define VARIANT_ALPHABOOL &h02
#define VARIANT_NOUSEOVERRIDE &h04
#define VARIANT_LOCALBOOL &h08
#define VAR_TIMEVALUEONLY &h0001
#define VAR_DATEVALUEONLY &h0002
#define MEMBERID_NIL DISPID_UNKNOWN
#define VAR_VALIDDATE &h0004
#define VAR_CALENDAR_HIJRI &h0008
#define VAR_LOCALBOOL &h0010
#define VAR_FORMAT_NOSUBSTITUTE &h0020
#define VAR_FOURDIGITYEARS &h0040
#define VAR_CALENDAR_THAI &h0080
#define VAR_CALENDAR_GREGORIAN &h0100
#define ID_DEFAULTINST (-2)
#define DISPATCH_METHOD 1
#define DISPATCH_PROPERTYGET 2
#define DISPATCH_PROPERTYPUT 4
#define DISPATCH_PROPERTYPUTREF 8
#define LHashValOfName(l,n) LHashValOfNameSys(SYS_WIN32,l,n)
#define WHashValOfLHashVal(h) cushort(&h0000ffff and (h))
#define IsHashValCompatible(h1,h2) cint((&h00ff0000 and (h1)) = (&h00ff0000 and (h2)))
#define ACTIVEOBJECT_STRONG 0
#define ACTIVEOBJECT_WEAK 1
#define VARCMP_LT 0
#define VARCMP_EQ 1
#define VARCMP_GT 2
#define VARCMP_NULL 3
#define LOCALE_USE_NLS &h10000000
#define VARIANT_NOUSEROVERRIDE &h04
#define VARIANT_CALENDAR_HIJRI &h08
#define VARIANT_CALENDAR_THAI &h20
#define VARIANT_CALENDAR_GREGORIAN &h40
#define VARIANT_USE_NLS &h80
#define NUMPRS_LEADING_WHITE &h00001
#define NUMPRS_TRAILING_WHITE &h00002
#define NUMPRS_LEADING_PLUS &h00004
#define NUMPRS_TRAILING_PLUS &h00008
#define NUMPRS_LEADING_MINUS &h00010
#define NUMPRS_TRAILING_MINUS &h00020
#define NUMPRS_HEX_OCT &h00040
#define NUMPRS_PARENS &h00080
#define NUMPRS_DECIMAL &h00100
#define NUMPRS_THOUSANDS &h00200
#define NUMPRS_CURRENCY &h00400
#define NUMPRS_EXPONENT &h00800
#define NUMPRS_USE_ALL &h01000
#define NUMPRS_STD &h01FFF
#define NUMPRS_NEG &h10000
#define NUMPRS_INEXACT &h20000

#define V_UNION(X,Y) ((X)->Y)
#define V_VT(X) ((X)->vt)
#define V_BOOL(X) V_UNION(X,boolVal)
#define V_ISBYREF(X) (V_VT(X) and VT_BYREF)
#define V_ISARRAY(X) (V_VT(X) and VT_ARRAY)
#define V_ISVECTOR(X) (V_VT(X) and VT_VECTOR)
#define V_NONE(X) V_I2(X)
#define V_UI1(X) V_UNION(X,bVal)
#define V_UI1REF(X) V_UNION(X,pbVal)
#define V_I2(X) V_UNION(X,iVal)
#define V_UI2(X) V_UNION(X,uiVal)
#define V_I2REF(X) V_UNION(X,piVal)
#define V_I4(X) V_UNION(X,lVal)
#define V_UI4(X) V_UNION(X,ulVal)
#define V_I4REF(X) V_UNION(X,plVal)
#define V_UI4REF(X) V_UNION(X,pulVal)
#define V_I8(X) V_UNION(X,llVal)
#define V_UI8(X) V_UNION(X,ullVal)
#define V_I8REF(X) V_UNION(X,pllVal)
#define V_UI8REF(X) V_UNION(X,pullVal)
#define V_R4(X) V_UNION(X,fltVal)
#define V_R4REF(X) V_UNION(X,pfltVal)
#define V_R8(X) V_UNION(X,dblVal)
#define V_R8REF(X) V_UNION(X,pdblVal)
#define V_CY(X) V_UNION(X,cyVal)
#define V_CYREF(X) V_UNION(X,pcyVal)
#define V_DATE(X) V_UNION(X,date)
#define V_DATEREF(X) V_UNION(X,pdate)
#define V_BSTR(X) V_UNION(X,bstrVal)
#define V_BSTRREF(X) V_UNION(X,pbstrVal)
#define V_DISPATCH(X) V_UNION(X,pdispVal)
#define V_DISPATCHREF(X) V_UNION(X,ppdispVal)
#define V_ERROR(X) V_UNION(X,scode)
#define V_ERRORREF(X) V_UNION(X,pscode)
#define V_BOOLREF(X) V_UNION(X,pboolVal)
#define V_UNKNOWN(X) V_UNION(X,punkVal)
#define V_UNKNOWNREF(X) V_UNION(X,ppunkVal)
#define V_VARIANTREF(X) V_UNION(X,pvarVal)
#define V_LPSTR(X) V_UNION(X,pszVal)
#define V_LPSTRREF(X) V_UNION(X,ppszVal)
#define V_LPWSTR(X) V_UNION(X,pwszVal)
#define V_LPWSTRREF(X) V_UNION(X,ppwszVal)
#define V_FILETIME(X) V_UNION(X,filetime)
#define V_FILETIMEREF(X) V_UNION(X,pfiletime)
#define V_BLOB(X) V_UNION(X,blob)
#define V_UUID(X) V_UNION(X,puuid)
#define V_CLSID(X) V_UNION(X,puuid)
#define V_ARRAY(X) V_UNION(X,parray)
#define V_ARRAYREF(X) V_UNION(X,pparray)
#define V_BYREF(X) V_UNION(X,byref)
#define V_DECIMAL(X) V_UNION(X,decVal)
#define V_DECIMALREF(X) V_UNION(X,pdecVal)
#define V_I1(X) V_UNION(X,cVal)

#include once "win/oaidl.bi"

enum REGKIND
	REGKIND_DEFAULT
	REGKIND_REGISTER
	REGKIND_NONE
end enum

type PARAMDATA
	szName as OLECHAR ptr
	vt as VARTYPE
end type

type LPPARAMDATA as PARAMDATA ptr

type METHODDATA
	szName as OLECHAR ptr
	ppdata as PARAMDATA ptr
	dispid as DISPID
	iMeth as UINT
	cc as CALLCONV
	cArgs as UINT
	wFlags as WORD
	vtReturn as VARTYPE
end type

type LPMETHODDATA as METHODDATA ptr

type INTERFACEDATA
	pmethdata as METHODDATA ptr
	cMembers as UINT
end type

type LPINTERFACEDATA as INTERFACEDATA ptr
type UDATE
	st as SYSTEMTIME
	wDayOfYear as USHORT
end type

type NUMPARSE
	cDig as integer
	dwInFlags as uinteger
	dwOutFlags as uinteger
	cchUsed as integer
	nBaseShift as integer
	nPwr10 as integer
end type


declare function SysAllocString alias "SysAllocString" (byval as OLECHAR ptr) as BSTR
declare function SysReAllocString alias "SysReAllocString" (byval as BSTR ptr, byval as OLECHAR ptr) as integer
declare function SysAllocStringLen alias "SysAllocStringLen" (byval as OLECHAR ptr, byval as uinteger) as BSTR
declare function SysReAllocStringLen alias "SysReAllocStringLen" (byval as BSTR ptr, byval as OLECHAR ptr, byval as uinteger) as integer
declare sub SysFreeString alias "SysFreeString" (byval as BSTR)
declare function SysStringLen alias "SysStringLen" (byval as BSTR) as uinteger
declare function SysStringByteLen alias "SysStringByteLen" (byval as BSTR) as uinteger
declare function SysAllocStringByteLen alias "SysAllocStringByteLen" (byval as zstring ptr, byval as uinteger) as BSTR
declare function DosDateTimeToVariantTime alias "DosDateTimeToVariantTime" (byval as ushort, byval as ushort, byval as double ptr) as integer
declare function VariantTimeToDosDateTime alias "VariantTimeToDosDateTime" (byval as double, byval as ushort ptr, byval as ushort ptr) as integer
declare function VariantTimeToSystemTime alias "VariantTimeToSystemTime" (byval as double, byval as LPSYSTEMTIME) as integer
declare function SystemTimeToVariantTime alias "SystemTimeToVariantTime" (byval as LPSYSTEMTIME, byval as double ptr) as integer
declare function VarDateFromUdate alias "VarDateFromUdate" (byval as UDATE ptr, byval as ULONG, byval as DATE_ ptr) as HRESULT
declare function VarDateFromUdateEx alias "VarDateFromUdateEx" (byval as UDATE ptr, byval as LCID, byval as ULONG, byval as DATE_ ptr) as HRESULT
declare function VarUdateFromDate alias "VarUdateFromDate" (byval as DATE_, byval as ULONG, byval as UDATE ptr) as HRESULT
declare function SafeArrayAllocDescriptor alias "SafeArrayAllocDescriptor" (byval as uinteger, byval as SAFEARRAY ptr ptr) as HRESULT
declare function SafeArrayAllocData alias "SafeArrayAllocData" (byval as SAFEARRAY ptr) as HRESULT
declare function SafeArrayCreate alias "SafeArrayCreate" (byval as VARTYPE, byval as uinteger, byval as SAFEARRAYBOUND ptr) as SAFEARRAY ptr
declare function SafeArrayDestroyDescriptor alias "SafeArrayDestroyDescriptor" (byval as SAFEARRAY ptr) as HRESULT
declare function SafeArrayDestroyData alias "SafeArrayDestroyData" (byval as SAFEARRAY ptr) as HRESULT
declare function SafeArrayDestroy alias "SafeArrayDestroy" (byval as SAFEARRAY ptr) as HRESULT
declare function SafeArrayRedim alias "SafeArrayRedim" (byval as SAFEARRAY ptr, byval as SAFEARRAYBOUND ptr) as HRESULT
declare function SafeArrayGetDim alias "SafeArrayGetDim" (byval as SAFEARRAY ptr) as uinteger
declare function SafeArrayGetElemsize alias "SafeArrayGetElemsize" (byval as SAFEARRAY ptr) as uinteger
declare function SafeArrayGetUBound alias "SafeArrayGetUBound" (byval as SAFEARRAY ptr, byval as uinteger, byval as integer ptr) as HRESULT
declare function SafeArrayGetLBound alias "SafeArrayGetLBound" (byval as SAFEARRAY ptr, byval as uinteger, byval as integer ptr) as HRESULT
declare function SafeArrayLock alias "SafeArrayLock" (byval as SAFEARRAY ptr) as HRESULT
declare function SafeArrayUnlock alias "SafeArrayUnlock" (byval as SAFEARRAY ptr) as HRESULT
declare function SafeArrayAccessData alias "SafeArrayAccessData" (byval as SAFEARRAY ptr, byval as any ptr ptr) as HRESULT
declare function SafeArrayUnaccessData alias "SafeArrayUnaccessData" (byval as SAFEARRAY ptr) as HRESULT
declare function SafeArrayGetElement alias "SafeArrayGetElement" (byval as SAFEARRAY ptr, byval as integer ptr, byval as any ptr) as HRESULT
declare function SafeArrayPutElement alias "SafeArrayPutElement" (byval as SAFEARRAY ptr, byval as integer ptr, byval as any ptr) as HRESULT
declare function SafeArrayCopy alias "SafeArrayCopy" (byval as SAFEARRAY ptr, byval as SAFEARRAY ptr ptr) as HRESULT
declare function SafeArrayPtrOfIndex alias "SafeArrayPtrOfIndex" (byval as SAFEARRAY ptr, byval as integer ptr, byval as any ptr ptr) as HRESULT
declare function SafeArrayCreateVector alias "SafeArrayCreateVector" (byval as VARTYPE, byval as LONG, byval as ULONG) as SAFEARRAY ptr
declare function SafeArrayCreateVectorEx alias "SafeArrayCreateVectorEx" (byval as VARTYPE, byval as LONG, byval as ULONG, byval as LPVOID) as SAFEARRAY ptr
declare function SafeArrayAllocDescriptorEx alias "SafeArrayAllocDescriptorEx" (byval as VARTYPE, byval as UINT, byval as SAFEARRAY ptr ptr) as HRESULT
declare function SafeArrayGetVartype alias "SafeArrayGetVartype" (byval as SAFEARRAY ptr, byval as VARTYPE ptr) as HRESULT
declare function SafeArraySetRecordInfo alias "SafeArraySetRecordInfo" (byval as SAFEARRAY ptr, byval as IRecordInfo ptr) as HRESULT
declare function SafeArrayGetRecordInfo alias "SafeArrayGetRecordInfo" (byval as SAFEARRAY ptr, byval as IRecordInfo ptr ptr) as HRESULT
declare function SafeArraySetIID alias "SafeArraySetIID" (byval as SAFEARRAY ptr, byval as GUID ptr) as HRESULT
declare function SafeArrayGetIID alias "SafeArrayGetIID" (byval as SAFEARRAY ptr, byval as GUID ptr) as HRESULT
declare sub VariantInit alias "VariantInit" (byval as VARIANTARG ptr)
declare function VariantClear alias "VariantClear" (byval as VARIANTARG ptr) as HRESULT
declare function VariantCopy alias "VariantCopy" (byval as VARIANTARG ptr, byval as VARIANTARG ptr) as HRESULT
declare function VariantCopyInd alias "VariantCopyInd" (byval as VARIANT_ ptr, byval as VARIANTARG ptr) as HRESULT
declare function VariantChangeType alias "VariantChangeType" (byval as VARIANTARG ptr, byval as VARIANTARG ptr, byval as ushort, byval as VARTYPE) as HRESULT
declare function VariantChangeTypeEx alias "VariantChangeTypeEx" (byval as VARIANTARG ptr, byval as VARIANTARG ptr, byval as LCID, byval as ushort, byval as VARTYPE) as HRESULT
declare function VarUI1FromI2 alias "VarUI1FromI2" (byval as SHORT, byval as UBYTE ptr) as HRESULT
declare function VarUI1FromI4 alias "VarUI1FromI4" (byval as LONG, byval as UBYTE ptr) as HRESULT
declare function VarUI1FromI8 alias "VarUI1FromI8" (byval as LONG64, byval as UBYTE ptr) as HRESULT
declare function VarUI1FromR4 alias "VarUI1FromR4" (byval as FLOAT, byval as UBYTE ptr) as HRESULT
declare function VarUI1FromR8 alias "VarUI1FromR8" (byval as DOUBLE, byval as UBYTE ptr) as HRESULT
declare function VarUI1FromDate alias "VarUI1FromDate" (byval as DATE_, byval as UBYTE ptr) as HRESULT
declare function VarUI1FromBool alias "VarUI1FromBool" (byval as VARIANT_BOOL, byval as UBYTE ptr) as HRESULT
declare function VarUI1FromI1 alias "VarUI1FromI1" (byval as byte, byval as UBYTE ptr) as HRESULT
declare function VarUI1FromUI2 alias "VarUI1FromUI2" (byval as USHORT, byval as UBYTE ptr) as HRESULT
declare function VarUI1FromUI4 alias "VarUI1FromUI4" (byval as ULONG, byval as UBYTE ptr) as HRESULT
declare function VarUI1FromUI8 alias "VarUI1FromUI8" (byval as ULONG64, byval as UBYTE ptr) as HRESULT
declare function VarUI1FromStr alias "VarUI1FromStr" (byval as OLECHAR ptr, byval as LCID, byval as ULONG, byval as UBYTE ptr) as HRESULT
declare function VarUI1FromCy alias "VarUI1FromCy" (byval as CY, byval as UBYTE ptr) as HRESULT
declare function VarUI1FromDec alias "VarUI1FromDec" (byval as DECIMAL ptr, byval as UBYTE ptr) as HRESULT
declare function VarUI1FromDisp alias "VarUI1FromDisp" (byval as IDispatch ptr, byval as LCID, byval as UBYTE ptr) as HRESULT
declare function VarI2FromUI1 alias "VarI2FromUI1" (byval as UBYTE, byval as SHORT ptr) as HRESULT
declare function VarI2FromI4 alias "VarI2FromI4" (byval as LONG, byval as SHORT ptr) as HRESULT
declare function VarI2FromI8 alias "VarI2FromI8" (byval as LONG64, byval as SHORT ptr) as HRESULT
declare function VarI2FromR4 alias "VarI2FromR4" (byval as FLOAT, byval as SHORT ptr) as HRESULT
declare function VarI2FromR8 alias "VarI2FromR8" (byval as DOUBLE, byval as SHORT ptr) as HRESULT
declare function VarI2FromDate alias "VarI2FromDate" (byval as DATE_, byval as SHORT ptr) as HRESULT
declare function VarI2FromBool alias "VarI2FromBool" (byval as VARIANT_BOOL, byval as SHORT ptr) as HRESULT
declare function VarI2FromI1 alias "VarI2FromI1" (byval as byte, byval as SHORT ptr) as HRESULT
declare function VarI2FromUI2 alias "VarI2FromUI2" (byval as USHORT, byval as SHORT ptr) as HRESULT
declare function VarI2FromUI4 alias "VarI2FromUI4" (byval as ULONG, byval as SHORT ptr) as HRESULT
declare function VarI2FromUI8 alias "VarI2FromUI8" (byval as ULONG64, byval as SHORT ptr) as HRESULT
declare function VarI2FromStr alias "VarI2FromStr" (byval as OLECHAR ptr, byval as LCID, byval as ULONG, byval as SHORT ptr) as HRESULT
declare function VarI2FromCy alias "VarI2FromCy" (byval as CY, byval as SHORT ptr) as HRESULT
declare function VarI2FromDec alias "VarI2FromDec" (byval as DECIMAL ptr, byval as SHORT ptr) as HRESULT
declare function VarI2FromDisp alias "VarI2FromDisp" (byval as IDispatch ptr, byval as LCID, byval as SHORT ptr) as HRESULT
declare function VarI4FromUI1 alias "VarI4FromUI1" (byval as UBYTE, byval as LONG ptr) as HRESULT
declare function VarI4FromI2 alias "VarI4FromI2" (byval as SHORT, byval as LONG ptr) as HRESULT
declare function VarI4FromI8 alias "VarI4FromI8" (byval as LONG64, byval as LONG ptr) as HRESULT
declare function VarI4FromR4 alias "VarI4FromR4" (byval as FLOAT, byval as LONG ptr) as HRESULT
declare function VarI4FromR8 alias "VarI4FromR8" (byval as DOUBLE, byval as LONG ptr) as HRESULT
declare function VarI4FromDate alias "VarI4FromDate" (byval as DATE_, byval as LONG ptr) as HRESULT
declare function VarI4FromBool alias "VarI4FromBool" (byval as VARIANT_BOOL, byval as LONG ptr) as HRESULT
declare function VarI4FromI1 alias "VarI4FromI1" (byval as byte, byval as LONG ptr) as HRESULT
declare function VarI4FromUI2 alias "VarI4FromUI2" (byval as USHORT, byval as LONG ptr) as HRESULT
declare function VarI4FromUI4 alias "VarI4FromUI4" (byval as ULONG, byval as LONG ptr) as HRESULT
declare function VarI4FromUI8 alias "VarI4FromUI8" (byval as ULONG64, byval as LONG ptr) as HRESULT
declare function VarI4FromStr alias "VarI4FromStr" (byval as OLECHAR ptr, byval as LCID, byval as ULONG, byval as LONG ptr) as HRESULT
declare function VarI4FromCy alias "VarI4FromCy" (byval as CY, byval as LONG ptr) as HRESULT
declare function VarI4FromDec alias "VarI4FromDec" (byval as DECIMAL ptr, byval as LONG ptr) as HRESULT
declare function VarI4FromDisp alias "VarI4FromDisp" (byval as IDispatch ptr, byval as LCID, byval as LONG ptr) as HRESULT
declare function VarR4FromUI1 alias "VarR4FromUI1" (byval as UBYTE, byval as FLOAT ptr) as HRESULT
declare function VarR4FromI2 alias "VarR4FromI2" (byval as SHORT, byval as FLOAT ptr) as HRESULT
declare function VarR4FromI4 alias "VarR4FromI4" (byval as LONG, byval as FLOAT ptr) as HRESULT
declare function VarR4FromI8 alias "VarR4FromI8" (byval as LONG64, byval as FLOAT ptr) as HRESULT
declare function VarR4FromR8 alias "VarR4FromR8" (byval as DOUBLE, byval as FLOAT ptr) as HRESULT
declare function VarR4FromDate alias "VarR4FromDate" (byval as DATE_, byval as FLOAT ptr) as HRESULT
declare function VarR4FromBool alias "VarR4FromBool" (byval as VARIANT_BOOL, byval as FLOAT ptr) as HRESULT
declare function VarR4FromI1 alias "VarR4FromI1" (byval as byte, byval as FLOAT ptr) as HRESULT
declare function VarR4FromUI2 alias "VarR4FromUI2" (byval as USHORT, byval as FLOAT ptr) as HRESULT
declare function VarR4FromUI4 alias "VarR4FromUI4" (byval as ULONG, byval as FLOAT ptr) as HRESULT
declare function VarR4FromUI8 alias "VarR4FromUI8" (byval as ULONG64, byval as FLOAT ptr) as HRESULT
declare function VarR4FromStr alias "VarR4FromStr" (byval as OLECHAR ptr, byval as LCID, byval as ULONG, byval as FLOAT ptr) as HRESULT
declare function VarR4FromCy alias "VarR4FromCy" (byval as CY, byval as FLOAT ptr) as HRESULT
declare function VarR4FromDec alias "VarR4FromDec" (byval as DECIMAL ptr, byval as FLOAT ptr) as HRESULT
declare function VarR4FromDisp alias "VarR4FromDisp" (byval as IDispatch ptr, byval as LCID, byval as FLOAT ptr) as HRESULT
declare function VarR8FromUI1 alias "VarR8FromUI1" (byval as UBYTE, byval as double ptr) as HRESULT
declare function VarR8FromI2 alias "VarR8FromI2" (byval as SHORT, byval as double ptr) as HRESULT
declare function VarR8FromI4 alias "VarR8FromI4" (byval as LONG, byval as double ptr) as HRESULT
declare function VarR8FromI8 alias "VarR8FromI8" (byval as LONG64, byval as double ptr) as HRESULT
declare function VarR8FromR4 alias "VarR8FromR4" (byval as FLOAT, byval as double ptr) as HRESULT
declare function VarR8FromDate alias "VarR8FromDate" (byval as DATE_, byval as double ptr) as HRESULT
declare function VarR8FromBool alias "VarR8FromBool" (byval as VARIANT_BOOL, byval as double ptr) as HRESULT
declare function VarR8FromI1 alias "VarR8FromI1" (byval as byte, byval as double ptr) as HRESULT
declare function VarR8FromUI2 alias "VarR8FromUI2" (byval as USHORT, byval as double ptr) as HRESULT
declare function VarR8FromUI4 alias "VarR8FromUI4" (byval as ULONG, byval as double ptr) as HRESULT
declare function VarR8FromUI8 alias "VarR8FromUI8" (byval as ULONG64, byval as double ptr) as HRESULT
declare function VarR8FromStr alias "VarR8FromStr" (byval as OLECHAR ptr, byval as LCID, byval as ULONG, byval as double ptr) as HRESULT
declare function VarR8FromCy alias "VarR8FromCy" (byval as CY, byval as double ptr) as HRESULT
declare function VarR8FromDec alias "VarR8FromDec" (byval as DECIMAL ptr, byval as double ptr) as HRESULT
declare function VarR8FromDisp alias "VarR8FromDisp" (byval as IDispatch ptr, byval as LCID, byval as double ptr) as HRESULT
declare function VarDateFromUI1 alias "VarDateFromUI1" (byval as UBYTE, byval as DATE_ ptr) as HRESULT
declare function VarDateFromI2 alias "VarDateFromI2" (byval as SHORT, byval as DATE_ ptr) as HRESULT
declare function VarDateFromI4 alias "VarDateFromI4" (byval as LONG, byval as DATE_ ptr) as HRESULT
declare function VarDateFromI8 alias "VarDateFromI8" (byval as LONG64, byval as DATE_ ptr) as HRESULT
declare function VarDateFromR4 alias "VarDateFromR4" (byval as FLOAT, byval as DATE_ ptr) as HRESULT
declare function VarDateFromR8 alias "VarDateFromR8" (byval as DOUBLE, byval as DATE_ ptr) as HRESULT
declare function VarDateFromStr alias "VarDateFromStr" (byval as OLECHAR ptr, byval as LCID, byval as ULONG, byval as DATE_ ptr) as HRESULT
declare function VarDateFromI1 alias "VarDateFromI1" (byval as byte, byval as DATE_ ptr) as HRESULT
declare function VarDateFromUI2 alias "VarDateFromUI2" (byval as USHORT, byval as DATE_ ptr) as HRESULT
declare function VarDateFromUI4 alias "VarDateFromUI4" (byval as ULONG, byval as DATE_ ptr) as HRESULT
declare function VarDateFromUI8 alias "VarDateFromUI8" (byval as ULONG64, byval as DATE_ ptr) as HRESULT
declare function VarDateFromBool alias "VarDateFromBool" (byval as VARIANT_BOOL, byval as DATE_ ptr) as HRESULT
declare function VarDateFromCy alias "VarDateFromCy" (byval as CY, byval as DATE_ ptr) as HRESULT
declare function VarDateFromDec alias "VarDateFromDec" (byval as DECIMAL ptr, byval as DATE_ ptr) as HRESULT
declare function VarDateFromDisp alias "VarDateFromDisp" (byval as IDispatch ptr, byval as LCID, byval as DATE_ ptr) as HRESULT
declare function VarCyFromUI1 alias "VarCyFromUI1" (byval as UBYTE, byval as CY ptr) as HRESULT
declare function VarCyFromI2 alias "VarCyFromI2" (byval sIn as SHORT, byval as CY ptr) as HRESULT
declare function VarCyFromI4 alias "VarCyFromI4" (byval as LONG, byval as CY ptr) as HRESULT
declare function VarCyFromI8 alias "VarCyFromI8" (byval as LONG64, byval as CY ptr) as HRESULT
declare function VarCyFromR4 alias "VarCyFromR4" (byval as FLOAT, byval as CY ptr) as HRESULT
declare function VarCyFromR8 alias "VarCyFromR8" (byval as DOUBLE, byval as CY ptr) as HRESULT
declare function VarCyFromDate alias "VarCyFromDate" (byval as DATE_, byval as CY ptr) as HRESULT
declare function VarCyFromBool alias "VarCyFromBool" (byval as VARIANT_BOOL, byval as CY ptr) as HRESULT
declare function VarCyFromI1 alias "VarCyFromI1" (byval as byte, byval as CY ptr) as HRESULT
declare function VarCyFromUI2 alias "VarCyFromUI2" (byval as USHORT, byval as CY ptr) as HRESULT
declare function VarCyFromUI4 alias "VarCyFromUI4" (byval as ULONG, byval as CY ptr) as HRESULT
declare function VarCyFromUI8 alias "VarCyFromUI8" (byval as ULONG64, byval as CY ptr) as HRESULT
declare function VarCyFromDec alias "VarCyFromDec" (byval as DECIMAL ptr, byval as CY ptr) as HRESULT
declare function VarCyFromStr alias "VarCyFromStr" (byval as OLECHAR ptr, byval as LCID, byval as ULONG, byval as CY ptr) as HRESULT
declare function VarCyFromDisp alias "VarCyFromDisp" (byval as IDispatch ptr, byval as LCID, byval as CY ptr) as HRESULT
declare function VarBstrFromUI1 alias "VarBstrFromUI1" (byval as UBYTE, byval as LCID, byval as ULONG, byval as BSTR ptr) as HRESULT
declare function VarBstrFromI2 alias "VarBstrFromI2" (byval as SHORT, byval as LCID, byval as ULONG, byval as BSTR ptr) as HRESULT
declare function VarBstrFromI4 alias "VarBstrFromI4" (byval as LONG, byval as LCID, byval as ULONG, byval as BSTR ptr) as HRESULT
declare function VarBstrFromI8 alias "VarBstrFromI8" (byval as LONG64, byval as LCID, byval as ULONG, byval as BSTR ptr) as HRESULT
declare function VarBstrFromR4 alias "VarBstrFromR4" (byval as FLOAT, byval as LCID, byval as ULONG, byval as BSTR ptr) as HRESULT
declare function VarBstrFromR8 alias "VarBstrFromR8" (byval as DOUBLE, byval as LCID, byval as ULONG, byval as BSTR ptr) as HRESULT
declare function VarBstrFromDate alias "VarBstrFromDate" (byval as DATE_, byval as LCID, byval as ULONG, byval as BSTR ptr) as HRESULT
declare function VarBstrFromBool alias "VarBstrFromBool" (byval as VARIANT_BOOL, byval as LCID, byval as ULONG, byval as BSTR ptr) as HRESULT
declare function VarBstrFromI1 alias "VarBstrFromI1" (byval as byte, byval as LCID, byval as ULONG, byval as BSTR ptr) as HRESULT
declare function VarBstrFromUI2 alias "VarBstrFromUI2" (byval as USHORT, byval as LCID, byval as ULONG, byval as BSTR ptr) as HRESULT
declare function VarBstrFromUI8 alias "VarBstrFromUI8" (byval as ULONG64, byval as LCID, byval as ULONG, byval as BSTR ptr) as HRESULT
declare function VarBstrFromUI4 alias "VarBstrFromUI4" (byval as ULONG, byval as LCID, byval as ULONG, byval as BSTR ptr) as HRESULT
declare function VarBstrFromCy alias "VarBstrFromCy" (byval as CY, byval as LCID, byval as ULONG, byval as BSTR ptr) as HRESULT
declare function VarBstrFromDec alias "VarBstrFromDec" (byval as DECIMAL ptr, byval as LCID, byval as ULONG, byval as BSTR ptr) as HRESULT
declare function VarBstrFromDisp alias "VarBstrFromDisp" (byval as IDispatch ptr, byval as LCID, byval as ULONG, byval as BSTR ptr) as HRESULT
declare function VarBoolFromUI1 alias "VarBoolFromUI1" (byval as UBYTE, byval as VARIANT_BOOL ptr) as HRESULT
declare function VarBoolFromI2 alias "VarBoolFromI2" (byval as SHORT, byval as VARIANT_BOOL ptr) as HRESULT
declare function VarBoolFromI4 alias "VarBoolFromI4" (byval as LONG, byval as VARIANT_BOOL ptr) as HRESULT
declare function VarBoolFromI8 alias "VarBoolFromI8" (byval as LONG64, byval as VARIANT_BOOL ptr) as HRESULT
declare function VarBoolFromR4 alias "VarBoolFromR4" (byval as FLOAT, byval as VARIANT_BOOL ptr) as HRESULT
declare function VarBoolFromR8 alias "VarBoolFromR8" (byval as DOUBLE, byval as VARIANT_BOOL ptr) as HRESULT
declare function VarBoolFromDate alias "VarBoolFromDate" (byval as DATE_, byval as VARIANT_BOOL ptr) as HRESULT
declare function VarBoolFromStr alias "VarBoolFromStr" (byval as OLECHAR ptr, byval as LCID, byval as ULONG, byval as VARIANT_BOOL ptr) as HRESULT
declare function VarBoolFromI1 alias "VarBoolFromI1" (byval as byte, byval as VARIANT_BOOL ptr) as HRESULT
declare function VarBoolFromUI2 alias "VarBoolFromUI2" (byval as USHORT, byval as VARIANT_BOOL ptr) as HRESULT
declare function VarBoolFromUI4 alias "VarBoolFromUI4" (byval as ULONG, byval as VARIANT_BOOL ptr) as HRESULT
declare function VarBoolFromUI8 alias "VarBoolFromUI8" (byval as ULONG64, byval as VARIANT_BOOL ptr) as HRESULT
declare function VarBoolFromCy alias "VarBoolFromCy" (byval as CY, byval as VARIANT_BOOL ptr) as HRESULT
declare function VarBoolFromDec alias "VarBoolFromDec" (byval as DECIMAL ptr, byval as VARIANT_BOOL ptr) as HRESULT
declare function VarBoolFromDisp alias "VarBoolFromDisp" (byval as IDispatch ptr, byval as LCID, byval as VARIANT_BOOL ptr) as HRESULT
declare function LHashValOfNameSysA alias "LHashValOfNameSysA" (byval as SYSKIND, byval as LCID, byval as zstring ptr) as ULONG
declare function LHashValOfNameSys alias "LHashValOfNameSys" (byval as SYSKIND, byval as LCID, byval as OLECHAR ptr) as ULONG
declare function LoadTypeLib alias "LoadTypeLib" (byval as OLECHAR ptr, byval as LPTYPELIB ptr) as HRESULT
declare function LoadTypeLibEx alias "LoadTypeLibEx" (byval as LPCOLESTR, byval as REGKIND, byval as LPTYPELIB ptr) as HRESULT
declare function LoadRegTypeLib alias "LoadRegTypeLib" (byval as GUID ptr, byval as WORD, byval as WORD, byval as LCID, byval as LPTYPELIB ptr) as HRESULT
declare function QueryPathOfRegTypeLib alias "QueryPathOfRegTypeLib" (byval as GUID ptr, byval as ushort, byval as ushort, byval as LCID, byval as LPBSTR) as HRESULT
declare function RegisterTypeLib alias "RegisterTypeLib" (byval as LPTYPELIB, byval as OLECHAR ptr, byval as OLECHAR ptr) as HRESULT
declare function UnRegisterTypeLib alias "UnRegisterTypeLib" (byval as GUID ptr, byval as WORD, byval as WORD, byval as LCID, byval as SYSKIND) as HRESULT
declare function CreateTypeLib alias "CreateTypeLib" (byval as SYSKIND, byval as OLECHAR ptr, byval as LPCREATETYPELIB ptr) as HRESULT
declare function DispGetParam alias "DispGetParam" (byval as DISPPARAMS ptr, byval as UINT, byval as VARTYPE, byval as VARIANT_ ptr, byval as UINT ptr) as HRESULT
declare function DispGetIDsOfNames alias "DispGetIDsOfNames" (byval as LPTYPEINFO, byval as OLECHAR ptr ptr, byval as UINT, byval as DISPID ptr) as HRESULT
declare function DispInvoke alias "DispInvoke" (byval as any ptr, byval as LPTYPEINFO, byval as DISPID, byval as WORD, byval as DISPPARAMS ptr, byval as VARIANT_ ptr, byval as EXCEPINFO ptr, byval as UINT ptr) as HRESULT
declare function CreateDispTypeInfo alias "CreateDispTypeInfo" (byval as INTERFACEDATA ptr, byval as LCID, byval as LPTYPEINFO ptr) as HRESULT
declare function CreateStdDispatch alias "CreateStdDispatch" (byval as IUnknown ptr, byval as any ptr, byval as LPTYPEINFO, byval as IUnknown ptr ptr) as HRESULT
declare function RegisterActiveObject alias "RegisterActiveObject" (byval as IUnknown ptr, byval as CLSID ptr, byval as DWORD, byval as DWORD ptr) as HRESULT
declare function RevokeActiveObject alias "RevokeActiveObject" (byval as DWORD, byval as any ptr) as HRESULT
declare function GetActiveObject alias "GetActiveObject" (byval as CLSID ptr, byval as any ptr, byval as IUnknown ptr ptr) as HRESULT
declare function SetErrorInfo alias "SetErrorInfo" (byval as uinteger, byval as LPERRORINFO) as HRESULT
declare function GetErrorInfo alias "GetErrorInfo" (byval as uinteger, byval as LPERRORINFO ptr) as HRESULT
declare function CreateErrorInfo alias "CreateErrorInfo" (byval as LPCREATEERRORINFO ptr) as HRESULT
declare function OaBuildVersion alias "OaBuildVersion" () as uinteger
declare function VectorFromBstr alias "VectorFromBstr" (byval as BSTR, byval as SAFEARRAY ptr ptr) as HRESULT
declare function BstrFromVector alias "BstrFromVector" (byval as SAFEARRAY ptr, byval as BSTR ptr) as HRESULT
declare function VarParseNumFromStr alias "VarParseNumFromStr" (byval as OLECHAR ptr, byval as LCID, byval as ULONG, byval as NUMPARSE ptr, byval as UBYTE ptr) as HRESULT
declare function VarNumFromParseNum alias "VarNumFromParseNum" (byval as NUMPARSE ptr, byval as UBYTE ptr, byval as ULONG, byval as VARIANT_ ptr) as HRESULT
declare function VarI8FromUI1 alias "VarI8FromUI1" (byval as UBYTE, byval as LONG64 ptr) as HRESULT
declare function VarI8FromI2 alias "VarI8FromI2" (byval as SHORT, byval as LONG64 ptr) as HRESULT
declare function VarI8FromI4 alias "VarI8FromI4" (byval as LONG, byval as LONG64 ptr) as HRESULT
declare function VarI8FromR4 alias "VarI8FromR4" (byval as FLOAT, byval as LONG64 ptr) as HRESULT
declare function VarI8FromR8 alias "VarI8FromR8" (byval as DOUBLE, byval as LONG64 ptr) as HRESULT
declare function VarI8FromDate alias "VarI8FromDate" (byval as DATE_, byval as LONG64 ptr) as HRESULT
declare function VarI8FromStr alias "VarI8FromStr" (byval as OLECHAR ptr, byval as LCID, byval as ULONG, byval as LONG64 ptr) as HRESULT
declare function VarI8FromBool alias "VarI8FromBool" (byval as VARIANT_BOOL, byval as LONG64 ptr) as HRESULT
declare function VarI8FromI1 alias "VarI8FromI1" (byval as byte, byval as LONG64 ptr) as HRESULT
declare function VarI8FromUI2 alias "VarI8FromUI2" (byval as USHORT, byval as LONG64 ptr) as HRESULT
declare function VarI8FromUI4 alias "VarI8FromUI4" (byval as ULONG, byval as LONG64 ptr) as HRESULT
declare function VarI8FromUI8 alias "VarI8FromUI8" (byval as ULONG64, byval as LONG64 ptr) as HRESULT
declare function VarI8FromDec alias "VarI8FromDec" (byval pdecIn as DECIMAL ptr, byval as LONG64 ptr) as HRESULT
declare function VarI8FromInt alias "VarI8FromInt" (byval intIn as INT_, byval as LONG64 ptr) as HRESULT
declare function VarI8FromCy alias "VarI8FromCy" (byval as CY, byval as LONG64 ptr) as HRESULT
declare function VarI8FromDisp alias "VarI8FromDisp" (byval as IDispatch ptr, byval as LCID, byval as LONG64 ptr) as HRESULT
declare function VarI1FromUI1 alias "VarI1FromUI1" (byval as UBYTE, byval as zstring ptr) as HRESULT
declare function VarI1FromI2 alias "VarI1FromI2" (byval as SHORT, byval as zstring ptr) as HRESULT
declare function VarI1FromI4 alias "VarI1FromI4" (byval as LONG, byval as zstring ptr) as HRESULT
declare function VarI1FromI8 alias "VarI1FromI8" (byval as LONG64, byval as zstring ptr) as HRESULT
declare function VarI1FromR4 alias "VarI1FromR4" (byval as FLOAT, byval as zstring ptr) as HRESULT
declare function VarI1FromR8 alias "VarI1FromR8" (byval as DOUBLE, byval as zstring ptr) as HRESULT
declare function VarI1FromDate alias "VarI1FromDate" (byval as DATE_, byval as zstring ptr) as HRESULT
declare function VarI1FromStr alias "VarI1FromStr" (byval as OLECHAR ptr, byval as LCID, byval as ULONG, byval as zstring ptr) as HRESULT
declare function VarI1FromBool alias "VarI1FromBool" (byval as VARIANT_BOOL, byval as zstring ptr) as HRESULT
declare function VarI1FromUI2 alias "VarI1FromUI2" (byval as USHORT, byval as zstring ptr) as HRESULT
declare function VarI1FromUI4 alias "VarI1FromUI4" (byval as ULONG, byval as zstring ptr) as HRESULT
declare function VarI1FromUI8 alias "VarI1FromUI8" (byval as ULONG64, byval as zstring ptr) as HRESULT
declare function VarI1FromCy alias "VarI1FromCy" (byval as CY, byval as zstring ptr) as HRESULT
declare function VarI1FromDec alias "VarI1FromDec" (byval as DECIMAL ptr, byval as zstring ptr) as HRESULT
declare function VarI1FromDisp alias "VarI1FromDisp" (byval as IDispatch ptr, byval as LCID, byval as zstring ptr) as HRESULT
declare function VarUI2FromUI1 alias "VarUI2FromUI1" (byval as UBYTE, byval as USHORT ptr) as HRESULT
declare function VarUI2FromI2 alias "VarUI2FromI2" (byval as SHORT, byval as USHORT ptr) as HRESULT
declare function VarUI2FromI4 alias "VarUI2FromI4" (byval as LONG, byval as USHORT ptr) as HRESULT
declare function VarUI2FromI8 alias "VarUI2FromI8" (byval as LONG64, byval as USHORT ptr) as HRESULT
declare function VarUI2FromR4 alias "VarUI2FromR4" (byval as FLOAT, byval as USHORT ptr) as HRESULT
declare function VarUI2FromR8 alias "VarUI2FromR8" (byval as DOUBLE, byval as USHORT ptr) as HRESULT
declare function VarUI2FromDate alias "VarUI2FromDate" (byval as DATE_, byval as USHORT ptr) as HRESULT
declare function VarUI2FromStr alias "VarUI2FromStr" (byval as OLECHAR ptr, byval as LCID, byval as ULONG, byval as USHORT ptr) as HRESULT
declare function VarUI2FromBool alias "VarUI2FromBool" (byval as VARIANT_BOOL, byval as USHORT ptr) as HRESULT
declare function VarUI2FromI1 alias "VarUI2FromI1" (byval as byte, byval as USHORT ptr) as HRESULT
declare function VarUI2FromUI4 alias "VarUI2FromUI4" (byval as ULONG, byval as USHORT ptr) as HRESULT
declare function VarUI2FromUI8 alias "VarUI2FromUI8" (byval as ULONG64, byval as USHORT ptr) as HRESULT
declare function VarUI2FromCy alias "VarUI2FromCy" (byval as CY, byval as USHORT ptr) as HRESULT
declare function VarUI2FromDec alias "VarUI2FromDec" (byval as DECIMAL ptr, byval as USHORT ptr) as HRESULT
declare function VarUI2FromDisp alias "VarUI2FromDisp" (byval as IDispatch ptr, byval as LCID, byval as USHORT ptr) as HRESULT
declare function VarUI4FromStr alias "VarUI4FromStr" (byval as OLECHAR ptr, byval as LCID, byval as ULONG, byval as ULONG ptr) as HRESULT
declare function VarUI4FromUI1 alias "VarUI4FromUI1" (byval as UBYTE, byval as ULONG ptr) as HRESULT
declare function VarUI4FromI2 alias "VarUI4FromI2" (byval as SHORT, byval as ULONG ptr) as HRESULT
declare function VarUI4FromI4 alias "VarUI4FromI4" (byval as LONG, byval as ULONG ptr) as HRESULT
declare function VarUI4FromI8 alias "VarUI4FromI8" (byval as LONG64, byval as ULONG ptr) as HRESULT
declare function VarUI4FromR4 alias "VarUI4FromR4" (byval as FLOAT, byval as ULONG ptr) as HRESULT
declare function VarUI4FromR8 alias "VarUI4FromR8" (byval as DOUBLE, byval as ULONG ptr) as HRESULT
declare function VarUI4FromDate alias "VarUI4FromDate" (byval as DATE_, byval as ULONG ptr) as HRESULT
declare function VarUI4FromBool alias "VarUI4FromBool" (byval as VARIANT_BOOL, byval as ULONG ptr) as HRESULT
declare function VarUI4FromI1 alias "VarUI4FromI1" (byval as byte, byval as ULONG ptr) as HRESULT
declare function VarUI4FromUI2 alias "VarUI4FromUI2" (byval as USHORT, byval as ULONG ptr) as HRESULT
declare function VarUI4FromUI8 alias "VarUI4FromUI8" (byval as ULONG64, byval as ULONG ptr) as HRESULT
declare function VarUI4FromCy alias "VarUI4FromCy" (byval as CY, byval as ULONG ptr) as HRESULT
declare function VarUI4FromDec alias "VarUI4FromDec" (byval as DECIMAL ptr, byval as ULONG ptr) as HRESULT
declare function VarUI4FromDisp alias "VarUI4FromDisp" (byval as IDispatch ptr, byval as LCID, byval as ULONG ptr) as HRESULT
declare function VarUI8FromUI1 alias "VarUI8FromUI1" (byval as UBYTE, byval as ULONG64 ptr) as HRESULT
declare function VarUI8FromI2 alias "VarUI8FromI2" (byval as SHORT, byval as ULONG64 ptr) as HRESULT
declare function VarUI8FromI4 alias "VarUI8FromI4" (byval as LONG, byval as ULONG64 ptr) as HRESULT
declare function VarUI8FromI8 alias "VarUI8FromI8" (byval as LONG64, byval as ULONG64 ptr) as HRESULT
declare function VarUI8FromR4 alias "VarUI8FromR4" (byval as FLOAT, byval as ULONG64 ptr) as HRESULT
declare function VarUI8FromR8 alias "VarUI8FromR8" (byval as DOUBLE, byval as ULONG64 ptr) as HRESULT
declare function VarUI8FromDate alias "VarUI8FromDate" (byval as DATE_, byval as ULONG64 ptr) as HRESULT
declare function VarUI8FromStr alias "VarUI8FromStr" (byval as OLECHAR ptr, byval as LCID, byval as ULONG, byval as ULONG64 ptr) as HRESULT
declare function VarUI8FromBool alias "VarUI8FromBool" (byval as VARIANT_BOOL, byval as ULONG64 ptr) as HRESULT
declare function VarUI8FromI1 alias "VarUI8FromI1" (byval as byte, byval as ULONG64 ptr) as HRESULT
declare function VarUI8FromUI2 alias "VarUI8FromUI2" (byval as USHORT, byval as ULONG64 ptr) as HRESULT
declare function VarUI8FromUI4 alias "VarUI8FromUI4" (byval as ULONG, byval as ULONG64 ptr) as HRESULT
declare function VarUI8FromDec alias "VarUI8FromDec" (byval as DECIMAL ptr, byval as ULONG64 ptr) as HRESULT
declare function VarUI8FromInt alias "VarUI8FromInt" (byval as INT_, byval as ULONG64 ptr) as HRESULT
declare function VarUI8FromCy alias "VarUI8FromCy" (byval as CY, byval as ULONG64 ptr) as HRESULT
declare function VarUI8FromDisp alias "VarUI8FromDisp" (byval as IDispatch ptr, byval as LCID, byval as ULONG64 ptr) as HRESULT
declare function VarDecFromUI1 alias "VarDecFromUI1" (byval as UBYTE, byval as DECIMAL ptr) as HRESULT
declare function VarDecFromI2 alias "VarDecFromI2" (byval as SHORT, byval as DECIMAL ptr) as HRESULT
declare function VarDecFromI4 alias "VarDecFromI4" (byval as LONG, byval as DECIMAL ptr) as HRESULT
declare function VarDecFromI8 alias "VarDecFromI8" (byval as LONG64, byval as DECIMAL ptr) as HRESULT
declare function VarDecFromR4 alias "VarDecFromR4" (byval as FLOAT, byval as DECIMAL ptr) as HRESULT
declare function VarDecFromR8 alias "VarDecFromR8" (byval as DOUBLE, byval as DECIMAL ptr) as HRESULT
declare function VarDecFromDate alias "VarDecFromDate" (byval as DATE_, byval as DECIMAL ptr) as HRESULT
declare function VarDecFromStr alias "VarDecFromStr" (byval as OLECHAR ptr, byval as LCID, byval as ULONG, byval as DECIMAL ptr) as HRESULT
declare function VarDecFromBool alias "VarDecFromBool" (byval as VARIANT_BOOL, byval as DECIMAL ptr) as HRESULT
declare function VarDecFromI1 alias "VarDecFromI1" (byval as byte, byval as DECIMAL ptr) as HRESULT
declare function VarDecFromUI2 alias "VarDecFromUI2" (byval as USHORT, byval as DECIMAL ptr) as HRESULT
declare function VarDecFromUI4 alias "VarDecFromUI4" (byval as ULONG, byval as DECIMAL ptr) as HRESULT
declare function VarDecFromUI8 alias "VarDecFromUI8" (byval as ULONG64, byval as DECIMAL ptr) as HRESULT
declare function VarDecFromCy alias "VarDecFromCy" (byval as CY, byval as DECIMAL ptr) as HRESULT
declare function VarDecFromDisp alias "VarDecFromDisp" (byval as IDispatch ptr, byval as LCID, byval as DECIMAL ptr) as HRESULT
declare function VarDecNeg alias "VarDecNeg" (byval as DECIMAL ptr, byval as DECIMAL ptr) as HRESULT
declare function VarR4CmpR8 alias "VarR4CmpR8" (byval as single, byval as double) as HRESULT
declare function VarR8Pow alias "VarR8Pow" (byval as double, byval as double, byval as double ptr) as HRESULT
declare function VarR8Round alias "VarR8Round" (byval as double, byval as integer, byval as double ptr) as HRESULT
declare function VarDecAbs alias "VarDecAbs" (byval as DECIMAL ptr, byval as DECIMAL ptr) as HRESULT
declare function VarDecAdd alias "VarDecAdd" (byval as DECIMAL ptr, byval as DECIMAL ptr, byval as DECIMAL ptr) as HRESULT
declare function VarDecCmp alias "VarDecCmp" (byval as DECIMAL ptr, byval as DECIMAL ptr) as HRESULT
declare function VarDecCmpR8 alias "VarDecCmpR8" (byval as DECIMAL ptr, byval as DOUBLE) as HRESULT
declare function VarDecDiv alias "VarDecDiv" (byval as DECIMAL ptr, byval as DECIMAL ptr, byval as DECIMAL ptr) as HRESULT
declare function VarDecFix alias "VarDecFix" (byval as DECIMAL ptr, byval as DECIMAL ptr) as HRESULT
declare function VarDecInt alias "VarDecInt" (byval as DECIMAL ptr, byval as DECIMAL ptr) as HRESULT
declare function VarDecMul alias "VarDecMul" (byval as DECIMAL ptr, byval as DECIMAL ptr, byval as DECIMAL ptr) as HRESULT
declare function VarDecRound alias "VarDecRound" (byval as DECIMAL ptr, byval as integer, byval as DECIMAL ptr) as HRESULT
declare function VarDecSub alias "VarDecSub" (byval as DECIMAL ptr, byval as DECIMAL ptr, byval as DECIMAL ptr) as HRESULT
declare function VarCyAbs alias "VarCyAbs" (byval as CY, byval as CY ptr) as HRESULT
declare function VarCyAdd alias "VarCyAdd" (byval as CY, byval as CY, byval as CY ptr) as HRESULT
declare function VarCyCmp alias "VarCyCmp" (byval as CY, byval as CY) as HRESULT
declare function VarCyCmpR8 alias "VarCyCmpR8" (byval as CY, byval as DOUBLE) as HRESULT
declare function VarCyFix alias "VarCyFix" (byval as CY, byval as CY ptr) as HRESULT
declare function VarCyInt alias "VarCyInt" (byval as CY, byval as CY ptr) as HRESULT
declare function VarCyMul alias "VarCyMul" (byval as CY, byval as CY, byval as CY ptr) as HRESULT
declare function VarCyMulI4 alias "VarCyMulI4" (byval as CY, byval as LONG, byval as CY ptr) as HRESULT
declare function VarCyMulI8 alias "VarCyMulI8" (byval as CY, byval as LONG64, byval as CY ptr) as HRESULT
declare function VarCyNeg alias "VarCyNeg" (byval as CY, byval as CY ptr) as HRESULT
declare function VarCyRound alias "VarCyRound" (byval as CY, byval as INT_, byval as CY ptr) as HRESULT
declare function VarCySub alias "VarCySub" (byval as CY, byval as CY, byval as CY ptr) as HRESULT
declare function VarAdd alias "VarAdd" (byval as LPVARIANT, byval as LPVARIANT, byval as LPVARIANT) as HRESULT
declare function VarAnd alias "VarAnd" (byval as LPVARIANT, byval as LPVARIANT, byval as LPVARIANT) as HRESULT
declare function VarCat alias "VarCat" (byval as LPVARIANT, byval as LPVARIANT, byval as LPVARIANT) as HRESULT
declare function VarDiv alias "VarDiv" (byval as LPVARIANT, byval as LPVARIANT, byval as LPVARIANT) as HRESULT
declare function VarEqv alias "VarEqv" (byval as LPVARIANT, byval as LPVARIANT, byval as LPVARIANT) as HRESULT
declare function VarIdiv alias "VarIdiv" (byval as LPVARIANT, byval as LPVARIANT, byval as LPVARIANT) as HRESULT
declare function VarImp alias "VarImp" (byval as LPVARIANT, byval as LPVARIANT, byval as LPVARIANT) as HRESULT
declare function VarMod alias "VarMod" (byval as LPVARIANT, byval as LPVARIANT, byval as LPVARIANT) as HRESULT
declare function VarMul alias "VarMul" (byval as LPVARIANT, byval as LPVARIANT, byval as LPVARIANT) as HRESULT
declare function VarOr alias "VarOr" (byval as LPVARIANT, byval as LPVARIANT, byval as LPVARIANT) as HRESULT
declare function VarPow alias "VarPow" (byval as LPVARIANT, byval as LPVARIANT, byval as LPVARIANT) as HRESULT
declare function VarSub alias "VarSub" (byval as LPVARIANT, byval as LPVARIANT, byval as LPVARIANT) as HRESULT
declare function VarXor alias "VarXor" (byval as LPVARIANT, byval as LPVARIANT, byval as LPVARIANT) as HRESULT
declare function VarAbs alias "VarAbs" (byval as LPVARIANT, byval as LPVARIANT) as HRESULT
declare function VarFix alias "VarFix" (byval as LPVARIANT, byval as LPVARIANT) as HRESULT
declare function VarInt alias "VarInt" (byval as LPVARIANT, byval as LPVARIANT) as HRESULT
declare function VarNeg alias "VarNeg" (byval as LPVARIANT, byval as LPVARIANT) as HRESULT
declare function VarNot alias "VarNot" (byval as LPVARIANT, byval as LPVARIANT) as HRESULT
declare function VarRound alias "VarRound" (byval as LPVARIANT, byval as integer, byval as LPVARIANT) as HRESULT
declare function VarCmp alias "VarCmp" (byval as LPVARIANT, byval as LPVARIANT, byval as LCID, byval as ULONG) as HRESULT
declare function VarBstrCmp alias "VarBstrCmp" (byval as BSTR, byval as BSTR, byval as LCID, byval as ULONG) as HRESULT
declare function VarBstrCat alias "VarBstrCat" (byval as BSTR, byval as BSTR, byval as BSTR ptr) as HRESULT

#endif
