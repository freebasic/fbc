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

#inclib "oleaut32"

#include once "oaidl.bi"

extern "Windows"

#define _OLEAUTO_H_
extern IID_StdOle as const IID
const STDOLE_MAJORVERNUM = &h1
const STDOLE_MINORVERNUM = &h0
const STDOLE_LCID = &h0000
const STDOLE2_MAJORVERNUM = &h2
const STDOLE2_MINORVERNUM = &h0
const STDOLE2_LCID = &h0000

declare function SysAllocString(byval as const wstring ptr) as BSTR
declare function SysReAllocString(byval as BSTR ptr, byval as const wstring ptr) as INT_
declare function SysAllocStringLen(byval as const wstring ptr, byval as UINT) as BSTR
declare function SysReAllocStringLen(byval as BSTR ptr, byval as const wstring ptr, byval as UINT) as INT_
declare sub SysFreeString(byval as BSTR)
declare function SysStringLen(byval as BSTR) as UINT
declare function SysStringByteLen(byval bstr as BSTR) as UINT
declare function SysAllocStringByteLen(byval psz as LPCSTR, byval len as UINT) as BSTR
declare function DosDateTimeToVariantTime(byval wDosDate as USHORT, byval wDosTime as USHORT, byval pvtime as DOUBLE ptr) as INT_
declare function VariantTimeToDosDateTime(byval vtime as DOUBLE, byval pwDosDate as USHORT ptr, byval pwDosTime as USHORT ptr) as INT_
declare function SystemTimeToVariantTime(byval lpSystemTime as LPSYSTEMTIME, byval pvtime as DOUBLE ptr) as INT_
declare function VariantTimeToSystemTime(byval vtime as DOUBLE, byval lpSystemTime as LPSYSTEMTIME) as INT_
declare function SafeArrayAllocDescriptor(byval cDims as UINT, byval ppsaOut as SAFEARRAY ptr ptr) as HRESULT
declare function SafeArrayAllocDescriptorEx(byval vt as VARTYPE, byval cDims as UINT, byval ppsaOut as SAFEARRAY ptr ptr) as HRESULT
declare function SafeArrayAllocData(byval psa as SAFEARRAY ptr) as HRESULT
declare function SafeArrayCreate(byval vt as VARTYPE, byval cDims as UINT, byval rgsabound as SAFEARRAYBOUND ptr) as SAFEARRAY ptr
declare function SafeArrayCreateEx(byval vt as VARTYPE, byval cDims as UINT, byval rgsabound as SAFEARRAYBOUND ptr, byval pvExtra as PVOID) as SAFEARRAY ptr
declare function SafeArrayCopyData(byval psaSource as SAFEARRAY ptr, byval psaTarget as SAFEARRAY ptr) as HRESULT
declare function SafeArrayDestroyDescriptor(byval psa as SAFEARRAY ptr) as HRESULT
declare function SafeArrayDestroyData(byval psa as SAFEARRAY ptr) as HRESULT
declare function SafeArrayDestroy(byval psa as SAFEARRAY ptr) as HRESULT
declare function SafeArrayRedim(byval psa as SAFEARRAY ptr, byval psaboundNew as SAFEARRAYBOUND ptr) as HRESULT
declare function SafeArrayGetDim(byval psa as SAFEARRAY ptr) as UINT
declare function SafeArrayGetElemsize(byval psa as SAFEARRAY ptr) as UINT
declare function SafeArrayGetUBound(byval psa as SAFEARRAY ptr, byval nDim as UINT, byval plUbound as LONG ptr) as HRESULT
declare function SafeArrayGetLBound(byval psa as SAFEARRAY ptr, byval nDim as UINT, byval plLbound as LONG ptr) as HRESULT
declare function SafeArrayLock(byval psa as SAFEARRAY ptr) as HRESULT
declare function SafeArrayUnlock(byval psa as SAFEARRAY ptr) as HRESULT
declare function SafeArrayAccessData(byval psa as SAFEARRAY ptr, byval ppvData as any ptr ptr) as HRESULT
declare function SafeArrayUnaccessData(byval psa as SAFEARRAY ptr) as HRESULT
declare function SafeArrayGetElement(byval psa as SAFEARRAY ptr, byval rgIndices as LONG ptr, byval pv as any ptr) as HRESULT
declare function SafeArrayPutElement(byval psa as SAFEARRAY ptr, byval rgIndices as LONG ptr, byval pv as any ptr) as HRESULT
declare function SafeArrayCopy(byval psa as SAFEARRAY ptr, byval ppsaOut as SAFEARRAY ptr ptr) as HRESULT
declare function SafeArrayPtrOfIndex(byval psa as SAFEARRAY ptr, byval rgIndices as LONG ptr, byval ppvData as any ptr ptr) as HRESULT
declare function SafeArraySetRecordInfo(byval psa as SAFEARRAY ptr, byval prinfo as IRecordInfo ptr) as HRESULT
declare function SafeArrayGetRecordInfo(byval psa as SAFEARRAY ptr, byval prinfo as IRecordInfo ptr ptr) as HRESULT
declare function SafeArraySetIID(byval psa as SAFEARRAY ptr, byval guid as const GUID const ptr) as HRESULT
declare function SafeArrayGetIID(byval psa as SAFEARRAY ptr, byval pguid as GUID ptr) as HRESULT
declare function SafeArrayGetVartype(byval psa as SAFEARRAY ptr, byval pvt as VARTYPE ptr) as HRESULT
declare function SafeArrayCreateVector(byval vt as VARTYPE, byval lLbound as LONG, byval cElements as ULONG) as SAFEARRAY ptr
declare function SafeArrayCreateVectorEx(byval vt as VARTYPE, byval lLbound as LONG, byval cElements as ULONG, byval pvExtra as PVOID) as SAFEARRAY ptr
declare sub VariantInit(byval pvarg as VARIANTARG ptr)
declare function VariantClear(byval pvarg as VARIANTARG ptr) as HRESULT
declare function VariantCopy(byval pvargDest as VARIANTARG ptr, byval pvargSrc as VARIANTARG ptr) as HRESULT
declare function VariantCopyInd(byval pvarDest as VARIANT ptr, byval pvargSrc as VARIANTARG ptr) as HRESULT
declare function VariantChangeType(byval pvargDest as VARIANTARG ptr, byval pvarSrc as VARIANTARG ptr, byval wFlags as USHORT, byval vt as VARTYPE) as HRESULT
declare function VariantChangeTypeEx(byval pvargDest as VARIANTARG ptr, byval pvarSrc as VARIANTARG ptr, byval lcid as LCID, byval wFlags as USHORT, byval vt as VARTYPE) as HRESULT

const VARIANT_NOVALUEPROP = &h01
const VARIANT_ALPHABOOL = &h02
const VARIANT_NOUSEROVERRIDE = &h04
const VARIANT_CALENDAR_HIJRI = &h08
const VARIANT_LOCALBOOL = &h10
const VARIANT_CALENDAR_THAI = &h20
const VARIANT_CALENDAR_GREGORIAN = &h40
const VARIANT_USE_NLS = &h80
declare function VectorFromBstr(byval bstr as BSTR, byval ppsa as SAFEARRAY ptr ptr) as HRESULT
declare function BstrFromVector(byval psa as SAFEARRAY ptr, byval pbstr as BSTR ptr) as HRESULT
const VAR_TIMEVALUEONLY = cast(DWORD, &h00000001)
const VAR_DATEVALUEONLY = cast(DWORD, &h00000002)
const VAR_VALIDDATE = cast(DWORD, &h00000004)
const VAR_CALENDAR_HIJRI = cast(DWORD, &h00000008)
const VAR_LOCALBOOL = cast(DWORD, &h00000010)
const VAR_FORMAT_NOSUBSTITUTE = cast(DWORD, &h00000020)
const VAR_FOURDIGITYEARS = cast(DWORD, &h00000040)
const LOCALE_USE_NLS = &h10000000
const VAR_CALENDAR_THAI = cast(DWORD, &h00000080)
const VAR_CALENDAR_GREGORIAN = cast(DWORD, &h00000100)
const VTDATEGRE_MAX = 2958465
const VTDATEGRE_MIN = -657434

