'' FreeBASIC binding for disphelper_081
''
'' based on the C header files:
''   This file is part of the source code for the DispHelper COM helper library.
''   DispHelper allows you to call COM objects with an extremely simple printf style syntax.
''   DispHelper can be used from C++ or even plain C. It works with most Windows compilers
''   including Dev-CPP, Visual C++ and LCC-WIN32. Including DispHelper in your project
''   couldn't be simpler as it is available in a compacted single file version.
''
''   Included with DispHelper are over 20 samples that demonstrate using COM objects
''   including ADO, CDO, Outlook, Eudora, Excel, Word, Internet Explorer, MSHTML,
''   PocketSoap, Word Perfect, MS Agent, SAPI, MSXML, WIA, dexplorer and WMI.
''
''   DispHelper is free open source software provided under the BSD license.
''
''   Find out more and download DispHelper at:
''   http://sourceforge.net/projects/disphelper/
''   http://disphelper.sourceforge.net/
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "disphelper"

#include once "win/ole2.bi"
#include once "win/objbase.bi"
#include once "crt/time.bi"

extern "C"

#define DISPHELPER_H_INCLUDED
declare function dhCreateObject(byval szProgId as LPCOLESTR, byval szMachine as LPCWSTR, byval ppDisp as IDispatch ptr ptr) as HRESULT
declare function dhGetObject(byval szFile as LPCOLESTR, byval szProgId as LPCOLESTR, byval ppDisp as IDispatch ptr ptr) as HRESULT
declare function dhCreateObjectEx(byval szProgId as LPCOLESTR, byval riid as REFIID, byval dwClsContext as DWORD, byval pServerInfo as COSERVERINFO ptr, byval ppv as any ptr ptr) as HRESULT
declare function dhGetObjectEx(byval szFile as LPCOLESTR, byval szProgId as LPCOLESTR, byval riid as REFIID, byval dwClsContext as DWORD, byval lpvReserved as LPVOID, byval ppv as any ptr ptr) as HRESULT
declare function dhCallMethod(byval pDisp as IDispatch ptr, byval szMember as LPCOLESTR, ...) as HRESULT
declare function dhPutValue(byval pDisp as IDispatch ptr, byval szMember as LPCOLESTR, ...) as HRESULT
declare function dhPutRef(byval pDisp as IDispatch ptr, byval szMember as LPCOLESTR, ...) as HRESULT
declare function dhGetValue(byval szIdentifier as LPCWSTR, byval pResult as any ptr, byval pDisp as IDispatch ptr, byval szMember as LPCOLESTR, ...) as HRESULT
declare function dhInvoke(byval invokeType as long, byval returnType as VARTYPE, byval pvResult as VARIANT ptr, byval pDisp as IDispatch ptr, byval szMember as LPCOLESTR, ...) as HRESULT
declare function dhInvokeArray(byval invokeType as long, byval pvResult as VARIANT ptr, byval cArgs as UINT, byval pDisp as IDispatch ptr, byval szMember as LPCOLESTR, byval pArgs as VARIANT ptr) as HRESULT
declare function dhCallMethodV(byval pDisp as IDispatch ptr, byval szMember as LPCOLESTR, byval marker as va_list ptr) as HRESULT
declare function dhPutValueV(byval pDisp as IDispatch ptr, byval szMember as LPCOLESTR, byval marker as va_list ptr) as HRESULT
declare function dhPutRefV(byval pDisp as IDispatch ptr, byval szMember as LPCOLESTR, byval marker as va_list ptr) as HRESULT
declare function dhGetValueV(byval szIdentifier as LPCWSTR, byval pResult as any ptr, byval pDisp as IDispatch ptr, byval szMember as LPCOLESTR, byval marker as va_list ptr) as HRESULT
declare function dhInvokeV(byval invokeType as long, byval returnType as VARTYPE, byval pvResult as VARIANT ptr, byval pDisp as IDispatch ptr, byval szMember as LPCOLESTR, byval marker as va_list ptr) as HRESULT
declare function dhAutoWrap(byval invokeType as long, byval pvResult as VARIANT ptr, byval pDisp as IDispatch ptr, byval szMember as LPCOLESTR, byval cArgs as UINT, ...) as HRESULT
declare function dhParseProperties(byval pDisp as IDispatch ptr, byval szProperties as LPCWSTR, byval lpcPropsSet as UINT ptr) as HRESULT
declare function dhEnumBegin(byval ppEnum as IEnumVARIANT ptr ptr, byval pDisp as IDispatch ptr, byval szMember as LPCOLESTR, ...) as HRESULT
declare function dhEnumBeginV(byval ppEnum as IEnumVARIANT ptr ptr, byval pDisp as IDispatch ptr, byval szMember as LPCOLESTR, byval marker as va_list ptr) as HRESULT
declare function dhEnumNextObject(byval pEnum as IEnumVARIANT ptr, byval ppDisp as IDispatch ptr ptr) as HRESULT
declare function dhEnumNextVariant(byval pEnum as IEnumVARIANT ptr, byval pvResult as VARIANT ptr) as HRESULT
declare function dhInitializeImp(byval bInitializeCOM as BOOL, byval bUnicode as BOOL) as HRESULT
declare sub dhUninitialize(byval bUninitializeCOM as BOOL)
#define dhInitializeA(bInitializeCOM) dhInitializeImp(bInitializeCOM, FALSE)
#define dhInitializeW(bInitializeCOM) dhInitializeImp(bInitializeCOM, TRUE)

