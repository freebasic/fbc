''
''
'' jspubtd -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __jspubtd_bi__
#define __jspubtd_bi__

#include once "spidermonkey/jstypes.bi"
#include once "spidermonkey/jscompat.bi"

type jschar as uint16
type jsint as int32
type jsuint as uint32
type jsdouble as float64
type jsval as jsword
type jsid as jsword
type jsrefcount as int32

enum JSVersion
	JSVERSION_1_0 = 100
	JSVERSION_1_1 = 110
	JSVERSION_1_2 = 120
	JSVERSION_1_3 = 130
	JSVERSION_1_4 = 140
	JSVERSION_ECMA_3 = 148
	JSVERSION_1_5 = 150
	JSVERSION_DEFAULT = 0
	JSVERSION_UNKNOWN = -1
end enum

#define JSVERSION_IS_ECMA(version) ((version) = JSVERSION_DEFAULT or (version) >= JSVERSION_1_3)

enum JSType
	JSTYPE_VOID
	JSTYPE_OBJECT
	JSTYPE_FUNCTION
	JSTYPE_STRING
	JSTYPE_NUMBER
	JSTYPE_BOOLEAN
	JSTYPE_LIMIT
end enum

enum JSAccessMode
	JSACC_PROTO = 0
	JSACC_PARENT = 1
	JSACC_IMPORT = 2
	JSACC_WATCH = 3
	JSACC_READ = 4
	JSACC_WRITE = 8
	JSACC_LIMIT
end enum

enum JSIterateOp
	JSENUMERATE_INIT
	JSENUMERATE_NEXT
	JSENUMERATE_DESTROY
end enum

#define JSACC_TYPEMASK (JSACC_WRITE - 1)

type JSClass as JSClass_
type JSConstDoubleSpec as JSConstDoubleSpec_
type JSContext as JSContext_
type JSErrorReport as JSErrorReport_
type JSFunction as any
type JSFunctionSpec as JSFunctionSpec_
type JSIdArray as JSIdArray_
type JSProperty as JSProperty_
type JSPropertySpec as JSPropertySpec_
type JSObject as any
type JSObjectMap as any
type JSObjectOps as JSObjectOps_
type JSRuntime as any
type JSTaskState as JSRuntime
type JSScript as any
type JSString as any
type JSXDRState as any
type JSExceptionState as any
type JSLocaleCallbacks as JSLocaleCallbacks_
type JSPrincipals as JSPrincipals_