declare function VarUI1FromI2(byval sIn as SHORT, byval pbOut as UBYTE ptr) as HRESULT
declare function VarUI1FromI4(byval lIn as LONG, byval pbOut as UBYTE ptr) as HRESULT
declare function VarUI1FromI8(byval i64In as LONG64, byval pbOut as UBYTE ptr) as HRESULT
declare function VarUI1FromR4(byval fltIn as FLOAT, byval pbOut as UBYTE ptr) as HRESULT
declare function VarUI1FromR8(byval dblIn as DOUBLE, byval pbOut as UBYTE ptr) as HRESULT
declare function VarUI1FromCy(byval cyIn as CY, byval pbOut as UBYTE ptr) as HRESULT
declare function VarUI1FromDate(byval dateIn as DATE_, byval pbOut as UBYTE ptr) as HRESULT
declare function VarUI1FromStr(byval strIn as wstring ptr, byval lcid as LCID, byval dwFlags as ULONG, byval pbOut as UBYTE ptr) as HRESULT
declare function VarUI1FromDisp(byval pdispIn as IDispatch ptr, byval lcid as LCID, byval pbOut as UBYTE ptr) as HRESULT
declare function VarUI1FromBool(byval boolIn as VARIANT_BOOL, byval pbOut as UBYTE ptr) as HRESULT
declare function VarUI1FromI1(byval cIn as CHAR, byval pbOut as UBYTE ptr) as HRESULT
declare function VarUI1FromUI2(byval uiIn as USHORT, byval pbOut as UBYTE ptr) as HRESULT
declare function VarUI1FromUI4(byval ulIn as ULONG, byval pbOut as UBYTE ptr) as HRESULT
declare function VarUI1FromUI8(byval ui64In as ULONG64, byval pbOut as UBYTE ptr) as HRESULT
declare function VarUI1FromDec(byval pdecIn as DECIMAL ptr, byval pbOut as UBYTE ptr) as HRESULT
declare function VarI2FromUI1(byval bIn as UBYTE, byval psOut as SHORT ptr) as HRESULT
declare function VarI2FromI4(byval lIn as LONG, byval psOut as SHORT ptr) as HRESULT
declare function VarI2FromI8(byval i64In as LONG64, byval psOut as SHORT ptr) as HRESULT
declare function VarI2FromR4(byval fltIn as FLOAT, byval psOut as SHORT ptr) as HRESULT
declare function VarI2FromR8(byval dblIn as DOUBLE, byval psOut as SHORT ptr) as HRESULT
declare function VarI2FromCy(byval cyIn as CY, byval psOut as SHORT ptr) as HRESULT
declare function VarI2FromDate(byval dateIn as DATE_, byval psOut as SHORT ptr) as HRESULT
declare function VarI2FromStr(byval strIn as wstring ptr, byval lcid as LCID, byval dwFlags as ULONG, byval psOut as SHORT ptr) as HRESULT
declare function VarI2FromDisp(byval pdispIn as IDispatch ptr, byval lcid as LCID, byval psOut as SHORT ptr) as HRESULT
declare function VarI2FromBool(byval boolIn as VARIANT_BOOL, byval psOut as SHORT ptr) as HRESULT
declare function VarI2FromI1(byval cIn as CHAR, byval psOut as SHORT ptr) as HRESULT
declare function VarI2FromUI2(byval uiIn as USHORT, byval psOut as SHORT ptr) as HRESULT
declare function VarI2FromUI4(byval ulIn as ULONG, byval psOut as SHORT ptr) as HRESULT
declare function VarI2FromUI8(byval ui64In as ULONG64, byval psOut as SHORT ptr) as HRESULT
declare function VarI2FromDec(byval pdecIn as DECIMAL ptr, byval psOut as SHORT ptr) as HRESULT
declare function VarI4FromUI1(byval bIn as UBYTE, byval plOut as LONG ptr) as HRESULT
declare function VarI4FromI2(byval sIn as SHORT, byval plOut as LONG ptr) as HRESULT
declare function VarI4FromI8(byval i64In as LONG64, byval plOut as LONG ptr) as HRESULT
declare function VarI4FromR4(byval fltIn as FLOAT, byval plOut as LONG ptr) as HRESULT
declare function VarI4FromR8(byval dblIn as DOUBLE, byval plOut as LONG ptr) as HRESULT
declare function VarI4FromCy(byval cyIn as CY, byval plOut as LONG ptr) as HRESULT
declare function VarI4FromDate(byval dateIn as DATE_, byval plOut as LONG ptr) as HRESULT
declare function VarI4FromStr(byval strIn as wstring ptr, byval lcid as LCID, byval dwFlags as ULONG, byval plOut as LONG ptr) as HRESULT
declare function VarI4FromDisp(byval pdispIn as IDispatch ptr, byval lcid as LCID, byval plOut as LONG ptr) as HRESULT
declare function VarI4FromBool(byval boolIn as VARIANT_BOOL, byval plOut as LONG ptr) as HRESULT
declare function VarI4FromI1(byval cIn as CHAR, byval plOut as LONG ptr) as HRESULT
declare function VarI4FromUI2(byval uiIn as USHORT, byval plOut as LONG ptr) as HRESULT
declare function VarI4FromUI4(byval ulIn as ULONG, byval plOut as LONG ptr) as HRESULT
declare function VarI4FromUI8(byval ui64In as ULONG64, byval plOut as LONG ptr) as HRESULT
declare function VarI4FromDec(byval pdecIn as DECIMAL ptr, byval plOut as LONG ptr) as HRESULT
declare function VarI4FromInt(byval intIn as INT_, byval plOut as LONG ptr) as HRESULT
declare function VarI8FromUI1(byval bIn as UBYTE, byval pi64Out as LONG64 ptr) as HRESULT
declare function VarI8FromI2(byval sIn as SHORT, byval pi64Out as LONG64 ptr) as HRESULT
declare function VarI8FromI4(byval lIn as LONG, byval pi64Out as LONG64 ptr) as HRESULT
declare function VarI8FromR4(byval fltIn as FLOAT, byval pi64Out as LONG64 ptr) as HRESULT
declare function VarI8FromR8(byval dblIn as DOUBLE, byval pi64Out as LONG64 ptr) as HRESULT
declare function VarI8FromCy(byval cyIn as CY, byval pi64Out as LONG64 ptr) as HRESULT
declare function VarI8FromDate(byval dateIn as DATE_, byval pi64Out as LONG64 ptr) as HRESULT
declare function VarI8FromStr(byval strIn as wstring ptr, byval lcid as LCID, byval dwFlags as ulong, byval pi64Out as LONG64 ptr) as HRESULT
declare function VarI8FromDisp(byval pdispIn as IDispatch ptr, byval lcid as LCID, byval pi64Out as LONG64 ptr) as HRESULT
declare function VarI8FromBool(byval boolIn as VARIANT_BOOL, byval pi64Out as LONG64 ptr) as HRESULT
declare function VarI8FromI1(byval cIn as CHAR, byval pi64Out as LONG64 ptr) as HRESULT
declare function VarI8FromUI2(byval uiIn as USHORT, byval pi64Out as LONG64 ptr) as HRESULT
declare function VarI8FromUI4(byval ulIn as ULONG, byval pi64Out as LONG64 ptr) as HRESULT
declare function VarI8FromUI8(byval ui64In as ULONG64, byval pi64Out as LONG64 ptr) as HRESULT
declare function VarI8FromDec(byval pdecIn as DECIMAL ptr, byval pi64Out as LONG64 ptr) as HRESULT
declare function VarI8FromInt(byval intIn as INT_, byval pi64Out as LONG64 ptr) as HRESULT
declare function VarR4FromUI1(byval bIn as UBYTE, byval pfltOut as FLOAT ptr) as HRESULT
declare function VarR4FromI2(byval sIn as SHORT, byval pfltOut as FLOAT ptr) as HRESULT
declare function VarR4FromI4(byval lIn as LONG, byval pfltOut as FLOAT ptr) as HRESULT
declare function VarR4FromI8(byval i64In as LONG64, byval pfltOut as FLOAT ptr) as HRESULT
declare function VarR4FromR8(byval dblIn as DOUBLE, byval pfltOut as FLOAT ptr) as HRESULT
declare function VarR4FromCy(byval cyIn as CY, byval pfltOut as FLOAT ptr) as HRESULT
declare function VarR4FromDate(byval dateIn as DATE_, byval pfltOut as FLOAT ptr) as HRESULT
declare function VarR4FromStr(byval strIn as wstring ptr, byval lcid as LCID, byval dwFlags as ULONG, byval pfltOut as FLOAT ptr) as HRESULT
declare function VarR4FromDisp(byval pdispIn as IDispatch ptr, byval lcid as LCID, byval pfltOut as FLOAT ptr) as HRESULT
declare function VarR4FromBool(byval boolIn as VARIANT_BOOL, byval pfltOut as FLOAT ptr) as HRESULT
declare function VarR4FromI1(byval cIn as CHAR, byval pfltOut as FLOAT ptr) as HRESULT
declare function VarR4FromUI2(byval uiIn as USHORT, byval pfltOut as FLOAT ptr) as HRESULT
declare function VarR4FromUI4(byval ulIn as ULONG, byval pfltOut as FLOAT ptr) as HRESULT
declare function VarR4FromUI8(byval ui64In as ULONG64, byval pfltOut as FLOAT ptr) as HRESULT
declare function VarR4FromDec(byval pdecIn as DECIMAL ptr, byval pfltOut as FLOAT ptr) as HRESULT
declare function VarR8FromUI1(byval bIn as UBYTE, byval pdblOut as DOUBLE ptr) as HRESULT
declare function VarR8FromI2(byval sIn as SHORT, byval pdblOut as DOUBLE ptr) as HRESULT
declare function VarR8FromI4(byval lIn as LONG, byval pdblOut as DOUBLE ptr) as HRESULT
declare function VarR8FromI8(byval i64In as LONG64, byval pdblOut as DOUBLE ptr) as HRESULT
declare function VarR8FromR4(byval fltIn as FLOAT, byval pdblOut as DOUBLE ptr) as HRESULT
declare function VarR8FromCy(byval cyIn as CY, byval pdblOut as DOUBLE ptr) as HRESULT
declare function VarR8FromDate(byval dateIn as DATE_, byval pdblOut as DOUBLE ptr) as HRESULT
declare function VarR8FromStr(byval strIn as wstring ptr, byval lcid as LCID, byval dwFlags as ULONG, byval pdblOut as DOUBLE ptr) as HRESULT
declare function VarR8FromDisp(byval pdispIn as IDispatch ptr, byval lcid as LCID, byval pdblOut as DOUBLE ptr) as HRESULT
declare function VarR8FromBool(byval boolIn as VARIANT_BOOL, byval pdblOut as DOUBLE ptr) as HRESULT
declare function VarR8FromI1(byval cIn as CHAR, byval pdblOut as DOUBLE ptr) as HRESULT
declare function VarR8FromUI2(byval uiIn as USHORT, byval pdblOut as DOUBLE ptr) as HRESULT
declare function VarR8FromUI4(byval ulIn as ULONG, byval pdblOut as DOUBLE ptr) as HRESULT
declare function VarR8FromUI8(byval ui64In as ULONG64, byval pdblOut as DOUBLE ptr) as HRESULT
declare function VarR8FromDec(byval pdecIn as DECIMAL ptr, byval pdblOut as DOUBLE ptr) as HRESULT
declare function VarDateFromUI1(byval bIn as UBYTE, byval pdateOut as DATE_ ptr) as HRESULT
declare function VarDateFromI2(byval sIn as SHORT, byval pdateOut as DATE_ ptr) as HRESULT
declare function VarDateFromI4(byval lIn as LONG, byval pdateOut as DATE_ ptr) as HRESULT
declare function VarDateFromI8(byval i64In as LONG64, byval pdateOut as DATE_ ptr) as HRESULT
declare function VarDateFromR4(byval fltIn as FLOAT, byval pdateOut as DATE_ ptr) as HRESULT
declare function VarDateFromR8(byval dblIn as DOUBLE, byval pdateOut as DATE_ ptr) as HRESULT
declare function VarDateFromCy(byval cyIn as CY, byval pdateOut as DATE_ ptr) as HRESULT
declare function VarDateFromStr(byval strIn as wstring ptr, byval lcid as LCID, byval dwFlags as ULONG, byval pdateOut as DATE_ ptr) as HRESULT
declare function VarDateFromDisp(byval pdispIn as IDispatch ptr, byval lcid as LCID, byval pdateOut as DATE_ ptr) as HRESULT
declare function VarDateFromBool(byval boolIn as VARIANT_BOOL, byval pdateOut as DATE_ ptr) as HRESULT
declare function VarDateFromI1(byval cIn as CHAR, byval pdateOut as DATE_ ptr) as HRESULT
declare function VarDateFromUI2(byval uiIn as USHORT, byval pdateOut as DATE_ ptr) as HRESULT
declare function VarDateFromUI4(byval ulIn as ULONG, byval pdateOut as DATE_ ptr) as HRESULT
declare function VarDateFromUI8(byval ui64In as ULONG64, byval pdateOut as DATE_ ptr) as HRESULT
declare function VarDateFromDec(byval pdecIn as DECIMAL ptr, byval pdateOut as DATE_ ptr) as HRESULT
declare function VarCyFromUI1(byval bIn as UBYTE, byval pcyOut as CY ptr) as HRESULT
declare function VarCyFromI2(byval sIn as SHORT, byval pcyOut as CY ptr) as HRESULT
declare function VarCyFromI4(byval lIn as LONG, byval pcyOut as CY ptr) as HRESULT
declare function VarCyFromI8(byval i64In as LONG64, byval pcyOut as CY ptr) as HRESULT
declare function VarCyFromR4(byval fltIn as FLOAT, byval pcyOut as CY ptr) as HRESULT
declare function VarCyFromR8(byval dblIn as DOUBLE, byval pcyOut as CY ptr) as HRESULT
declare function VarCyFromDate(byval dateIn as DATE_, byval pcyOut as CY ptr) as HRESULT
declare function VarCyFromStr(byval strIn as wstring ptr, byval lcid as LCID, byval dwFlags as ULONG, byval pcyOut as CY ptr) as HRESULT
declare function VarCyFromDisp(byval pdispIn as IDispatch ptr, byval lcid as LCID, byval pcyOut as CY ptr) as HRESULT
declare function VarCyFromBool(byval boolIn as VARIANT_BOOL, byval pcyOut as CY ptr) as HRESULT
declare function VarCyFromI1(byval cIn as CHAR, byval pcyOut as CY ptr) as HRESULT
declare function VarCyFromUI2(byval uiIn as USHORT, byval pcyOut as CY ptr) as HRESULT
declare function VarCyFromUI4(byval ulIn as ULONG, byval pcyOut as CY ptr) as HRESULT
declare function VarCyFromUI8(byval ui64In as ULONG64, byval pcyOut as CY ptr) as HRESULT
declare function VarCyFromDec(byval pdecIn as DECIMAL ptr, byval pcyOut as CY ptr) as HRESULT
declare function VarBstrFromUI1(byval bVal as UBYTE, byval lcid as LCID, byval dwFlags as ULONG, byval pbstrOut as BSTR ptr) as HRESULT
declare function VarBstrFromI2(byval iVal as SHORT, byval lcid as LCID, byval dwFlags as ULONG, byval pbstrOut as BSTR ptr) as HRESULT
declare function VarBstrFromI4(byval lIn as LONG, byval lcid as LCID, byval dwFlags as ULONG, byval pbstrOut as BSTR ptr) as HRESULT
declare function VarBstrFromI8(byval i64In as LONG64, byval lcid as LCID, byval dwFlags as ulong, byval pbstrOut as BSTR ptr) as HRESULT
declare function VarBstrFromR4(byval fltIn as FLOAT, byval lcid as LCID, byval dwFlags as ULONG, byval pbstrOut as BSTR ptr) as HRESULT
declare function VarBstrFromR8(byval dblIn as DOUBLE, byval lcid as LCID, byval dwFlags as ULONG, byval pbstrOut as BSTR ptr) as HRESULT
declare function VarBstrFromCy(byval cyIn as CY, byval lcid as LCID, byval dwFlags as ULONG, byval pbstrOut as BSTR ptr) as HRESULT
declare function VarBstrFromDate(byval dateIn as DATE_, byval lcid as LCID, byval dwFlags as ULONG, byval pbstrOut as BSTR ptr) as HRESULT
declare function VarBstrFromDisp(byval pdispIn as IDispatch ptr, byval lcid as LCID, byval dwFlags as ULONG, byval pbstrOut as BSTR ptr) as HRESULT
declare function VarBstrFromBool(byval boolIn as VARIANT_BOOL, byval lcid as LCID, byval dwFlags as ULONG, byval pbstrOut as BSTR ptr) as HRESULT
declare function VarBstrFromI1(byval cIn as CHAR, byval lcid as LCID, byval dwFlags as ULONG, byval pbstrOut as BSTR ptr) as HRESULT
declare function VarBstrFromUI2(byval uiIn as USHORT, byval lcid as LCID, byval dwFlags as ULONG, byval pbstrOut as BSTR ptr) as HRESULT
declare function VarBstrFromUI4(byval ulIn as ULONG, byval lcid as LCID, byval dwFlags as ULONG, byval pbstrOut as BSTR ptr) as HRESULT
declare function VarBstrFromUI8(byval ui64In as ULONG64, byval lcid as LCID, byval dwFlags as ulong, byval pbstrOut as BSTR ptr) as HRESULT
declare function VarBstrFromDec(byval pdecIn as DECIMAL ptr, byval lcid as LCID, byval dwFlags as ULONG, byval pbstrOut as BSTR ptr) as HRESULT
declare function VarBoolFromUI1(byval bIn as UBYTE, byval pboolOut as VARIANT_BOOL ptr) as HRESULT
declare function VarBoolFromI2(byval sIn as SHORT, byval pboolOut as VARIANT_BOOL ptr) as HRESULT
declare function VarBoolFromI4(byval lIn as LONG, byval pboolOut as VARIANT_BOOL ptr) as HRESULT
declare function VarBoolFromI8(byval i64In as LONG64, byval pboolOut as VARIANT_BOOL ptr) as HRESULT
declare function VarBoolFromR4(byval fltIn as FLOAT, byval pboolOut as VARIANT_BOOL ptr) as HRESULT
declare function VarBoolFromR8(byval dblIn as DOUBLE, byval pboolOut as VARIANT_BOOL ptr) as HRESULT
declare function VarBoolFromDate(byval dateIn as DATE_, byval pboolOut as VARIANT_BOOL ptr) as HRESULT
declare function VarBoolFromCy(byval cyIn as CY, byval pboolOut as VARIANT_BOOL ptr) as HRESULT
declare function VarBoolFromStr(byval strIn as wstring ptr, byval lcid as LCID, byval dwFlags as ULONG, byval pboolOut as VARIANT_BOOL ptr) as HRESULT
declare function VarBoolFromDisp(byval pdispIn as IDispatch ptr, byval lcid as LCID, byval pboolOut as VARIANT_BOOL ptr) as HRESULT
declare function VarBoolFromI1(byval cIn as CHAR, byval pboolOut as VARIANT_BOOL ptr) as HRESULT
declare function VarBoolFromUI2(byval uiIn as USHORT, byval pboolOut as VARIANT_BOOL ptr) as HRESULT
declare function VarBoolFromUI4(byval ulIn as ULONG, byval pboolOut as VARIANT_BOOL ptr) as HRESULT
declare function VarBoolFromUI8(byval i64In as ULONG64, byval pboolOut as VARIANT_BOOL ptr) as HRESULT
declare function VarBoolFromDec(byval pdecIn as DECIMAL ptr, byval pboolOut as VARIANT_BOOL ptr) as HRESULT
declare function VarI1FromUI1(byval bIn as UBYTE, byval pcOut as CHAR ptr) as HRESULT
declare function VarI1FromI2(byval uiIn as SHORT, byval pcOut as CHAR ptr) as HRESULT
declare function VarI1FromI4(byval lIn as LONG, byval pcOut as CHAR ptr) as HRESULT
declare function VarI1FromI8(byval i64In as LONG64, byval pcOut as CHAR ptr) as HRESULT
declare function VarI1FromR4(byval fltIn as FLOAT, byval pcOut as CHAR ptr) as HRESULT
declare function VarI1FromR8(byval dblIn as DOUBLE, byval pcOut as CHAR ptr) as HRESULT
declare function VarI1FromDate(byval dateIn as DATE_, byval pcOut as CHAR ptr) as HRESULT
declare function VarI1FromCy(byval cyIn as CY, byval pcOut as CHAR ptr) as HRESULT
declare function VarI1FromStr(byval strIn as wstring ptr, byval lcid as LCID, byval dwFlags as ULONG, byval pcOut as CHAR ptr) as HRESULT
declare function VarI1FromDisp(byval pdispIn as IDispatch ptr, byval lcid as LCID, byval pcOut as CHAR ptr) as HRESULT
declare function VarI1FromBool(byval boolIn as VARIANT_BOOL, byval pcOut as CHAR ptr) as HRESULT
declare function VarI1FromUI2(byval uiIn as USHORT, byval pcOut as CHAR ptr) as HRESULT
declare function VarI1FromUI4(byval ulIn as ULONG, byval pcOut as CHAR ptr) as HRESULT
declare function VarI1FromUI8(byval i64In as ULONG64, byval pcOut as CHAR ptr) as HRESULT
declare function VarI1FromDec(byval pdecIn as DECIMAL ptr, byval pcOut as CHAR ptr) as HRESULT
declare function VarUI2FromUI1(byval bIn as UBYTE, byval puiOut as USHORT ptr) as HRESULT
declare function VarUI2FromI2(byval uiIn as SHORT, byval puiOut as USHORT ptr) as HRESULT
declare function VarUI2FromI4(byval lIn as LONG, byval puiOut as USHORT ptr) as HRESULT
declare function VarUI2FromI8(byval i64In as LONG64, byval puiOut as USHORT ptr) as HRESULT
declare function VarUI2FromR4(byval fltIn as FLOAT, byval puiOut as USHORT ptr) as HRESULT
declare function VarUI2FromR8(byval dblIn as DOUBLE, byval puiOut as USHORT ptr) as HRESULT
declare function VarUI2FromDate(byval dateIn as DATE_, byval puiOut as USHORT ptr) as HRESULT
declare function VarUI2FromCy(byval cyIn as CY, byval puiOut as USHORT ptr) as HRESULT
declare function VarUI2FromStr(byval strIn as wstring ptr, byval lcid as LCID, byval dwFlags as ULONG, byval puiOut as USHORT ptr) as HRESULT
declare function VarUI2FromDisp(byval pdispIn as IDispatch ptr, byval lcid as LCID, byval puiOut as USHORT ptr) as HRESULT
declare function VarUI2FromBool(byval boolIn as VARIANT_BOOL, byval puiOut as USHORT ptr) as HRESULT
declare function VarUI2FromI1(byval cIn as CHAR, byval puiOut as USHORT ptr) as HRESULT
declare function VarUI2FromUI4(byval ulIn as ULONG, byval puiOut as USHORT ptr) as HRESULT
declare function VarUI2FromUI8(byval i64In as ULONG64, byval puiOut as USHORT ptr) as HRESULT
declare function VarUI2FromDec(byval pdecIn as DECIMAL ptr, byval puiOut as USHORT ptr) as HRESULT
declare function VarUI4FromUI1(byval bIn as UBYTE, byval pulOut as ULONG ptr) as HRESULT
declare function VarUI4FromI2(byval uiIn as SHORT, byval pulOut as ULONG ptr) as HRESULT
declare function VarUI4FromI4(byval lIn as LONG, byval pulOut as ULONG ptr) as HRESULT
declare function VarUI4FromI8(byval i64In as LONG64, byval plOut as ULONG ptr) as HRESULT
declare function VarUI4FromR4(byval fltIn as FLOAT, byval pulOut as ULONG ptr) as HRESULT
declare function VarUI4FromR8(byval dblIn as DOUBLE, byval pulOut as ULONG ptr) as HRESULT
declare function VarUI4FromDate(byval dateIn as DATE_, byval pulOut as ULONG ptr) as HRESULT
declare function VarUI4FromCy(byval cyIn as CY, byval pulOut as ULONG ptr) as HRESULT
declare function VarUI4FromStr(byval strIn as wstring ptr, byval lcid as LCID, byval dwFlags as ULONG, byval pulOut as ULONG ptr) as HRESULT
declare function VarUI4FromDisp(byval pdispIn as IDispatch ptr, byval lcid as LCID, byval pulOut as ULONG ptr) as HRESULT
declare function VarUI4FromBool(byval boolIn as VARIANT_BOOL, byval pulOut as ULONG ptr) as HRESULT
declare function VarUI4FromI1(byval cIn as CHAR, byval pulOut as ULONG ptr) as HRESULT
declare function VarUI4FromUI2(byval uiIn as USHORT, byval pulOut as ULONG ptr) as HRESULT
declare function VarUI4FromUI8(byval ui64In as ULONG64, byval plOut as ULONG ptr) as HRESULT
declare function VarUI4FromDec(byval pdecIn as DECIMAL ptr, byval pulOut as ULONG ptr) as HRESULT
declare function VarUI8FromUI1(byval bIn as UBYTE, byval pi64Out as ULONG64 ptr) as HRESULT
declare function VarUI8FromI2(byval sIn as SHORT, byval pi64Out as ULONG64 ptr) as HRESULT
declare function VarUI8FromI4(byval lIn as LONG, byval pi64Out as ULONG64 ptr) as HRESULT
declare function VarUI8FromI8(byval ui64In as LONG64, byval pi64Out as ULONG64 ptr) as HRESULT
declare function VarUI8FromR4(byval fltIn as FLOAT, byval pi64Out as ULONG64 ptr) as HRESULT
declare function VarUI8FromR8(byval dblIn as DOUBLE, byval pi64Out as ULONG64 ptr) as HRESULT
declare function VarUI8FromCy(byval cyIn as CY, byval pi64Out as ULONG64 ptr) as HRESULT
declare function VarUI8FromDate(byval dateIn as DATE_, byval pi64Out as ULONG64 ptr) as HRESULT
declare function VarUI8FromStr(byval strIn as wstring ptr, byval lcid as LCID, byval dwFlags as ulong, byval pi64Out as ULONG64 ptr) as HRESULT
declare function VarUI8FromDisp(byval pdispIn as IDispatch ptr, byval lcid as LCID, byval pi64Out as ULONG64 ptr) as HRESULT
declare function VarUI8FromBool(byval boolIn as VARIANT_BOOL, byval pi64Out as ULONG64 ptr) as HRESULT
declare function VarUI8FromI1(byval cIn as CHAR, byval pi64Out as ULONG64 ptr) as HRESULT
declare function VarUI8FromUI2(byval uiIn as USHORT, byval pi64Out as ULONG64 ptr) as HRESULT
declare function VarUI8FromUI4(byval ulIn as ULONG, byval pi64Out as ULONG64 ptr) as HRESULT
declare function VarUI8FromDec(byval pdecIn as DECIMAL ptr, byval pi64Out as ULONG64 ptr) as HRESULT
declare function VarUI8FromInt(byval intIn as INT_, byval pi64Out as ULONG64 ptr) as HRESULT
declare function VarDecFromUI1(byval bIn as UBYTE, byval pdecOut as DECIMAL ptr) as HRESULT
declare function VarDecFromI2(byval uiIn as SHORT, byval pdecOut as DECIMAL ptr) as HRESULT
declare function VarDecFromI4(byval lIn as LONG, byval pdecOut as DECIMAL ptr) as HRESULT
declare function VarDecFromI8(byval i64In as LONG64, byval pdecOut as DECIMAL ptr) as HRESULT
declare function VarDecFromR4(byval fltIn as FLOAT, byval pdecOut as DECIMAL ptr) as HRESULT
declare function VarDecFromR8(byval dblIn as DOUBLE, byval pdecOut as DECIMAL ptr) as HRESULT
declare function VarDecFromDate(byval dateIn as DATE_, byval pdecOut as DECIMAL ptr) as HRESULT
declare function VarDecFromCy(byval cyIn as CY, byval pdecOut as DECIMAL ptr) as HRESULT
declare function VarDecFromStr(byval strIn as wstring ptr, byval lcid as LCID, byval dwFlags as ULONG, byval pdecOut as DECIMAL ptr) as HRESULT
declare function VarDecFromDisp(byval pdispIn as IDispatch ptr, byval lcid as LCID, byval pdecOut as DECIMAL ptr) as HRESULT
declare function VarDecFromBool(byval boolIn as VARIANT_BOOL, byval pdecOut as DECIMAL ptr) as HRESULT
declare function VarDecFromI1(byval cIn as CHAR, byval pdecOut as DECIMAL ptr) as HRESULT
declare function VarDecFromUI2(byval uiIn as USHORT, byval pdecOut as DECIMAL ptr) as HRESULT
declare function VarDecFromUI4(byval ulIn as ULONG, byval pdecOut as DECIMAL ptr) as HRESULT
declare function VarDecFromUI8(byval ui64In as ULONG64, byval pdecOut as DECIMAL ptr) as HRESULT
#define VarUI4FromUI4(in, pOut) scope : (*(pOut)) = (in) : end scope
#define VarI4FromI4(in, pOut) scope : (*(pOut)) = (in) : end scope
#define VarUI8FromUI8(in, pOut) scope : (*(pOut)) = (in) : end scope
#define VarI8FromI8(in, pOut) scope : (*(pOut)) = (in) : end scope
declare function VarUI1FromInt alias "VarUI1FromI4"(byval lIn as LONG, byval pbOut as UBYTE ptr) as HRESULT
declare function VarUI1FromUint alias "VarUI1FromUI4"(byval ulIn as ULONG, byval pbOut as UBYTE ptr) as HRESULT
declare function VarI2FromInt alias "VarI2FromI4"(byval lIn as LONG, byval psOut as SHORT ptr) as HRESULT
declare function VarI2FromUint alias "VarI2FromUI4"(byval ulIn as ULONG, byval psOut as SHORT ptr) as HRESULT
declare function VarI4FromUint alias "VarI4FromUI4"(byval ulIn as ULONG, byval plOut as LONG ptr) as HRESULT
declare function VarI8FromUint alias "VarI8FromUI4"(byval ulIn as ULONG, byval pi64Out as LONG64 ptr) as HRESULT
declare function VarR4FromInt alias "VarR4FromI4"(byval lIn as LONG, byval pfltOut as FLOAT ptr) as HRESULT
declare function VarR4FromUint alias "VarR4FromUI4"(byval ulIn as ULONG, byval pfltOut as FLOAT ptr) as HRESULT
declare function VarR8FromInt alias "VarR8FromI4"(byval lIn as LONG, byval pdblOut as DOUBLE ptr) as HRESULT
declare function VarR8FromUint alias "VarR8FromUI4"(byval ulIn as ULONG, byval pdblOut as DOUBLE ptr) as HRESULT
declare function VarDateFromInt alias "VarDateFromI4"(byval lIn as LONG, byval pdateOut as DATE_ ptr) as HRESULT
declare function VarDateFromUint alias "VarDateFromUI4"(byval ulIn as ULONG, byval pdateOut as DATE_ ptr) as HRESULT
declare function VarCyFromInt alias "VarCyFromI4"(byval lIn as LONG, byval pcyOut as CY ptr) as HRESULT
declare function VarCyFromUint alias "VarCyFromUI4"(byval ulIn as ULONG, byval pcyOut as CY ptr) as HRESULT
declare function VarBstrFromInt alias "VarBstrFromI4"(byval lIn as LONG, byval lcid as LCID, byval dwFlags as ULONG, byval pbstrOut as BSTR ptr) as HRESULT
declare function VarBstrFromUint alias "VarBstrFromUI4"(byval ulIn as ULONG, byval lcid as LCID, byval dwFlags as ULONG, byval pbstrOut as BSTR ptr) as HRESULT
declare function VarBoolFromInt alias "VarBoolFromI4"(byval lIn as LONG, byval pboolOut as VARIANT_BOOL ptr) as HRESULT
declare function VarBoolFromUint alias "VarBoolFromUI4"(byval ulIn as ULONG, byval pboolOut as VARIANT_BOOL ptr) as HRESULT
declare function VarI1FromInt alias "VarI1FromI4"(byval lIn as LONG, byval pcOut as CHAR ptr) as HRESULT
declare function VarI1FromUint alias "VarI1FromUI4"(byval ulIn as ULONG, byval pcOut as CHAR ptr) as HRESULT
declare function VarUI2FromInt alias "VarUI2FromI4"(byval lIn as LONG, byval puiOut as USHORT ptr) as HRESULT
declare function VarUI2FromUint alias "VarUI2FromUI4"(byval ulIn as ULONG, byval puiOut as USHORT ptr) as HRESULT
declare function VarUI4FromInt alias "VarUI4FromI4"(byval lIn as LONG, byval pulOut as ULONG ptr) as HRESULT
#define VarUI4FromUint VarUI4FromUI4
declare function VarDecFromInt alias "VarDecFromI4"(byval lIn as LONG, byval pdecOut as DECIMAL ptr) as HRESULT
declare function VarDecFromUint alias "VarDecFromUI4"(byval ulIn as ULONG, byval pdecOut as DECIMAL ptr) as HRESULT
declare function VarIntFromUI1 alias "VarI4FromUI1"(byval bIn as UBYTE, byval plOut as LONG ptr) as HRESULT
declare function VarIntFromI2 alias "VarI4FromI2"(byval sIn as SHORT, byval plOut as LONG ptr) as HRESULT
#define VarIntFromI4 VarI4FromI4
#define VarIntFromI8 VarI4FromI8
declare function VarIntFromR4 alias "VarI4FromR4"(byval fltIn as FLOAT, byval plOut as LONG ptr) as HRESULT
declare function VarIntFromR8 alias "VarI4FromR8"(byval dblIn as DOUBLE, byval plOut as LONG ptr) as HRESULT
declare function VarIntFromDate alias "VarI4FromDate"(byval dateIn as DATE_, byval plOut as LONG ptr) as HRESULT
declare function VarIntFromCy alias "VarI4FromCy"(byval cyIn as CY, byval plOut as LONG ptr) as HRESULT
declare function VarIntFromStr alias "VarI4FromStr"(byval strIn as wstring ptr, byval lcid as LCID, byval dwFlags as ULONG, byval plOut as LONG ptr) as HRESULT
declare function VarIntFromDisp alias "VarI4FromDisp"(byval pdispIn as IDispatch ptr, byval lcid as LCID, byval plOut as LONG ptr) as HRESULT
declare function VarIntFromBool alias "VarI4FromBool"(byval boolIn as VARIANT_BOOL, byval plOut as LONG ptr) as HRESULT
declare function VarIntFromI1 alias "VarI4FromI1"(byval cIn as CHAR, byval plOut as LONG ptr) as HRESULT
declare function VarIntFromUI2 alias "VarI4FromUI2"(byval uiIn as USHORT, byval plOut as LONG ptr) as HRESULT
declare function VarIntFromUI4 alias "VarI4FromUI4"(byval ulIn as ULONG, byval plOut as LONG ptr) as HRESULT
#define VarIntFromUI8 VarI4FromUI8
declare function VarIntFromDec alias "VarI4FromDec"(byval pdecIn as DECIMAL ptr, byval plOut as LONG ptr) as HRESULT
declare function VarIntFromUint alias "VarI4FromUI4"(byval ulIn as ULONG, byval plOut as LONG ptr) as HRESULT
declare function VarUintFromUI1 alias "VarUI4FromUI1"(byval bIn as UBYTE, byval pulOut as ULONG ptr) as HRESULT
declare function VarUintFromI2 alias "VarUI4FromI2"(byval uiIn as SHORT, byval pulOut as ULONG ptr) as HRESULT
declare function VarUintFromI4 alias "VarUI4FromI4"(byval lIn as LONG, byval pulOut as ULONG ptr) as HRESULT
declare function VarUintFromI8 alias "VarUI4FromI8"(byval i64In as LONG64, byval plOut as ULONG ptr) as HRESULT
declare function VarUintFromR4 alias "VarUI4FromR4"(byval fltIn as FLOAT, byval pulOut as ULONG ptr) as HRESULT
declare function VarUintFromR8 alias "VarUI4FromR8"(byval dblIn as DOUBLE, byval pulOut as ULONG ptr) as HRESULT
declare function VarUintFromDate alias "VarUI4FromDate"(byval dateIn as DATE_, byval pulOut as ULONG ptr) as HRESULT
declare function VarUintFromCy alias "VarUI4FromCy"(byval cyIn as CY, byval pulOut as ULONG ptr) as HRESULT
declare function VarUintFromStr alias "VarUI4FromStr"(byval strIn as wstring ptr, byval lcid as LCID, byval dwFlags as ULONG, byval pulOut as ULONG ptr) as HRESULT
declare function VarUintFromDisp alias "VarUI4FromDisp"(byval pdispIn as IDispatch ptr, byval lcid as LCID, byval pulOut as ULONG ptr) as HRESULT
declare function VarUintFromBool alias "VarUI4FromBool"(byval boolIn as VARIANT_BOOL, byval pulOut as ULONG ptr) as HRESULT
declare function VarUintFromI1 alias "VarUI4FromI1"(byval cIn as CHAR, byval pulOut as ULONG ptr) as HRESULT
declare function VarUintFromUI2 alias "VarUI4FromUI2"(byval uiIn as USHORT, byval pulOut as ULONG ptr) as HRESULT
#define VarUintFromUI4 VarUI4FromUI4
declare function VarUintFromUI8 alias "VarUI4FromUI8"(byval ui64In as ULONG64, byval plOut as ULONG ptr) as HRESULT
declare function VarUintFromDec alias "VarUI4FromDec"(byval pdecIn as DECIMAL ptr, byval pulOut as ULONG ptr) as HRESULT
declare function VarUintFromInt alias "VarUI4FromI4"(byval lIn as LONG, byval pulOut as ULONG ptr) as HRESULT

