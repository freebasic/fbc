''
''
'' disphelper -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __disphelper_bi__
#define __disphelper_bi__

#ifndef UNICODE
#error UNICODE only
#endif

#include once "win/ole2.bi"
#include once "win/objbase.bi"

#inclib "disphelper"

#define dhInitializeA(bInitializeCOM) dhInitializeImp(bInitializeCOM, FALSE)
#define dhInitializeW(bInitializeCOM) dhInitializeImp(bInitializeCOM, TRUE)

#ifdef UNICODE
#define dhInitialize dhInitializeW
#else
#define dhInitialize dhInitializeA
#endif

#define AutoWrap dhAutoWrap
#define DISPATCH_OBJ(objName) dim as IDispatch ptr objName = NULL
#define dhFreeString(s) SysFreeString(cptr(BSTR,s))

#ifndef SAFE_RELEASE
#define SAFE_RELEASE(pObj) if( pObj ) then (pObj)->lpVtbl->Release(pObj): pObj = NULL : end if
#endif

#define SAFE_FREE_STRING(s) dhFreeString(s): s = NULL

#define WITH0(objName, pDisp, szMember) _
	scope 																						:_
		DISPATCH_OBJ(objName)					  												:_
		if( SUCCEEDED(dhGetValue("%o", @objName, pDisp, szMember)) ) then

#define WITH1(objName, pDisp, szMember, arg1) _
	scope 																						:_
		DISPATCH_OBJ(objName)																	:_
		if( SUCCEEDED(dhGetValue("%o", @objName, pDisp, szMember, arg1)) ) then