type JSPropertyOp as function cdecl(byval as JSContext ptr, byval as JSObject ptr, byval as jsval, byval as jsval ptr) as JSBool
type JSNewEnumerateOp as function cdecl(byval as JSContext ptr, byval as JSObject ptr, byval as JSIterateOp, byval as jsval ptr, byval as jsid ptr) as JSBool
type JSEnumerateOp as function cdecl(byval as JSContext ptr, byval as JSObject ptr) as JSBool
type JSResolveOp as function cdecl(byval as JSContext ptr, byval as JSObject ptr, byval as jsval) as JSBool
type JSNewResolveOp as function cdecl(byval as JSContext ptr, byval as JSObject ptr, byval as jsval, byval as uintN, byval as JSObject ptr ptr) as JSBool
type JSConvertOp as function cdecl(byval as JSContext ptr, byval as JSObject ptr, byval as JSType, byval as jsval ptr) as JSBool
type JSFinalizeOp as sub cdecl(byval as JSContext ptr, byval as JSObject ptr)
type JSStringFinalizeOp as sub cdecl(byval as JSContext ptr, byval as JSString ptr)
type JSGetObjectOps as function cdecl(byval as JSContext ptr, byval as JSClass ptr) as JSObjectOps ptr
type JSCheckAccessOp as function cdecl(byval as JSContext ptr, byval as JSObject ptr, byval as jsval, byval as JSAccessMode, byval as jsval ptr) as JSBool
type JSXDRObjectOp as function cdecl(byval as JSXDRState ptr, byval as JSObject ptr ptr) as JSBool
type JSHasInstanceOp as function cdecl(byval as JSContext ptr, byval as JSObject ptr, byval as jsval, byval as JSBool ptr) as JSBool
type JSMarkOp as function cdecl(byval as JSContext ptr, byval as JSObject ptr, byval as any ptr) as uint32
type JSReserveSlotsOp as function cdecl(byval as JSContext ptr, byval as JSObject ptr) as uint32
type JSNewObjectMapOp as function cdecl(byval as JSContext ptr, byval as jsrefcount, byval as JSObjectOps ptr, byval as JSClass ptr, byval as JSObject ptr) as JSObjectMap ptr
type JSObjectMapOp as sub cdecl(byval as JSContext ptr, byval as JSObjectMap ptr)
type JSLookupPropOp as function cdecl(byval as JSContext ptr, byval as JSObject ptr, byval as jsid, byval as JSObject ptr ptr, byval as JSProperty ptr ptr) as JSBool
type JSDefinePropOp as function cdecl(byval as JSContext ptr, byval as JSObject ptr, byval as jsid, byval as jsval, byval as JSPropertyOp, byval as JSPropertyOp, byval as uintN, byval as JSProperty ptr ptr) as JSBool
type JSPropertyIdOp as function cdecl(byval as JSContext ptr, byval as JSObject ptr, byval as jsid, byval as jsval ptr) as JSBool
type JSAttributesOp as function cdecl(byval as JSContext ptr, byval as JSObject ptr, byval as jsid, byval as JSProperty ptr, byval as uintN ptr) as JSBool
type JSCheckAccessIdOp as function cdecl(byval as JSContext ptr, byval as JSObject ptr, byval as jsid, byval as JSAccessMode, byval as jsval ptr, byval as uintN ptr) as JSBool
type JSObjectOp as function cdecl(byval as JSContext ptr, byval as JSObject ptr) as JSObject ptr
type JSPropertyRefOp as sub cdecl(byval as JSContext ptr, byval as JSObject ptr, byval as JSProperty ptr)
type JSSetObjectSlotOp as function cdecl(byval as JSContext ptr, byval as JSObject ptr, byval as uint32, byval as JSObject ptr) as JSBool
type JSGetRequiredSlotOp as function cdecl(byval as JSContext ptr, byval as JSObject ptr, byval as uint32) as jsval
type JSSetRequiredSlotOp as function cdecl(byval as JSContext ptr, byval as JSObject ptr, byval as uint32, byval as jsval) as JSBool
type JSNative as function cdecl(byval as JSContext ptr, byval as JSObject ptr, byval as uintN, byval as jsval ptr, byval as jsval ptr) as JSBool

enum JSGCStatus
	JSGC_BEGIN
	JSGC_END
	JSGC_MARK_END
	JSGC_FINALIZE_END
end enum

type JSGCCallback as function cdecl(byval as JSContext ptr, byval as JSGCStatus) as JSBool
type JSBranchCallback as function cdecl(byval as JSContext ptr, byval as JSScript ptr) as JSBool
type JSErrorReporter as sub cdecl(byval as JSContext ptr, byval as zstring ptr, byval as JSErrorReport ptr)

type JSErrorFormatString
	format as zstring ptr
	argCount as uintN
end type

type JSErrorCallback as function cdecl(byval as any ptr, byval as zstring ptr, byval as uintN) as JSErrorFormatString ptr
type JSLocaleToUpperCase as function cdecl(byval as JSContext ptr, byval as JSString ptr, byval as jsval ptr) as JSBool
type JSLocaleToLowerCase as function cdecl(byval as JSContext ptr, byval as JSString ptr, byval as jsval ptr) as JSBool
type JSLocaleCompare as function cdecl(byval as JSContext ptr, byval as JSString ptr, byval as JSString ptr, byval as jsval ptr) as JSBool
type JSLocaleToUnicode as function cdecl(byval as JSContext ptr, byval as zstring ptr, byval as jsval ptr) as JSBool

type JSPrincipalsTranscoder as function cdecl(byval as JSXDRState ptr, byval as JSPrincipals ptr ptr) as JSBool
type JSObjectPrincipalsFinder as function cdecl(byval as JSContext ptr, byval as JSObject ptr) as JSPrincipals ptr

#endif