type NUMPARSE
	cDig as INT_
	dwInFlags as ULONG
	dwOutFlags as ULONG
	cchUsed as INT_
	nBaseShift as INT_
	nPwr10 as INT_
end type

const NUMPRS_LEADING_WHITE = &h0001
const NUMPRS_TRAILING_WHITE = &h0002
const NUMPRS_LEADING_PLUS = &h0004
const NUMPRS_TRAILING_PLUS = &h0008
const NUMPRS_LEADING_MINUS = &h0010
const NUMPRS_TRAILING_MINUS = &h0020
const NUMPRS_HEX_OCT = &h0040
const NUMPRS_PARENS = &h0080
const NUMPRS_DECIMAL = &h0100
const NUMPRS_THOUSANDS = &h0200
const NUMPRS_CURRENCY = &h0400
const NUMPRS_EXPONENT = &h0800
const NUMPRS_USE_ALL = &h1000
const NUMPRS_STD = &h1FFF
const NUMPRS_NEG = &h10000
const NUMPRS_INEXACT = &h20000
const VTBIT_I1 = 1 shl VT_I1
const VTBIT_UI1 = 1 shl VT_UI1
const VTBIT_I2 = 1 shl VT_I2
const VTBIT_UI2 = 1 shl VT_UI2
const VTBIT_I4 = 1 shl VT_I4
const VTBIT_UI4 = 1 shl VT_UI4
const VTBIT_I8 = 1 shl VT_I8
const VTBIT_UI8 = 1 shl VT_UI8
const VTBIT_R4 = 1 shl VT_R4
const VTBIT_R8 = 1 shl VT_R8
const VTBIT_CY = 1 shl VT_CY
const VTBIT_DECIMAL = 1 shl VT_DECIMAL