#ifdef UNICODE
	#define dhInitialize dhInitializeW
#else
	#define dhInitialize dhInitializeA
#endif

declare function AutoWrap alias "dhAutoWrap"(byval invokeType as long, byval pvResult as VARIANT ptr, byval pDisp as IDispatch ptr, byval szMember as LPCOLESTR, byval cArgs as UINT, ...) as HRESULT
#define DISPATCH_OBJ(objName) dim as IDispatch ptr objName = NULL
#define dhFreeString(string) SysFreeString(cast(BSTR, string))
#macro SAFE_RELEASE(pObj)
	if pObj then
		(pObj)->lpVtbl->Release(pObj)
		(pObj) = NULL
	end if
#endmacro
#macro SAFE_FREE_STRING(string)
	scope
		dhFreeString(string)
		(string) = NULL
	end scope
#endmacro
#macro WITH0(objName, pDisp, szMember)
	scope
		DISPATCH_OBJ(objName)
		if SUCCEEDED(dhGetValue(wstr("%o"), @objName, pDisp, szMember)) then
#endmacro
#macro WITH1(objName, pDisp, szMember, arg1)
	scope
		DISPATCH_OBJ(objName)
		if SUCCEEDED(dhGetValue(wstr("%o"), @objName, pDisp, szMember, arg1)) then
#endmacro
#macro WITH2(objName, pDisp, szMember, arg1, arg2)
	scope
		DISPATCH_OBJ(objName)
		if SUCCEEDED(dhGetValue(wstr("%o"), @objName, pDisp, szMember, arg1, arg2)) then
#endmacro
#macro WITH3(objName, pDisp, szMember, arg1, arg2, arg3)
	scope
		DISPATCH_OBJ(objName)
		if SUCCEEDED(dhGetValue(wstr("%o"), @objName, pDisp, szMember, arg1, arg2, arg3)) then
#endmacro
#macro WITH4(objName, pDisp, szMember, arg1, arg2, arg3, arg4)
	scope
		DISPATCH_OBJ(objName)
		if SUCCEEDED(dhGetValue(wstr("%o"), @objName, pDisp, szMember, arg1, arg2, arg3, arg4)) then
#endmacro
#define ON_WITH_ERROR(objName) else
#macro END_WITH(objName)
		end if
		SAFE_RELEASE(objName)
	end scope
#endmacro
#macro FOR_EACH0(objName, pDisp, szMember)
	scope
		dim as IEnumVARIANT ptr xx_pEnum_xx = NULL
		DISPATCH_OBJ(objName)
		if SUCCEEDED(dhEnumBegin(@xx_pEnum_xx, pDisp, szMember)) then
			while dhEnumNextObject(xx_pEnum_xx, @objName) = NOERROR
#endmacro
#macro FOR_EACH1(objName, pDisp, szMember, arg1)
	scope
		dim as IEnumVARIANT ptr xx_pEnum_xx = NULL
		DISPATCH_OBJ(objName)
		if SUCCEEDED(dhEnumBegin(@xx_pEnum_xx, pDisp, szMember, arg1)) then
			while dhEnumNextObject(xx_pEnum_xx, @objName) = NOERROR
