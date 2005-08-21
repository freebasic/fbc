''
''
'' oleauto -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __oleauto_bi__
#define __oleauto_bi__

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
#define V_I2REF(X) V_UNION(X,piVal)
#define V_I4(X) V_UNION(X,lVal)
#define V_I4REF(X) V_UNION(X,plVal)
#define V_I8(X) V_UNION(X,hVal)
#define V_I8REF(X) V_UNION(X,phVal)
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

declare function SysAllocString alias "SysAllocString" (byval as OLECHAR ptr) as BSTR
declare function SysReAllocString alias "SysReAllocString" (byval as BSTR ptr, byval as OLECHAR ptr) as integer
declare function SysAllocStringLen alias "SysAllocStringLen" (byval as OLECHAR ptr, byval as uinteger) as BSTR
declare function SysReAllocStringLen alias "SysReAllocStringLen" (byval as BSTR ptr, byval as OLECHAR ptr, byval as uinteger) as integer
declare sub SysFreeString alias "SysFreeString" (byval as BSTR)
declare function SysStringLen alias "SysStringLen" (byval as BSTR) as uinteger
declare function SysStringByteLen alias "SysStringByteLen" (byval as BSTR) as uinteger
declare function SysAllocStringByteLen alias "SysAllocStringByteLen" (byval as string, byval as uinteger) as BSTR
declare function DosDateTimeToVariantTime alias "DosDateTimeToVariantTime" (byval as ushort, byval as ushort, byval as double ptr) as integer
declare function VariantTimeToDosDateTime alias "VariantTimeToDosDateTime" (byval as double, byval as ushort ptr, byval as ushort ptr) as integer
declare function VariantTimeToSystemTime alias "VariantTimeToSystemTime" (byval as double, byval as LPSYSTEMTIME) as integer
declare function SystemTimeToVariantTime alias "SystemTimeToVariantTime" (byval as LPSYSTEMTIME, byval as double ptr) as integer
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
declare function SafeArrayCreateVector alias "SafeArrayCreateVector" (byval as VARTYPE, byval as LONG, byval as UINT) as SAFEARRAY ptr
declare sub VariantInit alias "VariantInit" (byval as VARIANTARG ptr)
declare function VariantClear alias "VariantClear" (byval as VARIANTARG ptr) as HRESULT
declare function VariantCopy alias "VariantCopy" (byval as VARIANTARG ptr, byval as VARIANTARG ptr) as HRESULT
declare function VariantCopyInd alias "VariantCopyInd" (byval as VARIANT ptr, byval as VARIANTARG ptr) as HRESULT
declare function VariantChangeType alias "VariantChangeType" (byval as VARIANTARG ptr, byval as VARIANTARG ptr, byval as ushort, byval as VARTYPE) as HRESULT
declare function VariantChangeTypeEx alias "VariantChangeTypeEx" (byval as VARIANTARG ptr, byval as VARIANTARG ptr, byval as LCID, byval as ushort, byval as VARTYPE) as HRESULT
declare function VarUI1FromI2 alias "VarUI1FromI2" (byval as short, byval as ubyte ptr) as HRESULT
declare function VarUI1FromI4 alias "VarUI1FromI4" (byval as integer, byval as ubyte ptr) as HRESULT
declare function VarUI1FromR4 alias "VarUI1FromR4" (byval as single, byval as ubyte ptr) as HRESULT
declare function VarUI1FromR8 alias "VarUI1FromR8" (byval as double, byval as ubyte ptr) as HRESULT
declare function VarUI1FromCy alias "VarUI1FromCy" (byval as CY, byval as ubyte ptr) as HRESULT
declare function VarUI1FromDate alias "VarUI1FromDate" (byval as DATE_, byval as ubyte ptr) as HRESULT
declare function VarUI1FromStr alias "VarUI1FromStr" (byval as OLECHAR ptr, byval as LCID, byval as uinteger, byval as ubyte ptr) as HRESULT
declare function VarUI1FromDisp alias "VarUI1FromDisp" (byval as LPDISPATCH ptr, byval as LCID, byval as ubyte ptr) as HRESULT
declare function VarUI1FromBool alias "VarUI1FromBool" (byval as VARIANT_BOOL, byval as ubyte ptr) as HRESULT
declare function VarI2FromUI1 alias "VarI2FromUI1" (byval as ubyte, byval as short ptr) as HRESULT
declare function VarI2FromI4 alias "VarI2FromI4" (byval as integer, byval as short ptr) as HRESULT
declare function VarI2FromR4 alias "VarI2FromR4" (byval as single, byval as short ptr) as HRESULT
declare function VarI2FromR8 alias "VarI2FromR8" (byval as double, byval as short ptr) as HRESULT
declare function VarI2FromCy alias "VarI2FromCy" (byval cyIn as CY, byval as short ptr) as HRESULT
declare function VarI2FromDate alias "VarI2FromDate" (byval as DATE_, byval as short ptr) as HRESULT
declare function VarI2FromStr alias "VarI2FromStr" (byval as OLECHAR ptr, byval as LCID, byval as uinteger, byval as short ptr) as HRESULT
declare function VarI2FromDisp alias "VarI2FromDisp" (byval as LPDISPATCH ptr, byval as LCID, byval as short ptr) as HRESULT
declare function VarI2FromBool alias "VarI2FromBool" (byval as VARIANT_BOOL, byval as short ptr) as HRESULT
declare function VarI4FromUI1 alias "VarI4FromUI1" (byval as ubyte, byval as integer ptr) as HRESULT
declare function VarI4FromI2 alias "VarI4FromI2" (byval as short, byval as integer ptr) as HRESULT
declare function VarI4FromR4 alias "VarI4FromR4" (byval as single, byval as integer ptr) as HRESULT
declare function VarI4FromR8 alias "VarI4FromR8" (byval as double, byval as integer ptr) as HRESULT
declare function VarI4FromCy alias "VarI4FromCy" (byval as CY, byval as integer ptr) as HRESULT
declare function VarI4FromDate alias "VarI4FromDate" (byval as DATE_, byval as integer ptr) as HRESULT
declare function VarI4FromStr alias "VarI4FromStr" (byval as OLECHAR ptr, byval as LCID, byval as uinteger, byval as integer ptr) as HRESULT
declare function VarI4FromDisp alias "VarI4FromDisp" (byval as LPDISPATCH ptr, byval as LCID, byval as integer ptr) as HRESULT
declare function VarI4FromBool alias "VarI4FromBool" (byval as VARIANT_BOOL, byval as integer ptr) as HRESULT
declare function VarR4FromUI1 alias "VarR4FromUI1" (byval as ubyte, byval as single ptr) as HRESULT
declare function VarR4FromI2 alias "VarR4FromI2" (byval as short, byval as single ptr) as HRESULT
declare function VarR4FromI4 alias "VarR4FromI4" (byval as integer, byval as single ptr) as HRESULT
declare function VarR4FromR8 alias "VarR4FromR8" (byval as double, byval as single ptr) as HRESULT
declare function VarR4FromCy alias "VarR4FromCy" (byval as CY, byval as single ptr) as HRESULT
declare function VarR4FromDate alias "VarR4FromDate" (byval as DATE_, byval as single ptr) as HRESULT
declare function VarR4FromStr alias "VarR4FromStr" (byval as OLECHAR ptr, byval as LCID, byval as uinteger, byval as single ptr) as HRESULT
declare function VarR4FromDisp alias "VarR4FromDisp" (byval as LPDISPATCH ptr, byval as LCID, byval as single ptr) as HRESULT
declare function VarR4FromBool alias "VarR4FromBool" (byval as VARIANT_BOOL, byval as single ptr) as HRESULT
declare function VarR8FromUI1 alias "VarR8FromUI1" (byval as ubyte, byval as double ptr) as HRESULT
declare function VarR8FromI2 alias "VarR8FromI2" (byval as short, byval as double ptr) as HRESULT
declare function VarR8FromI4 alias "VarR8FromI4" (byval as integer, byval as double ptr) as HRESULT
declare function VarR8FromR4 alias "VarR8FromR4" (byval as single, byval as double ptr) as HRESULT
declare function VarR8FromCy alias "VarR8FromCy" (byval as CY, byval as double ptr) as HRESULT
declare function VarR8FromDate alias "VarR8FromDate" (byval as DATE_, byval as double ptr) as HRESULT
declare function VarR8FromStr alias "VarR8FromStr" (byval as OLECHAR ptr, byval as LCID, byval as uinteger, byval as double ptr) as HRESULT
declare function VarR8FromDisp alias "VarR8FromDisp" (byval as LPDISPATCH ptr, byval as LCID, byval as double ptr) as HRESULT
declare function VarR8FromBool alias "VarR8FromBool" (byval as VARIANT_BOOL, byval as double ptr) as HRESULT
declare function VarR8FromDec alias "VarR8FromDec" (byval as DECIMAL ptr, byval as double ptr) as HRESULT
declare function VarDateFromUI1 alias "VarDateFromUI1" (byval as ubyte, byval as DATE_ ptr) as HRESULT
declare function VarDateFromI2 alias "VarDateFromI2" (byval as short, byval as DATE_ ptr) as HRESULT
declare function VarDateFromI4 alias "VarDateFromI4" (byval as integer, byval as DATE_ ptr) as HRESULT
declare function VarDateFromR4 alias "VarDateFromR4" (byval as single, byval as DATE_ ptr) as HRESULT
declare function VarDateFromR8 alias "VarDateFromR8" (byval as double, byval as DATE_ ptr) as HRESULT
declare function VarDateFromCy alias "VarDateFromCy" (byval as CY, byval as DATE_ ptr) as HRESULT
declare function VarDateFromStr alias "VarDateFromStr" (byval as OLECHAR ptr, byval as LCID, byval as uinteger, byval as DATE_ ptr) as HRESULT
declare function VarDateFromDisp alias "VarDateFromDisp" (byval as LPDISPATCH ptr, byval as LCID, byval as DATE_ ptr) as HRESULT
declare function VarDateFromBool alias "VarDateFromBool" (byval as VARIANT_BOOL, byval as DATE_ ptr) as HRESULT
declare function VarCyFromUI1 alias "VarCyFromUI1" (byval as ubyte, byval as CY ptr) as HRESULT
declare function VarCyFromI2 alias "VarCyFromI2" (byval as short, byval as CY ptr) as HRESULT
declare function VarCyFromI4 alias "VarCyFromI4" (byval as integer, byval as CY ptr) as HRESULT
declare function VarCyFromR4 alias "VarCyFromR4" (byval as single, byval as CY ptr) as HRESULT
declare function VarCyFromR8 alias "VarCyFromR8" (byval as double, byval as CY ptr) as HRESULT
declare function VarCyFromDate alias "VarCyFromDate" (byval as DATE_, byval as CY ptr) as HRESULT
declare function VarCyFromStr alias "VarCyFromStr" (byval as OLECHAR ptr, byval as LCID, byval as uinteger, byval as CY ptr) as HRESULT
declare function VarCyFromDisp alias "VarCyFromDisp" (byval as LPDISPATCH ptr, byval as LCID, byval as CY ptr) as HRESULT
declare function VarCyFromBool alias "VarCyFromBool" (byval as VARIANT_BOOL, byval as CY ptr) as HRESULT
declare function VarBstrFromUI1 alias "VarBstrFromUI1" (byval as ubyte, byval as LCID, byval as uinteger, byval as BSTR ptr) as HRESULT
declare function VarBstrFromI2 alias "VarBstrFromI2" (byval as short, byval as LCID, byval as uinteger, byval as BSTR ptr) as HRESULT
declare function VarBstrFromI4 alias "VarBstrFromI4" (byval as integer, byval as LCID, byval as uinteger, byval as BSTR ptr) as HRESULT
declare function VarBstrFromR4 alias "VarBstrFromR4" (byval as single, byval as LCID, byval as uinteger, byval as BSTR ptr) as HRESULT
declare function VarBstrFromR8 alias "VarBstrFromR8" (byval as double, byval as LCID, byval as uinteger, byval as BSTR ptr) as HRESULT
declare function VarBstrFromCy alias "VarBstrFromCy" (byval as CY, byval as LCID, byval as uinteger, byval as BSTR ptr) as HRESULT
declare function VarBstrFromDate alias "VarBstrFromDate" (byval as DATE_, byval as LCID, byval as uinteger, byval as BSTR ptr) as HRESULT
declare function VarBstrFromDisp alias "VarBstrFromDisp" (byval as LPDISPATCH ptr, byval as LCID, byval as uinteger, byval as BSTR ptr) as HRESULT
declare function VarBstrFromBool alias "VarBstrFromBool" (byval as VARIANT_BOOL, byval as LCID, byval as uinteger, byval as BSTR ptr) as HRESULT
declare function VarBoolFromUI1 alias "VarBoolFromUI1" (byval as ubyte, byval as VARIANT_BOOL ptr) as HRESULT
declare function VarBoolFromI2 alias "VarBoolFromI2" (byval as short, byval as VARIANT_BOOL ptr) as HRESULT
declare function VarBoolFromI4 alias "VarBoolFromI4" (byval as integer, byval as VARIANT_BOOL ptr) as HRESULT
declare function VarBoolFromR4 alias "VarBoolFromR4" (byval as single, byval as VARIANT_BOOL ptr) as HRESULT
declare function VarBoolFromR8 alias "VarBoolFromR8" (byval as double, byval as VARIANT_BOOL ptr) as HRESULT
declare function VarBoolFromDate alias "VarBoolFromDate" (byval as DATE_, byval as VARIANT_BOOL ptr) as HRESULT
declare function VarBoolFromCy alias "VarBoolFromCy" (byval as CY, byval as VARIANT_BOOL ptr) as HRESULT
declare function VarBoolFromStr alias "VarBoolFromStr" (byval as OLECHAR ptr, byval as LCID, byval as uinteger, byval as VARIANT_BOOL ptr) as HRESULT
declare function VarBoolFromDisp alias "VarBoolFromDisp" (byval as LPDISPATCH ptr, byval as LCID, byval as VARIANT_BOOL ptr) as HRESULT
declare function VarDecFromR8 alias "VarDecFromR8" (byval as double, byval as DECIMAL ptr) as HRESULT
declare function LHashValOfNameSysA alias "LHashValOfNameSysA" (byval as SYSKIND, byval as LCID, byval as string) as ULONG
declare function LHashValOfNameSys alias "LHashValOfNameSys" (byval as SYSKIND, byval as LCID, byval as OLECHAR ptr) as ULONG
declare function LoadTypeLib alias "LoadTypeLib" (byval as OLECHAR ptr, byval as LPTYPELIB ptr) as HRESULT
declare function LoadTypeLibEx alias "LoadTypeLibEx" (byval as LPCOLESTR, byval as REGKIND, byval as LPTYPELIB ptr) as HRESULT
declare function LoadRegTypeLib alias "LoadRegTypeLib" (byval as GUID ptr, byval as WORD, byval as WORD, byval as LCID, byval as LPTYPELIB ptr) as HRESULT
declare function QueryPathOfRegTypeLib alias "QueryPathOfRegTypeLib" (byval as GUID ptr, byval as ushort, byval as ushort, byval as LCID, byval as LPBSTR) as HRESULT
declare function RegisterTypeLib alias "RegisterTypeLib" (byval as LPTYPELIB, byval as OLECHAR ptr, byval as OLECHAR ptr) as HRESULT
declare function UnRegisterTypeLib alias "UnRegisterTypeLib" (byval as GUID ptr, byval as WORD, byval as WORD, byval as LCID, byval as SYSKIND) as HRESULT
declare function CreateTypeLib alias "CreateTypeLib" (byval as SYSKIND, byval as OLECHAR ptr, byval as LPCREATETYPELIB ptr) as HRESULT
declare function DispGetParam alias "DispGetParam" (byval as DISPPARAMS ptr, byval as UINT, byval as VARTYPE, byval as VARIANT ptr, byval as UINT ptr) as HRESULT
declare function DispGetIDsOfNames alias "DispGetIDsOfNames" (byval as LPTYPEINFO, byval as OLECHAR ptr ptr, byval as UINT, byval as DISPID ptr) as HRESULT
declare function DispInvoke alias "DispInvoke" (byval as any ptr, byval as LPTYPEINFO, byval as DISPID, byval as WORD, byval as DISPPARAMS ptr, byval as VARIANT ptr, byval as EXCEPINFO ptr, byval as UINT ptr) as HRESULT
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
declare function VarAdd alias "VarAdd" (byval as LPVARIANT, byval as LPVARIANT, byval as LPVARIANT) as HRESULT
declare function VarSub alias "VarSub" (byval as LPVARIANT, byval as LPVARIANT, byval as LPVARIANT) as HRESULT
declare function VarMul alias "VarMul" (byval as LPVARIANT, byval as LPVARIANT, byval as LPVARIANT) as HRESULT
declare function VarDiv alias "VarDiv" (byval as LPVARIANT, byval as LPVARIANT, byval as LPVARIANT) as HRESULT

#endif