declare function VarParseNumFromStr(byval strIn as wstring ptr, byval lcid as LCID, byval dwFlags as ULONG, byval pnumprs as NUMPARSE ptr, byval rgbDig as UBYTE ptr) as HRESULT
declare function VarNumFromParseNum(byval pnumprs as NUMPARSE ptr, byval rgbDig as UBYTE ptr, byval dwVtBits as ULONG, byval pvar as VARIANT ptr) as HRESULT
declare function VarAdd(byval pvarLeft as LPVARIANT, byval pvarRight as LPVARIANT, byval pvarResult as LPVARIANT) as HRESULT
declare function VarAnd(byval pvarLeft as LPVARIANT, byval pvarRight as LPVARIANT, byval pvarResult as LPVARIANT) as HRESULT
declare function VarCat(byval pvarLeft as LPVARIANT, byval pvarRight as LPVARIANT, byval pvarResult as LPVARIANT) as HRESULT
declare function VarDiv(byval pvarLeft as LPVARIANT, byval pvarRight as LPVARIANT, byval pvarResult as LPVARIANT) as HRESULT
declare function VarEqv(byval pvarLeft as LPVARIANT, byval pvarRight as LPVARIANT, byval pvarResult as LPVARIANT) as HRESULT
declare function VarIdiv(byval pvarLeft as LPVARIANT, byval pvarRight as LPVARIANT, byval pvarResult as LPVARIANT) as HRESULT
declare function VarImp(byval pvarLeft as LPVARIANT, byval pvarRight as LPVARIANT, byval pvarResult as LPVARIANT) as HRESULT
declare function VarMod(byval pvarLeft as LPVARIANT, byval pvarRight as LPVARIANT, byval pvarResult as LPVARIANT) as HRESULT
declare function VarMul(byval pvarLeft as LPVARIANT, byval pvarRight as LPVARIANT, byval pvarResult as LPVARIANT) as HRESULT
declare function VarOr(byval pvarLeft as LPVARIANT, byval pvarRight as LPVARIANT, byval pvarResult as LPVARIANT) as HRESULT
declare function VarPow(byval pvarLeft as LPVARIANT, byval pvarRight as LPVARIANT, byval pvarResult as LPVARIANT) as HRESULT
declare function VarSub(byval pvarLeft as LPVARIANT, byval pvarRight as LPVARIANT, byval pvarResult as LPVARIANT) as HRESULT
declare function VarXor(byval pvarLeft as LPVARIANT, byval pvarRight as LPVARIANT, byval pvarResult as LPVARIANT) as HRESULT
declare function VarAbs(byval pvarIn as LPVARIANT, byval pvarResult as LPVARIANT) as HRESULT
declare function VarFix(byval pvarIn as LPVARIANT, byval pvarResult as LPVARIANT) as HRESULT
declare function VarInt(byval pvarIn as LPVARIANT, byval pvarResult as LPVARIANT) as HRESULT
declare function VarNeg(byval pvarIn as LPVARIANT, byval pvarResult as LPVARIANT) as HRESULT
declare function VarNot(byval pvarIn as LPVARIANT, byval pvarResult as LPVARIANT) as HRESULT
declare function VarRound(byval pvarIn as LPVARIANT, byval cDecimals as long, byval pvarResult as LPVARIANT) as HRESULT
declare function VarCmp(byval pvarLeft as LPVARIANT, byval pvarRight as LPVARIANT, byval lcid as LCID, byval dwFlags as ULONG) as HRESULT
declare function VarDecAdd(byval pdecLeft as LPDECIMAL, byval pdecRight as LPDECIMAL, byval pdecResult as LPDECIMAL) as HRESULT
declare function VarDecDiv(byval pdecLeft as LPDECIMAL, byval pdecRight as LPDECIMAL, byval pdecResult as LPDECIMAL) as HRESULT
declare function VarDecMul(byval pdecLeft as LPDECIMAL, byval pdecRight as LPDECIMAL, byval pdecResult as LPDECIMAL) as HRESULT
declare function VarDecSub(byval pdecLeft as LPDECIMAL, byval pdecRight as LPDECIMAL, byval pdecResult as LPDECIMAL) as HRESULT
declare function VarDecAbs(byval pdecIn as LPDECIMAL, byval pdecResult as LPDECIMAL) as HRESULT
declare function VarDecFix(byval pdecIn as LPDECIMAL, byval pdecResult as LPDECIMAL) as HRESULT
declare function VarDecInt(byval pdecIn as LPDECIMAL, byval pdecResult as LPDECIMAL) as HRESULT
declare function VarDecNeg(byval pdecIn as LPDECIMAL, byval pdecResult as LPDECIMAL) as HRESULT
declare function VarDecRound(byval pdecIn as LPDECIMAL, byval cDecimals as long, byval pdecResult as LPDECIMAL) as HRESULT
declare function VarDecCmp(byval pdecLeft as LPDECIMAL, byval pdecRight as LPDECIMAL) as HRESULT
declare function VarDecCmpR8(byval pdecLeft as LPDECIMAL, byval dblRight as double) as HRESULT
declare function VarCyAdd(byval cyLeft as CY, byval cyRight as CY, byval pcyResult as LPCY) as HRESULT
declare function VarCyMul(byval cyLeft as CY, byval cyRight as CY, byval pcyResult as LPCY) as HRESULT
declare function VarCyMulI4(byval cyLeft as CY, byval lRight as long, byval pcyResult as LPCY) as HRESULT
declare function VarCyMulI8(byval cyLeft as CY, byval lRight as LONG64, byval pcyResult as LPCY) as HRESULT
declare function VarCySub(byval cyLeft as CY, byval cyRight as CY, byval pcyResult as LPCY) as HRESULT
declare function VarCyAbs(byval cyIn as CY, byval pcyResult as LPCY) as HRESULT
declare function VarCyFix(byval cyIn as CY, byval pcyResult as LPCY) as HRESULT
declare function VarCyInt(byval cyIn as CY, byval pcyResult as LPCY) as HRESULT
declare function VarCyNeg(byval cyIn as CY, byval pcyResult as LPCY) as HRESULT
declare function VarCyRound(byval cyIn as CY, byval cDecimals as long, byval pcyResult as LPCY) as HRESULT
declare function VarCyCmp(byval cyLeft as CY, byval cyRight as CY) as HRESULT
declare function VarCyCmpR8(byval cyLeft as CY, byval dblRight as double) as HRESULT
declare function VarBstrCat(byval bstrLeft as BSTR, byval bstrRight as BSTR, byval pbstrResult as LPBSTR) as HRESULT
declare function VarBstrCmp(byval bstrLeft as BSTR, byval bstrRight as BSTR, byval lcid as LCID, byval dwFlags as ULONG) as HRESULT
declare function VarR8Pow(byval dblLeft as double, byval dblRight as double, byval pdblResult as double ptr) as HRESULT
declare function VarR4CmpR8(byval fltLeft as single, byval dblRight as double) as HRESULT
declare function VarR8Round(byval dblIn as double, byval cDecimals as long, byval pdblResult as double ptr) as HRESULT