#endmacro
#macro FOR_EACH2(objName, pDisp, szMember, arg1, arg2)
	scope
		dim as IEnumVARIANT ptr xx_pEnum_xx = NULL
		DISPATCH_OBJ(objName)
		if SUCCEEDED(dhEnumBegin(@xx_pEnum_xx, pDisp, szMember, arg1, arg2)) then
			while dhEnumNextObject(xx_pEnum_xx, @objName) = NOERROR
#endmacro
#macro FOR_EACH3(objName, pDisp, szMember, arg1, arg2, arg3)
	scope
		dim as IEnumVARIANT ptr xx_pEnum_xx = NULL
		DISPATCH_OBJ(objName)
		if SUCCEEDED(dhEnumBegin(@xx_pEnum_xx, pDisp, szMember, arg1, arg2, arg3)) then
			while dhEnumNextObject(xx_pEnum_xx, @objName) = NOERROR
#endmacro
#macro FOR_EACH4(objName, pDisp, szMember, arg1, arg2, arg3, arg4)
	scope
		dim as IEnumVARIANT ptr xx_pEnum_xx = NULL
		DISPATCH_OBJ(objName)
		if SUCCEEDED(dhEnumBegin(@xx_pEnum_xx, pDisp, szMember, arg1, arg2, arg3, arg4)) then
			while dhEnumNextObject(xx_pEnum_xx, @objName) = NOERROR
#endmacro
#macro ON_FOR_EACH_ERROR(objName)
				SAFE_RELEASE(objName)
			wend
		else
			while 0
#endmacro
#macro NEXT_(objName)
				SAFE_RELEASE(objName)
			wend
		end if
		SAFE_RELEASE(objName)
		SAFE_RELEASE(xx_pEnum_xx)
	end scope
#endmacro

type tagDH_EXCEPTION
	szInitialFunction as LPCWSTR
	szErrorFunction as LPCWSTR
	hr as HRESULT
	szMember(0 to 63) as WCHAR
	szCompleteMember(0 to 255) as WCHAR
	swCode as UINT
	szDescription as LPWSTR
	szSource as LPWSTR
	szHelpFile as LPWSTR
	dwHelpContext as DWORD
	iArgError as UINT
	bDispatchError as BOOL
end type

type DH_EXCEPTION as tagDH_EXCEPTION
type PDH_EXCEPTION as tagDH_EXCEPTION ptr
type DH_EXCEPTION_CALLBACK as sub(byval as PDH_EXCEPTION)

type tagDH_EXCEPTION_OPTIONS
	hwnd as HWND
	szAppName as LPCWSTR
	bShowExceptions as BOOL
	bDisableRecordExceptions as BOOL
	pfnExceptionCallback as DH_EXCEPTION_CALLBACK
end type

type DH_EXCEPTION_OPTIONS as tagDH_EXCEPTION_OPTIONS
type PDH_EXCEPTION_OPTIONS as tagDH_EXCEPTION_OPTIONS ptr
declare function dhToggleExceptions(byval bShow as BOOL) as HRESULT
declare function dhSetExceptionOptions(byval pExceptionOptions as PDH_EXCEPTION_OPTIONS) as HRESULT
declare function dhGetExceptionOptions(byval pExceptionOptions as PDH_EXCEPTION_OPTIONS) as HRESULT
declare function dhShowException(byval pException as PDH_EXCEPTION) as HRESULT
declare function dhGetLastException(byval pException as PDH_EXCEPTION ptr) as HRESULT
declare function dhFormatExceptionW(byval pException as PDH_EXCEPTION, byval szBuffer as LPWSTR, byval cchBufferSize as UINT, byval bFixedFont as BOOL) as HRESULT
declare function dhFormatExceptionA(byval pException as PDH_EXCEPTION, byval szBuffer as LPSTR, byval cchBufferSize as UINT, byval bFixedFont as BOOL) as HRESULT

#ifdef UNICODE
	declare function dhFormatException alias "dhFormatExceptionW"(byval pException as PDH_EXCEPTION, byval szBuffer as LPWSTR, byval cchBufferSize as UINT, byval bFixedFont as BOOL) as HRESULT
#else
	declare function dhFormatException alias "dhFormatExceptionA"(byval pException as PDH_EXCEPTION, byval szBuffer as LPSTR, byval cchBufferSize as UINT, byval bFixedFont as BOOL) as HRESULT
#endif

end extern