#define WITH2(objName, pDisp, szMember, arg1, arg2) _
	scope																						:_
		DISPATCH_OBJ(objName)																	:_
		if( SUCCEEDED(dhGetValue("%o", @objName, pDisp, szMember, arg1, arg2) ) then

#define WITH3(objName, pDisp, szMember, arg1, arg2, arg3) _
	scope 																						:_
		DISPATCH_OBJ(objName)																	:_
		if( SUCCEEDED(dhGetValue("%o", @objName, pDisp, szMember, arg1, arg2, arg3)) ) then

#define WITH4(objName, pDisp, szMember, arg1, arg2, arg3, arg4) _
	scope																						:_
		DISPATCH_OBJ(objName)																	:_
		if( SUCCEEDED(dhGetValue("%o", @objName, pDisp, szMember, arg1, arg2, arg3, arg4)) ) then

#define ON_WITH_ERROR(objName) _
		else

#define END_WITH(objName) _
		end if 					:_ 
		SAFE_RELEASE(objName) 	:_
	end scope


#define FOR_EACH0(objName, pDisp, szMember) _
	scope 																						:_
		dim as IEnumVARIANT ptr xx_pEnum_xx = NULL    											:_
		DISPATCH_OBJ(objName)                													:_
		if (SUCCEEDED(dhEnumBegin(@xx_pEnum_xx, pDisp, szMember))) then 						:_
			do while(dhEnumNextObject(xx_pEnum_xx, @objName) = NOERROR)

#define FOR_EACH1(objName, pDisp, szMember, arg1) _
	scope 																						:_
		dim as IEnumVARIANT ptr xx_pEnum_xx = NULL          									:_
		DISPATCH_OBJ(objName)                      												:_
		if (SUCCEEDED(dhEnumBegin(@xx_pEnum_xx, pDisp, szMember, arg1))) then 					:_
			do while(dhEnumNextObject(xx_pEnum_xx, @objName) = NOERROR)

#define FOR_EACH2(objName, pDisp, szMember, arg1, arg2) _
	scope 																						:_
		dim as IEnumVARIANT ptr xx_pEnum_xx = NULL          									:_
		DISPATCH_OBJ(objName)                      												:_
		if (SUCCEEDED(dhEnumBegin(@xx_pEnum_xx, pDisp, szMember, arg1, arg2))) then 			:_
			do while(dhEnumNextObject(xx_pEnum_xx, @objName) = NOERROR)

#define FOR_EACH3(objName, pDisp, szMember, arg1, arg2, arg3) _
	scope 																						:_
		dim as IEnumVARIANT ptr xx_pEnum_xx = NULL          									:_
		DISPATCH_OBJ(objName)                      												:_
		if (SUCCEEDED(dhEnumBegin(@xx_pEnum_xx, pDisp, szMember, arg1, arg2, arg3))) then		:_
			do while(dhEnumNextObject(xx_pEnum_xx, @objName) = NOERROR)

#define FOR_EACH4(objName, pDisp, szMember, arg1, arg2, arg3, arg4) _
	scope 																						:_
		dim as IEnumVARIANT ptr xx_pEnum_xx = NULL          									:_
		DISPATCH_OBJ(objName)                      												:_
		if (SUCCEEDED(dhEnumBegin(@xx_pEnum_xx, pDisp, szMember, arg1, arg2, arg3, arg4))) then :_
			do while(dhEnumNextObject(xx_pEnum_xx, @objName) = NOERROR)

#define ON_FOR_EACH_ERROR(objName) _
				SAFE_RELEASE(objName) 	:_
			loop 						:_
		else 							:_
			do while 0

#define NEXT_(objName) 					_
				SAFE_RELEASE(objName) 	:_
			loop						:_
		end if 							:_
		SAFE_RELEASE(objName) 			:_
		SAFE_RELEASE(xx_pEnum_xx) 		:_
	end scope



type DH_EXCEPTION
	szInitialFunction as LPCWSTR
	szErrorFunction as LPCWSTR
	hr as HRESULT
	szMember(0 to 64-1) as WCHAR
	szCompleteMember(0 to 256-1) as WCHAR
	swCode as UINT
	szDescription as LPWSTR
	szSource as LPWSTR
	szHelpFile as LPWSTR
	dwHelpContext as DWORD
	iArgError as UINT
	bDispatchError as BOOL
end type

type PDH_EXCEPTION as DH_EXCEPTION ptr
type DH_EXCEPTION_CALLBACK as sub cdecl(byval as PDH_EXCEPTION)

type DH_EXCEPTION_OPTIONS
	hwnd as HWND
	szAppName as LPCWSTR
	bShowExceptions as BOOL
	bDisableRecordExceptions as BOOL
	pfnExceptionCallback as DH_EXCEPTION_CALLBACK
end type

type PDH_EXCEPTION_OPTIONS as DH_EXCEPTION_OPTIONS ptr

extern "c"
declare function dhCreateObject (byval szProgId as LPCOLESTR, byval szMachine as LPCWSTR, byval ppDisp as IDispatch ptr ptr) as HRESULT
declare function dhGetObject (byval szFile as LPCOLESTR, byval szProgId as LPCOLESTR, byval ppDisp as IDispatch ptr ptr) as HRESULT
declare function dhCreateObjectEx (byval szProgId as LPCOLESTR, byval riid as IID ptr, byval dwClsContext as DWORD, byval pServerInfo as COSERVERINFO ptr, byval ppv as any ptr ptr) as HRESULT
declare function dhGetObjectEx (byval szFile as LPCOLESTR, byval szProgId as LPCOLESTR, byval riid as IID ptr, byval dwClsContext as DWORD, byval lpvReserved as LPVOID, byval ppv as any ptr ptr) as HRESULT
declare function dhCallMethod (byval pDisp as IDispatch ptr, byval szMember as LPCOLESTR, ...) as HRESULT
declare function dhPutValue (byval pDisp as IDispatch ptr, byval szMember as LPCOLESTR, ...) as HRESULT
declare function dhPutRef (byval pDisp as IDispatch ptr, byval szMember as LPCOLESTR, ...) as HRESULT
declare function dhGetValue (byval szIdentifier as LPCWSTR, byval pResult as any ptr, byval pDisp as IDispatch ptr, byval szMember as LPCOLESTR, ...) as HRESULT
declare function dhInvoke (byval invokeType as integer, byval returnType as VARTYPE, byval pvResult as VARIANT ptr, byval pDisp as IDispatch ptr, byval szMember as LPCOLESTR, ...) as HRESULT
declare function dhInvokeArray (byval invokeType as integer, byval pvResult as VARIANT ptr, byval cArgs as UINT, byval pDisp as IDispatch ptr, byval szMember as LPCOLESTR, byval pArgs as VARIANT ptr) as HRESULT
''''''' declare function dhCallMethodV (byval pDisp as IDispatch ptr, byval szMember as LPCOLESTR, byval marker as va_list ptr) as HRESULT
''''''' declare function dhPutValueV (byval pDisp as IDispatch ptr, byval szMember as LPCOLESTR, byval marker as va_list ptr) as HRESULT
''''''' declare function dhPutRefV (byval pDisp as IDispatch ptr, byval szMember as LPCOLESTR, byval marker as va_list ptr) as HRESULT
''''''' declare function dhGetValueV (byval szIdentifier as LPCWSTR, byval pResult as any ptr, byval pDisp as IDispatch ptr, byval szMember as LPCOLESTR, byval marker as va_list ptr) as HRESULT
''''''' declare function dhInvokeV (byval invokeType as integer, byval returnType as VARTYPE, byval pvResult as VARIANT ptr, byval pDisp as IDispatch ptr, byval szMember as LPCOLESTR, byval marker as va_list ptr) as HRESULT
declare function dhAutoWrap (byval invokeType as integer, byval pvResult as VARIANT ptr, byval pDisp as IDispatch ptr, byval szMember as LPCOLESTR, byval cArgs as UINT, ...) as HRESULT
declare function dhParseProperties (byval pDisp as IDispatch ptr, byval szProperties as LPCWSTR, byval lpcPropsSet as UINT ptr) as HRESULT
declare function dhEnumBegin (byval ppEnum as IEnumVARIANT ptr ptr, byval pDisp as IDispatch ptr, byval szMember as LPCOLESTR, ...) as HRESULT
''''''' declare function dhEnumBeginV (byval ppEnum as IEnumVARIANT ptr ptr, byval pDisp as IDispatch ptr, byval szMember as LPCOLESTR, byval marker as va_list ptr) as HRESULT
declare function dhEnumNextObject (byval pEnum as IEnumVARIANT ptr, byval ppDisp as IDispatch ptr ptr) as HRESULT
declare function dhEnumNextVariant (byval pEnum as IEnumVARIANT ptr, byval pvResult as VARIANT ptr) as HRESULT
declare function dhInitializeImp (byval bInitializeCOM as BOOL, byval bUnicode as BOOL) as HRESULT
declare sub dhUninitialize (byval bUninitializeCOM as BOOL)
declare function dhToggleExceptions (byval bShow as BOOL) as HRESULT
declare function dhSetExceptionOptions (byval pExceptionOptions as PDH_EXCEPTION_OPTIONS) as HRESULT
declare function dhGetExceptionOptions (byval pExceptionOptions as PDH_EXCEPTION_OPTIONS) as HRESULT
declare function dhShowException (byval pException as PDH_EXCEPTION) as HRESULT
declare function dhGetLastException (byval pException as PDH_EXCEPTION ptr) as HRESULT
#ifdef UNICODE
declare function dhFormatException alias "dhFormatExceptionW" (byval pException as PDH_EXCEPTION, byval szBuffer as LPWSTR, byval cchBufferSize as UINT, byval bFixedFont as BOOL) as HRESULT
#else
declare function dhFormatException alias "dhFormatExceptionA" (byval pException as PDH_EXCEPTION, byval szBuffer as LPSTR, byval cchBufferSize as UINT, byval bFixedFont as BOOL) as HRESULT
#endif
end extern

#endif