const VARCMP_LT = 0
const VARCMP_EQ = 1
const VARCMP_GT = 2
const VARCMP_NULL = 3
const VT_HARDTYPE = VT_RESERVED

type UDATE
	st as SYSTEMTIME
	wDayOfYear as USHORT
end type

declare function VarDateFromUdate(byval pudateIn as UDATE ptr, byval dwFlags as ULONG, byval pdateOut as DATE_ ptr) as HRESULT
declare function VarDateFromUdateEx(byval pudateIn as UDATE ptr, byval lcid as LCID, byval dwFlags as ULONG, byval pdateOut as DATE_ ptr) as HRESULT
declare function VarUdateFromDate(byval dateIn as DATE_, byval dwFlags as ULONG, byval pudateOut as UDATE ptr) as HRESULT
declare function GetAltMonthNames(byval lcid as LCID, byval prgp as LPOLESTR ptr ptr) as HRESULT
declare function VarFormat(byval pvarIn as LPVARIANT, byval pstrFormat as LPOLESTR, byval iFirstDay as long, byval iFirstWeek as long, byval dwFlags as ULONG, byval pbstrOut as BSTR ptr) as HRESULT
declare function VarFormatDateTime(byval pvarIn as LPVARIANT, byval iNamedFormat as long, byval dwFlags as ULONG, byval pbstrOut as BSTR ptr) as HRESULT
declare function VarFormatNumber(byval pvarIn as LPVARIANT, byval iNumDig as long, byval iIncLead as long, byval iUseParens as long, byval iGroup as long, byval dwFlags as ULONG, byval pbstrOut as BSTR ptr) as HRESULT
declare function VarFormatPercent(byval pvarIn as LPVARIANT, byval iNumDig as long, byval iIncLead as long, byval iUseParens as long, byval iGroup as long, byval dwFlags as ULONG, byval pbstrOut as BSTR ptr) as HRESULT
declare function VarFormatCurrency(byval pvarIn as LPVARIANT, byval iNumDig as long, byval iIncLead as long, byval iUseParens as long, byval iGroup as long, byval dwFlags as ULONG, byval pbstrOut as BSTR ptr) as HRESULT
declare function VarWeekdayName(byval iWeekday as long, byval fAbbrev as long, byval iFirstDay as long, byval dwFlags as ULONG, byval pbstrOut as BSTR ptr) as HRESULT
declare function VarMonthName(byval iMonth as long, byval fAbbrev as long, byval dwFlags as ULONG, byval pbstrOut as BSTR ptr) as HRESULT
declare function VarFormatFromTokens(byval pvarIn as LPVARIANT, byval pstrFormat as LPOLESTR, byval pbTokCur as LPBYTE, byval dwFlags as ULONG, byval pbstrOut as BSTR ptr, byval lcid as LCID) as HRESULT
declare function VarTokenizeFormatString(byval pstrFormat as LPOLESTR, byval rgbTok as LPBYTE, byval cbTok as long, byval iFirstDay as long, byval iFirstWeek as long, byval lcid as LCID, byval pcbActual as long ptr) as HRESULT
#define DEFINED_LPTYPELIB
type LPTYPELIB as ITypeLib ptr
#define DEFINED_DISPID_MEMBERID
type DISPID as LONG
type MEMBERID as DISPID

const MEMBERID_NIL = DISPID_UNKNOWN
const ID_DEFAULTINST = -2
const DISPATCH_METHOD = &h1
const DISPATCH_PROPERTYGET = &h2
const DISPATCH_PROPERTYPUT = &h4
const DISPATCH_PROPERTYPUTREF = &h8
#define DEFINDE_LPTYPEINFO
type LPTYPEINFO as ITypeInfo ptr
#define DEFINED_LPTYPECOMP
type LPTYPECOMP as ITypeComp ptr
#define DEFINED_LPCREATETYPELIB
type LPCREATETYPELIB as ICreateTypeLib ptr
#define DEFINE_LPCREATETYPEINFO
type LPCREATETYPEINFO as ICreateTypeInfo ptr
declare function LHashValOfNameSysA(byval syskind as SYSKIND, byval lcid as LCID, byval szName as LPCSTR) as ULONG
declare function LHashValOfNameSys(byval syskind as SYSKIND, byval lcid as LCID, byval szName as const wstring ptr) as ULONG
#define LHashValOfName(lcid, szName) LHashValOfNameSys(SYS_WIN32, lcid, szName)
#define WHashValOfLHashVal(lhashval) cast(USHORT, &h0000ffff and (lhashval))
#define IsHashValCompatible(lhashval1, lhashval2) cast(WINBOOL, -((&h00ff0000 and (lhashval1)) = (&h00ff0000 and (lhashval2))))
declare function LoadTypeLib(byval szFile as const wstring ptr, byval pptlib as ITypeLib ptr ptr) as HRESULT

type tagREGKIND as long
enum
	REGKIND_DEFAULT
	REGKIND_REGISTER
	REGKIND_NONE
end enum

type REGKIND as tagREGKIND
const LOAD_TLB_AS_32BIT = &h20
const LOAD_TLB_AS_64BIT = &h40
const MASK_TO_RESET_TLB_BITS = not (LOAD_TLB_AS_32BIT or LOAD_TLB_AS_64BIT)

declare function LoadTypeLibEx(byval szFile as LPCOLESTR, byval regkind as REGKIND, byval pptlib as ITypeLib ptr ptr) as HRESULT
declare function LoadRegTypeLib(byval rguid as const GUID const ptr, byval wVerMajor as WORD, byval wVerMinor as WORD, byval lcid as LCID, byval pptlib as ITypeLib ptr ptr) as HRESULT
declare function QueryPathOfRegTypeLib(byval guid as const GUID const ptr, byval wMaj as USHORT, byval wMin as USHORT, byval lcid as LCID, byval lpbstrPathName as LPBSTR) as HRESULT
declare function RegisterTypeLib(byval ptlib as ITypeLib ptr, byval szFullPath as wstring ptr, byval szHelpDir as wstring ptr) as HRESULT
declare function UnRegisterTypeLib(byval libID as const GUID const ptr, byval wVerMajor as WORD, byval wVerMinor as WORD, byval lcid as LCID, byval syskind as SYSKIND) as HRESULT
declare function CreateTypeLib(byval syskind as SYSKIND, byval szFile as const wstring ptr, byval ppctlib as ICreateTypeLib ptr ptr) as HRESULT
declare function CreateTypeLib2(byval syskind as SYSKIND, byval szFile as LPCOLESTR, byval ppctlib as ICreateTypeLib2 ptr ptr) as HRESULT
#define DEFINED_LPDISPATCH
type LPDISPATCH as IDispatch ptr

type tagPARAMDATA
	szName as wstring ptr
	vt as VARTYPE
end type

type PARAMDATA as tagPARAMDATA
type LPPARAMDATA as tagPARAMDATA ptr

type tagMETHODDATA
	szName as wstring ptr
	ppdata as PARAMDATA ptr
	dispid as DISPID
	iMeth as UINT
	cc as CALLCONV
	cArgs as UINT
	wFlags as WORD
	vtReturn as VARTYPE
end type

type METHODDATA as tagMETHODDATA
type LPMETHODDATA as tagMETHODDATA ptr

type tagINTERFACEDATA
	pmethdata as METHODDATA ptr
	cMembers as UINT
end type

type INTERFACEDATA as tagINTERFACEDATA
type LPINTERFACEDATA as tagINTERFACEDATA ptr
declare function DispGetParam(byval pdispparams as DISPPARAMS ptr, byval position as UINT, byval vtTarg as VARTYPE, byval pvarResult as VARIANT ptr, byval puArgErr as UINT ptr) as HRESULT
declare function DispGetIDsOfNames(byval ptinfo as ITypeInfo ptr, byval rgszNames as wstring ptr ptr, byval cNames as UINT, byval rgdispid as DISPID ptr) as HRESULT
declare function DispInvoke(byval _this as any ptr, byval ptinfo as ITypeInfo ptr, byval dispidMember as DISPID, byval wFlags as WORD, byval pparams as DISPPARAMS ptr, byval pvarResult as VARIANT ptr, byval pexcepinfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
declare function CreateDispTypeInfo(byval pidata as INTERFACEDATA ptr, byval lcid as LCID, byval pptinfo as ITypeInfo ptr ptr) as HRESULT
declare function CreateStdDispatch(byval punkOuter as IUnknown ptr, byval pvThis as any ptr, byval ptinfo as ITypeInfo ptr, byval ppunkStdDisp as IUnknown ptr ptr) as HRESULT
declare function DispCallFunc(byval pvInstance as any ptr, byval oVft as ULONG_PTR, byval cc as CALLCONV, byval vtReturn as VARTYPE, byval cActuals as UINT, byval prgvt as VARTYPE ptr, byval prgpvarg as VARIANTARG ptr ptr, byval pvargResult as VARIANT ptr) as HRESULT
const ACTIVEOBJECT_STRONG = &h0
const ACTIVEOBJECT_WEAK = &h1
declare function RegisterActiveObject(byval punk as IUnknown ptr, byval rclsid as const IID const ptr, byval dwFlags as DWORD, byval pdwRegister as DWORD ptr) as HRESULT
declare function RevokeActiveObject(byval dwRegister as DWORD, byval pvReserved as any ptr) as HRESULT
declare function GetActiveObject(byval rclsid as const IID const ptr, byval pvReserved as any ptr, byval ppunk as IUnknown ptr ptr) as HRESULT
declare function SetErrorInfo(byval dwReserved as ULONG, byval perrinfo as IErrorInfo ptr) as HRESULT
declare function GetErrorInfo(byval dwReserved as ULONG, byval pperrinfo as IErrorInfo ptr ptr) as HRESULT
declare function CreateErrorInfo(byval pperrinfo as ICreateErrorInfo ptr ptr) as HRESULT
declare function GetRecordInfoFromTypeInfo(byval pTypeInfo as ITypeInfo ptr, byval ppRecInfo as IRecordInfo ptr ptr) as HRESULT
declare function GetRecordInfoFromGuids(byval rGuidTypeLib as const GUID const ptr, byval uVerMajor as ULONG, byval uVerMinor as ULONG, byval lcid as LCID, byval rGuidTypeInfo as const GUID const ptr, byval ppRecInfo as IRecordInfo ptr ptr) as HRESULT
declare function OaBuildVersion() as ULONG
declare sub ClearCustData(byval pCustData as LPCUSTDATA)

#define V_UNION(X, Y) (X)->Y
#define V_VT(X) (X)->vt
#define V_RECORDINFO(X) (X)->pRecInfo
#define V_RECORD(X) (X)->pvRecord
#define V_ISBYREF(X) (V_VT(X) and VT_BYREF)
#define V_ISARRAY(X) (V_VT(X) and VT_ARRAY)
#define V_ISVECTOR(X) (V_VT(X) and VT_VECTOR)
#define V_NONE(X) V_I2(X)
#define V_UI1(X) V_UNION(X, bVal)
#define V_UI1REF(X) V_UNION(X, pbVal)
#define V_I2(X) V_UNION(X, iVal)
#define V_I2REF(X) V_UNION(X, piVal)
#define V_I4(X) V_UNION(X, lVal)
#define V_I4REF(X) V_UNION(X, plVal)
#define V_I8(X) V_UNION(X, llVal)
#define V_I8REF(X) V_UNION(X, pllVal)
#define V_R4(X) V_UNION(X, fltVal)
#define V_R4REF(X) V_UNION(X, pfltVal)
#define V_R8(X) V_UNION(X, dblVal)
#define V_R8REF(X) V_UNION(X, pdblVal)
#define V_I1(X) V_UNION(X, cVal)
#define V_I1REF(X) V_UNION(X, pcVal)
#define V_UI2(X) V_UNION(X, uiVal)
#define V_UI2REF(X) V_UNION(X, puiVal)
#define V_UI4(X) V_UNION(X, ulVal)
#define V_UI4REF(X) V_UNION(X, pulVal)
#define V_UI8(X) V_UNION(X, ullVal)
#define V_UI8REF(X) V_UNION(X, pullVal)
#define V_INT(X) V_UNION(X, intVal)
#define V_INTREF(X) V_UNION(X, pintVal)
#define V_UINT(X) V_UNION(X, uintVal)
#define V_UINTREF(X) V_UNION(X, puintVal)

#ifdef __FB_64BIT__
	#define V_INT_PTR(X) V_UNION(X, llVal)
	#define V_UINT_PTR(X) V_UNION(X, ullVal)
	#define V_INT_PTRREF(X) V_UNION(X, pllVal)
	#define V_UINT_PTRREF(X) V_UNION(X, pullVal)
#else
	#define V_INT_PTR(X) V_UNION(X, lVal)
	#define V_UINT_PTR(X) V_UNION(X, ulVal)
	#define V_INT_PTRREF(X) V_UNION(X, plVal)
	#define V_UINT_PTRREF(X) V_UNION(X, pulVal)
#endif

#define V_CY(X) V_UNION(X, cyVal)
#define V_CYREF(X) V_UNION(X, pcyVal)
#define V_DATE(X) V_UNION(X, date)
#define V_DATEREF(X) V_UNION(X, pdate)
#define V_BSTR(X) V_UNION(X, bstrVal)
#define V_BSTRREF(X) V_UNION(X, pbstrVal)
#define V_DISPATCH(X) V_UNION(X, pdispVal)
#define V_DISPATCHREF(X) V_UNION(X, ppdispVal)
#define V_ERROR(X) V_UNION(X, scode)
#define V_ERRORREF(X) V_UNION(X, pscode)
#define V_BOOL(X) V_UNION(X, boolVal)
#define V_BOOLREF(X) V_UNION(X, pboolVal)
#define V_UNKNOWN(X) V_UNION(X, punkVal)
#define V_UNKNOWNREF(X) V_UNION(X, ppunkVal)
#define V_VARIANTREF(X) V_UNION(X, pvarVal)
#define V_ARRAY(X) V_UNION(X, parray)
#define V_ARRAYREF(X) V_UNION(X, pparray)
#define V_BYREF(X) V_UNION(X, byref)
#define V_DECIMAL(X) V_UNION(X, decVal)
#define V_DECIMALREF(X) V_UNION(X, pdecVal)

end extern
