''
''
'' jsapi -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __jsapi_bi__
#define __jsapi_bi__

#inclib "js"

#include once "crt/stddef.bi"
#include once "crt/stdio.bi"
#include once "spidermonkey/jspubtd.bi"

#define JSVAL_OBJECT &h0
#define JSVAL_INT &h1
#define JSVAL_DOUBLE &h2
#define JSVAL_STRING &h4
#define JSVAL_BOOLEAN &h6

#define JSVAL_TAGBITS 3
#define JSVAL_TAGMASK JS_BITMASK(JSVAL_TAGBITS)
#define JSVAL_TAG(v) ((v) and JSVAL_TAGMASK)
#define JSVAL_SETTAG(v,t) ((v) or (t))
#define JSVAL_CLRTAG(v) ((v) and not cast(jsval,JSVAL_TAGMASK))
#define JSVAL_ALIGN JS_BIT(JSVAL_TAGBITS)
#define JSVAL_IS_OBJECT(v) (JSVAL_TAG(v) = JSVAL_OBJECT)
#define JSVAL_IS_NUMBER(v) (JSVAL_IS_INT(v) or JSVAL_IS_DOUBLE(v))
#define JSVAL_IS_INT(v) (((v) and JSVAL_INT) and ((v) <> JSVAL_VOID))
#define JSVAL_IS_DOUBLE(v) (JSVAL_TAG(v) = JSVAL_DOUBLE)
#define JSVAL_IS_STRING(v) (JSVAL_TAG(v) = JSVAL_STRING)
#define JSVAL_IS_BOOLEAN(v) (JSVAL_TAG(v) = JSVAL_BOOLEAN)
#define JSVAL_IS_NULL(v) ((v) = JSVAL_NULL)
#define JSVAL_IS_VOID(v) ((v) = JSVAL_VOID)
#define JSVAL_IS_PRIMITIVE(v) ((JSVAL_IS_OBJECT(v) = 0) or JSVAL_IS_NULL(v))
#define JSVAL_IS_GCTHING(v)((((v) and JSVAL_INT) and (JSVAL_IS_BOOLEAN(v) = 0)) = 0)
#define JSVAL_TO_GCTHING(v) (cast(any ptr, JSVAL_CLRTAG(v)))
#define JSVAL_TO_OBJECT(v) (cast(JSObject ptr, JSVAL_TO_GCTHING(v)))
#define JSVAL_TO_DOUBLE(v) (cast(jsdouble ptr, JSVAL_TO_GCTHING(v)))
#define JSVAL_TO_STRING(v) (cast(JSString ptr, JSVAL_TO_GCTHING(v)))
#define OBJECT_TO_JSVAL(obj) (cast(jsval, obj))
#define DOUBLE_TO_JSVAL(dp) JSVAL_SETTAG(cast(jsval, dp), JSVAL_DOUBLE)
#define STRING_TO_JSVAL(str_) JSVAL_SETTAG(cast(jsval, str_), JSVAL_STRING)

#define JSVAL_LOCK(cx,v) iif(JSVAL_IS_GCTHING(v), JS_LockGCThing(cx, JSVAL_TO_GCTHING(v)), JS_TRUE)
#define JSVAL_UNLOCK(cx,v) iif(JSVAL_IS_GCTHING(v), JS_UnlockGCThing(cx, JSVAL_TO_GCTHING(v)), JS_TRUE)

#define JSVAL_INT_BITS 31
#define JSVAL_INT_POW2(n) (cast(jsval,1) shl (n))
#define JSVAL_INT_MIN (cast(jsval,1 - JSVAL_INT_POW2(30))
#define JSVAL_INT_MAX (JSVAL_INT_POW2(30) - 1)
#define INT_FITS_IN_JSVAL(i) (cast(jsuint,(i)+JSVAL_INT_MAX) <= 2*JSVAL_INT_MAX)
#define JSVAL_TO_INT(v) (cast(jsint,v) shr 1)
#define INT_TO_JSVAL(i) ((cast(jsval,i) shl 1) or JSVAL_INT)
#define JSVAL_TO_BOOLEAN(v) (cast(JSBool, (v) >> JSVAL_TAGBITS))
#define BOOLEAN_TO_JSVAL(b) JSVAL_SETTAG(cast(jsval,b) shl JSVAL_TAGBITS, JSVAL_BOOLEAN)
#define JSVAL_TO_PRIVATE(v) (cast(any ptr,(v) and not JSVAL_INT))
#define PRIVATE_TO_JSVAL(p) (cast(jsval,p) or JSVAL_INT)

#define JSPROP_ENUMERATE &h01
#define JSPROP_READONLY &h02
#define JSPROP_PERMANENT &h04
#define JSPROP_EXPORTED &h08
#define JSPROP_GETTER &h10
#define JSPROP_SETTER &h20
#define JSPROP_SHARED &h40
#define JSPROP_INDEX &h80
#define JSFUN_LAMBDA &h08
#define JSFUN_GETTER &h10
#define JSFUN_SETTER &h20
#define JSFUN_BOUND_METHOD &h40
#define JSFUN_HEAVYWEIGHT &h80
#define JSFUN_FLAGS_MASK &hf8

#define JSVAL_VOID INT_TO_JSVAL(0 - JSVAL_INT_POW2(30))
#define JSVAL_NULL OBJECT_TO_JSVAL(0)
#define JSVAL_ZERO INT_TO_JSVAL(0)
#define JSVAL_ONE INT_TO_JSVAL(1)
#define JSVAL_FALSE BOOLEAN_TO_JSVAL(JS_FALSE)
#define JSVAL_TRUE BOOLEAN_TO_JSVAL(JS_TRUE)

#define JS_NewRuntime JS_Init
#define JS_DestroyRuntime JS_Finish
#define JS_LockRuntime JS_Lock
#define JS_UnlockRuntime JS_Unlock

#define JSOPTION_STRICT JS_BIT(0)
#define JSOPTION_WERROR JS_BIT(1)
#define JSOPTION_VAROBJFIX JS_BIT(2)
#define JSOPTION_PRIVATE_IS_NSISUPPORTS JS_BIT(3)
#define JSOPTION_COMPILE_N_GO JS_BIT(4)
#define JSOPTION_ATLINE JS_BIT(5)

#ifdef NAME_ALL_GC_ROOTS
# define JS_DEFINE_TO_TOKEN(def) #def
# define JS_DEFINE_TO_STRING(def) JS_DEFINE_TO_TOKEN(def)
# define JS_AddRoot(cx,rp) JS_AddNamedRoot((cx), (rp), (__FILE__ ":" JS_TOKEN_TO_STRING(__LINE__)))
#else
# define JS_AddRoot(cx,rp) JS_AddRoot_(cx,rp)
#endif

#define JS_MAP_GCROOT_NEXT 0
#define JS_MAP_GCROOT_STOP 1
#define JS_MAP_GCROOT_REMOVE 2

type JSGCRootMapFun as function cdecl(byval as any ptr, byval as zstring ptr, byval as any ptr) as intN

type JSClass_
	name as zstring ptr
	flags as uint32
	addProperty as JSPropertyOp
	delProperty as JSPropertyOp
	getProperty as JSPropertyOp
	setProperty as JSPropertyOp
	enumerate as JSEnumerateOp
	resolve as JSResolveOp
	convert as JSConvertOp
	finalize as JSFinalizeOp
	getObjectOps as JSGetObjectOps
	checkAccess as JSCheckAccessOp
	call as JSNative
	construct as JSNative
	xdrObject as JSXDRObjectOp
	hasInstance as JSHasInstanceOp
	mark as JSMarkOp
	reserveSlots as JSReserveSlotsOp
end type

#define JSCLASS_HAS_PRIVATE (1 shl 0)
#define JSCLASS_NEW_ENUMERATE (1 shl 1)
#define JSCLASS_NEW_RESOLVE (1 shl 2)
#define JSCLASS_PRIVATE_IS_NSISUPPORTS (1 shl 3)
#define JSCLASS_SHARE_ALL_PROPERTIES (1 shl 4)
#define JSCLASS_NEW_RESOLVE_GETS_START (1 shl 5)
#define JSCLASS_RESERVED_SLOTS_SHIFT 8
#define JSCLASS_RESERVED_SLOTS_WIDTH 8
#define JSCLASS_HAS_RESERVED_SLOTS(n) (((n) and JSCLASS_RESERVED_SLOTS_MASK) shr JSCLASS_RESERVED_SLOTS_SHIFT)
#define JSCLASS_RESERVED_SLOTS(clasp) (((clasp)->flags shl JSCLASS_RESERVED_SLOTS_SHIFT) and JSCLASS_RESERVED_SLOTS_MASK)
#define JSCLASS_NO_OPTIONAL_MEMBERS 0,0,0,0,0,0,0,0

type JSObjectOps_
	newObjectMap as JSNewObjectMapOp
	destroyObjectMap as JSObjectMapOp
	lookupProperty as JSLookupPropOp
	defineProperty as JSDefinePropOp
	getProperty as JSPropertyIdOp
	setProperty as JSPropertyIdOp
	getAttributes as JSAttributesOp
	setAttributes as JSAttributesOp
	deleteProperty as JSPropertyIdOp
	defaultValue as JSConvertOp
	enumerate as JSNewEnumerateOp
	checkAccess as JSCheckAccessIdOp
	thisObject as JSObjectOp
	dropProperty as JSPropertyRefOp
	call as JSNative
	construct as JSNative
	xdrObject as JSXDRObjectOp
	hasInstance as JSHasInstanceOp
	setProto as JSSetObjectSlotOp
	setParent as JSSetObjectSlotOp
	mark as JSMarkOp
	clear as JSFinalizeOp
	getRequiredSlot as JSGetRequiredSlotOp
	setRequiredSlot as JSSetRequiredSlotOp
end type

type JSProperty_
	id as jsid
end type

type JSIdArray_
	length as jsint
	vector(0 to 1-1) as jsid
end type

#define JSRESOLVE_QUALIFIED &h01
#define JSRESOLVE_ASSIGNING &h02
#define JSRESOLVE_DETECTING &h04
#define JSRESOLVE_DECLARING &h08
#define JSRESOLVE_CLASSNAME &h10

type JSConstDoubleSpec_
	dval as jsdouble
	name as zstring ptr
	flags as uint8
	spare(0 to 3-1) as uint8
end type

type JSPropertySpec_
	name as zstring ptr
	tinyid as int8
	flags as uint8
	getter as JSPropertyOp
	setter as JSPropertyOp
end type

type JSFunctionSpec_
	name as zstring ptr
	call as JSNative
	nargs as uint8
	flags as uint8
	extra as uint16
end type


type JSPrincipals_
	codebase as zstring ptr
	getPrincipalArray as sub cdecl(byval as JSContext ptr, byval as JSPrincipals ptr)
	globalPrivilegesEnabled as function cdecl(byval as JSContext ptr, byval as JSPrincipals ptr) as JSBool
	refcount as jsrefcount
	destroy as sub cdecl(byval as JSContext ptr, byval as JSPrincipals ptr)
end type

private function JSPRINCIPALS_HOLD(byval cx as JSContext ptr, byval principals as JSPrincipals ptr) as jsrefcount
	principals->refcount += 1
	function = principals->refcount
end function

private function JSPRINCIPALS_DROP( byval cx as JSContext ptr, byval principals as JSPrincipals ptr) as jsrefcount
    principals->refcount -= 1
    if principals->refcount = 0 then
    	principals->destroy(cx, principals)
    	function = 0
    else 
    	function = principals->refcount
    end if
end function

#define JS_DONT_PRETTY_PRINT cast(uintN,&h8000)

enum JSExecPart
	JSEXEC_PROLOG
	JSEXEC_MAIN
end enum

type JSLocaleCallbacks_
	localeToUpperCase as JSLocaleToUpperCase
	localeToLowerCase as JSLocaleToLowerCase
	localeCompare as JSLocaleCompare
	localeToUnicode as JSLocaleToUnicode
end type

type JSErrorReport_
	filename as zstring ptr
	lineno as uintN
	linebuf as zstring ptr
	tokenptr as zstring ptr
	uclinebuf as jschar ptr
	uctokenptr as jschar ptr
	flags as uintN
	errorNumber as uintN
	ucmessage as jschar ptr
	messageArgs as jschar ptr ptr
end type

#define JSREPORT_ERROR &h0
#define JSREPORT_WARNING &h1
#define JSREPORT_EXCEPTION &h2
#define JSREPORT_STRICT &h4

#define JSREPORT_IS_WARNING(flags) (((flags) and JSREPORT_WARNING) <> 0)
#define JSREPORT_IS_EXCEPTION(flags) (((flags) and JSREPORT_EXCEPTION) <> 0)
#define JSREPORT_IS_STRICT(flags) (((flags) and JSREPORT_STRICT) <> 0)

#define JSREG_FOLD &h01
#define JSREG_GLOB &h02
#define JSREG_MULTILINE &h04

extern "c"
declare function JS_Now () as int64
declare function JS_GetNaNValue (byval cx as JSContext ptr) as jsval
declare function JS_GetNegativeInfinityValue (byval cx as JSContext ptr) as jsval
declare function JS_GetPositiveInfinityValue (byval cx as JSContext ptr) as jsval
declare function JS_GetEmptyStringValue (byval cx as JSContext ptr) as jsval
declare function JS_ConvertArguments (byval cx as JSContext ptr, byval argc as uintN, byval argv as jsval ptr, byval format as zstring ptr, ...) as JSBool
declare function JS_PushArguments (byval cx as JSContext ptr, byval markp as any ptr ptr, byval format as zstring ptr, ...) as jsval ptr
declare sub JS_PopArguments (byval cx as JSContext ptr, byval mark as any ptr)
declare function JS_ConvertValue (byval cx as JSContext ptr, byval v as jsval, byval type as JSType, byval vp as jsval ptr) as JSBool
declare function JS_ValueToObject (byval cx as JSContext ptr, byval v as jsval, byval objp as JSObject ptr ptr) as JSBool
declare function JS_ValueToFunction (byval cx as JSContext ptr, byval v as jsval) as JSFunction ptr
declare function JS_ValueToConstructor (byval cx as JSContext ptr, byval v as jsval) as JSFunction ptr
declare function JS_ValueToString (byval cx as JSContext ptr, byval v as jsval) as JSString ptr
declare function JS_ValueToNumber (byval cx as JSContext ptr, byval v as jsval, byval dp as jsdouble ptr) as JSBool
declare function JS_ValueToECMAInt32 (byval cx as JSContext ptr, byval v as jsval, byval ip as int32 ptr) as JSBool
declare function JS_ValueToECMAUint32 (byval cx as JSContext ptr, byval v as jsval, byval ip as uint32 ptr) as JSBool
declare function JS_ValueToInt32 (byval cx as JSContext ptr, byval v as jsval, byval ip as int32 ptr) as JSBool
declare function JS_ValueToUint16 (byval cx as JSContext ptr, byval v as jsval, byval ip as uint16 ptr) as JSBool
declare function JS_ValueToBoolean (byval cx as JSContext ptr, byval v as jsval, byval bp as JSBool ptr) as JSBool
declare function JS_TypeOfValue (byval cx as JSContext ptr, byval v as jsval) as JSType
declare function JS_GetTypeName (byval cx as JSContext ptr, byval type as JSType) as zstring ptr
declare function JS_Init (byval maxbytes as uint32) as JSRuntime ptr
declare sub JS_Finish (byval rt as JSRuntime ptr)
declare sub JS_ShutDown ()
declare function JS_GetRuntimePrivate (byval rt as JSRuntime ptr) as any ptr
declare sub JS_SetRuntimePrivate (byval rt as JSRuntime ptr, byval data as any ptr)
declare sub JS_Lock (byval rt as JSRuntime ptr)
declare sub JS_Unlock (byval rt as JSRuntime ptr)
declare function JS_NewContext (byval rt as JSRuntime ptr, byval stackChunkSize as size_t) as JSContext ptr
declare sub JS_DestroyContext (byval cx as JSContext ptr)
declare sub JS_DestroyContextNoGC (byval cx as JSContext ptr)
declare sub JS_DestroyContextMaybeGC (byval cx as JSContext ptr)
declare function JS_GetContextPrivate (byval cx as JSContext ptr) as any ptr
declare sub JS_SetContextPrivate (byval cx as JSContext ptr, byval data as any ptr)
declare function JS_GetRuntime (byval cx as JSContext ptr) as JSRuntime ptr
declare function JS_ContextIterator (byval rt as JSRuntime ptr, byval iterp as JSContext ptr ptr) as JSContext ptr
declare function JS_GetVersion (byval cx as JSContext ptr) as JSVersion
declare function JS_SetVersion (byval cx as JSContext ptr, byval version as JSVersion) as JSVersion
declare function JS_VersionToString (byval version as JSVersion) as zstring ptr
declare function JS_StringToVersion (byval string as zstring ptr) as JSVersion
declare function JS_GetOptions (byval cx as JSContext ptr) as uint32
declare function JS_SetOptions (byval cx as JSContext ptr, byval options as uint32) as uint32
declare function JS_ToggleOptions (byval cx as JSContext ptr, byval options as uint32) as uint32
declare function JS_GetImplementationVersion () as zstring ptr
declare function JS_GetGlobalObject (byval cx as JSContext ptr) as JSObject ptr
declare sub JS_SetGlobalObject (byval cx as JSContext ptr, byval obj as JSObject ptr)
declare function JS_InitStandardClasses (byval cx as JSContext ptr, byval obj as JSObject ptr) as JSBool
declare function JS_ResolveStandardClass (byval cx as JSContext ptr, byval obj as JSObject ptr, byval id as jsval, byval resolved as JSBool ptr) as JSBool
declare function JS_EnumerateStandardClasses (byval cx as JSContext ptr, byval obj as JSObject ptr) as JSBool
declare function JS_GetScopeChain (byval cx as JSContext ptr) as JSObject ptr
declare function JS_malloc (byval cx as JSContext ptr, byval nbytes as size_t) as any ptr
declare function JS_realloc (byval cx as JSContext ptr, byval p as any ptr, byval nbytes as size_t) as any ptr
declare sub JS_free (byval cx as JSContext ptr, byval p as any ptr)
declare function JS_strdup (byval cx as JSContext ptr, byval s as zstring ptr) as zstring ptr
declare function JS_NewDouble (byval cx as JSContext ptr, byval d as jsdouble) as jsdouble ptr
declare function JS_NewDoubleValue (byval cx as JSContext ptr, byval d as jsdouble, byval rval as jsval ptr) as JSBool
declare function JS_NewNumberValue (byval cx as JSContext ptr, byval d as jsdouble, byval rval as jsval ptr) as JSBool
declare function JS_AddRoot_ (byval cx as JSContext ptr, byval rp as any ptr) as JSBool
declare function JS_AddNamedRoot (byval cx as JSContext ptr, byval rp as any ptr, byval name as zstring ptr) as JSBool
declare function JS_AddNamedRootRT (byval rt as JSRuntime ptr, byval rp as any ptr, byval name as zstring ptr) as JSBool
declare function JS_RemoveRoot (byval cx as JSContext ptr, byval rp as any ptr) as JSBool
declare function JS_RemoveRootRT (byval rt as JSRuntime ptr, byval rp as any ptr) as JSBool
declare sub JS_ClearNewbornRoots (byval cx as JSContext ptr)
declare function JS_EnterLocalRootScope (byval cx as JSContext ptr) as JSBool
declare sub JS_LeaveLocalRootScope (byval cx as JSContext ptr)
declare sub JS_ForgetLocalRoot (byval cx as JSContext ptr, byval thing as any ptr)
declare function JS_MapGCRoots (byval rt as JSRuntime ptr, byval map as JSGCRootMapFun, byval data as any ptr) as uint32
declare function JS_LockGCThing (byval cx as JSContext ptr, byval thing as any ptr) as JSBool
declare function JS_LockGCThingRT (byval rt as JSRuntime ptr, byval thing as any ptr) as JSBool
declare function JS_UnlockGCThing (byval cx as JSContext ptr, byval thing as any ptr) as JSBool
declare function JS_UnlockGCThingRT (byval rt as JSRuntime ptr, byval thing as any ptr) as JSBool
declare sub JS_MarkGCThing (byval cx as JSContext ptr, byval thing as any ptr, byval name as zstring ptr, byval arg as any ptr)
declare sub JS_GC (byval cx as JSContext ptr)
declare sub JS_MaybeGC (byval cx as JSContext ptr)
declare function JS_SetGCCallback (byval cx as JSContext ptr, byval cb as JSGCCallback) as JSGCCallback
declare function JS_SetGCCallbackRT (byval rt as JSRuntime ptr, byval cb as JSGCCallback) as JSGCCallback
declare function JS_IsAboutToBeFinalized (byval cx as JSContext ptr, byval thing as any ptr) as JSBool
declare function JS_AddExternalStringFinalizer (byval finalizer as JSStringFinalizeOp) as intN
declare function JS_RemoveExternalStringFinalizer (byval finalizer as JSStringFinalizeOp) as intN
declare function JS_NewExternalString (byval cx as JSContext ptr, byval chars as jschar ptr, byval length as size_t, byval type as intN) as JSString ptr
declare function JS_GetExternalStringGCType (byval rt as JSRuntime ptr, byval str as JSString ptr) as intN
declare sub JS_SetThreadStackLimit (byval cx as JSContext ptr, byval limitAddr as jsuword)
declare sub JS_DestroyIdArray (byval cx as JSContext ptr, byval ida as JSIdArray ptr)
declare function JS_ValueToId (byval cx as JSContext ptr, byval v as jsval, byval idp as jsid ptr) as JSBool
declare function JS_IdToValue (byval cx as JSContext ptr, byval id as jsid, byval vp as jsval ptr) as JSBool
declare function JS_PropertyStub (byval cx as JSContext ptr, byval obj as JSObject ptr, byval id as jsval, byval vp as jsval ptr) as JSBool
declare function JS_EnumerateStub (byval cx as JSContext ptr, byval obj as JSObject ptr) as JSBool
declare function JS_ResolveStub (byval cx as JSContext ptr, byval obj as JSObject ptr, byval id as jsval) as JSBool
declare function JS_ConvertStub (byval cx as JSContext ptr, byval obj as JSObject ptr, byval type as JSType, byval vp as jsval ptr) as JSBool
declare sub JS_FinalizeStub (byval cx as JSContext ptr, byval obj as JSObject ptr)
declare function JS_InitClass (byval cx as JSContext ptr, byval obj as JSObject ptr, byval parent_proto as JSObject ptr, byval clasp as JSClass ptr, byval constructor as JSNative, byval nargs as uintN, byval ps as JSPropertySpec ptr, byval fs as JSFunctionSpec ptr, byval static_ps as JSPropertySpec ptr, byval static_fs as JSFunctionSpec ptr) as JSObject ptr
declare function JS_GetClass (byval obj as JSObject ptr) as JSClass ptr
declare function JS_InstanceOf (byval cx as JSContext ptr, byval obj as JSObject ptr, byval clasp as JSClass ptr, byval argv as jsval ptr) as JSBool
declare function JS_GetPrivate (byval cx as JSContext ptr, byval obj as JSObject ptr) as any ptr
declare function JS_SetPrivate (byval cx as JSContext ptr, byval obj as JSObject ptr, byval data as any ptr) as JSBool
declare function JS_GetInstancePrivate (byval cx as JSContext ptr, byval obj as JSObject ptr, byval clasp as JSClass ptr, byval argv as jsval ptr) as any ptr
declare function JS_GetPrototype (byval cx as JSContext ptr, byval obj as JSObject ptr) as JSObject ptr
declare function JS_SetPrototype (byval cx as JSContext ptr, byval obj as JSObject ptr, byval proto as JSObject ptr) as JSBool
declare function JS_GetParent (byval cx as JSContext ptr, byval obj as JSObject ptr) as JSObject ptr
declare function JS_SetParent (byval cx as JSContext ptr, byval obj as JSObject ptr, byval parent as JSObject ptr) as JSBool
declare function JS_GetConstructor (byval cx as JSContext ptr, byval proto as JSObject ptr) as JSObject ptr
declare function JS_GetObjectId (byval cx as JSContext ptr, byval obj as JSObject ptr, byval idp as jsid ptr) as JSBool
declare function JS_NewObject (byval cx as JSContext ptr, byval clasp as JSClass ptr, byval proto as JSObject ptr, byval parent as JSObject ptr) as JSObject ptr
declare function JS_SealObject (byval cx as JSContext ptr, byval obj as JSObject ptr, byval deep as JSBool) as JSBool
declare function JS_ConstructObject (byval cx as JSContext ptr, byval clasp as JSClass ptr, byval proto as JSObject ptr, byval parent as JSObject ptr) as JSObject ptr
declare function JS_ConstructObjectWithArguments (byval cx as JSContext ptr, byval clasp as JSClass ptr, byval proto as JSObject ptr, byval parent as JSObject ptr, byval argc as uintN, byval argv as jsval ptr) as JSObject ptr
declare function JS_DefineObject (byval cx as JSContext ptr, byval obj as JSObject ptr, byval name as zstring ptr, byval clasp as JSClass ptr, byval proto as JSObject ptr, byval attrs as uintN) as JSObject ptr
declare function JS_DefineConstDoubles (byval cx as JSContext ptr, byval obj as JSObject ptr, byval cds as JSConstDoubleSpec ptr) as JSBool
declare function JS_DefineProperties (byval cx as JSContext ptr, byval obj as JSObject ptr, byval ps as JSPropertySpec ptr) as JSBool
declare function JS_DefineProperty (byval cx as JSContext ptr, byval obj as JSObject ptr, byval name as zstring ptr, byval value as jsval, byval getter as JSPropertyOp, byval setter as JSPropertyOp, byval attrs as uintN) as JSBool
declare function JS_GetPropertyAttributes (byval cx as JSContext ptr, byval obj as JSObject ptr, byval name as zstring ptr, byval attrsp as uintN ptr, byval foundp as JSBool ptr) as JSBool
declare function JS_SetPropertyAttributes (byval cx as JSContext ptr, byval obj as JSObject ptr, byval name as zstring ptr, byval attrs as uintN, byval foundp as JSBool ptr) as JSBool
declare function JS_DefinePropertyWithTinyId (byval cx as JSContext ptr, byval obj as JSObject ptr, byval name as zstring ptr, byval tinyid as int8, byval value as jsval, byval getter as JSPropertyOp, byval setter as JSPropertyOp, byval attrs as uintN) as JSBool
declare function JS_AliasProperty (byval cx as JSContext ptr, byval obj as JSObject ptr, byval name as zstring ptr, byval alias as zstring ptr) as JSBool
declare function JS_HasProperty (byval cx as JSContext ptr, byval obj as JSObject ptr, byval name as zstring ptr, byval foundp as JSBool ptr) as JSBool
declare function JS_LookupProperty (byval cx as JSContext ptr, byval obj as JSObject ptr, byval name as zstring ptr, byval vp as jsval ptr) as JSBool
declare function JS_LookupPropertyWithFlags (byval cx as JSContext ptr, byval obj as JSObject ptr, byval name as zstring ptr, byval flags as uintN, byval vp as jsval ptr) as JSBool
declare function JS_GetProperty (byval cx as JSContext ptr, byval obj as JSObject ptr, byval name as zstring ptr, byval vp as jsval ptr) as JSBool
declare function JS_SetProperty (byval cx as JSContext ptr, byval obj as JSObject ptr, byval name as zstring ptr, byval vp as jsval ptr) as JSBool
declare function JS_DeleteProperty (byval cx as JSContext ptr, byval obj as JSObject ptr, byval name as zstring ptr) as JSBool
declare function JS_DeleteProperty2 (byval cx as JSContext ptr, byval obj as JSObject ptr, byval name as zstring ptr, byval rval as jsval ptr) as JSBool
declare function JS_DefineUCProperty (byval cx as JSContext ptr, byval obj as JSObject ptr, byval name as jschar ptr, byval namelen as size_t, byval value as jsval, byval getter as JSPropertyOp, byval setter as JSPropertyOp, byval attrs as uintN) as JSBool
declare function JS_GetUCPropertyAttributes (byval cx as JSContext ptr, byval obj as JSObject ptr, byval name as jschar ptr, byval namelen as size_t, byval attrsp as uintN ptr, byval foundp as JSBool ptr) as JSBool
declare function JS_SetUCPropertyAttributes (byval cx as JSContext ptr, byval obj as JSObject ptr, byval name as jschar ptr, byval namelen as size_t, byval attrs as uintN, byval foundp as JSBool ptr) as JSBool
declare function JS_DefineUCPropertyWithTinyId (byval cx as JSContext ptr, byval obj as JSObject ptr, byval name as jschar ptr, byval namelen as size_t, byval tinyid as int8, byval value as jsval, byval getter as JSPropertyOp, byval setter as JSPropertyOp, byval attrs as uintN) as JSBool
declare function JS_HasUCProperty (byval cx as JSContext ptr, byval obj as JSObject ptr, byval name as jschar ptr, byval namelen as size_t, byval vp as JSBool ptr) as JSBool
declare function JS_LookupUCProperty (byval cx as JSContext ptr, byval obj as JSObject ptr, byval name as jschar ptr, byval namelen as size_t, byval vp as jsval ptr) as JSBool
declare function JS_GetUCProperty (byval cx as JSContext ptr, byval obj as JSObject ptr, byval name as jschar ptr, byval namelen as size_t, byval vp as jsval ptr) as JSBool
declare function JS_SetUCProperty (byval cx as JSContext ptr, byval obj as JSObject ptr, byval name as jschar ptr, byval namelen as size_t, byval vp as jsval ptr) as JSBool
declare function JS_DeleteUCProperty2 (byval cx as JSContext ptr, byval obj as JSObject ptr, byval name as jschar ptr, byval namelen as size_t, byval rval as jsval ptr) as JSBool
declare function JS_NewArrayObject (byval cx as JSContext ptr, byval length as jsint, byval vector as jsval ptr) as JSObject ptr
declare function JS_IsArrayObject (byval cx as JSContext ptr, byval obj as JSObject ptr) as JSBool
declare function JS_GetArrayLength (byval cx as JSContext ptr, byval obj as JSObject ptr, byval lengthp as jsuint ptr) as JSBool
declare function JS_SetArrayLength (byval cx as JSContext ptr, byval obj as JSObject ptr, byval length as jsuint) as JSBool
declare function JS_HasArrayLength (byval cx as JSContext ptr, byval obj as JSObject ptr, byval lengthp as jsuint ptr) as JSBool
declare function JS_DefineElement (byval cx as JSContext ptr, byval obj as JSObject ptr, byval index as jsint, byval value as jsval, byval getter as JSPropertyOp, byval setter as JSPropertyOp, byval attrs as uintN) as JSBool
declare function JS_AliasElement (byval cx as JSContext ptr, byval obj as JSObject ptr, byval name as zstring ptr, byval alias as jsint) as JSBool
declare function JS_HasElement (byval cx as JSContext ptr, byval obj as JSObject ptr, byval index as jsint, byval foundp as JSBool ptr) as JSBool
declare function JS_LookupElement (byval cx as JSContext ptr, byval obj as JSObject ptr, byval index as jsint, byval vp as jsval ptr) as JSBool
declare function JS_GetElement (byval cx as JSContext ptr, byval obj as JSObject ptr, byval index as jsint, byval vp as jsval ptr) as JSBool
declare function JS_SetElement (byval cx as JSContext ptr, byval obj as JSObject ptr, byval index as jsint, byval vp as jsval ptr) as JSBool
declare function JS_DeleteElement (byval cx as JSContext ptr, byval obj as JSObject ptr, byval index as jsint) as JSBool
declare function JS_DeleteElement2 (byval cx as JSContext ptr, byval obj as JSObject ptr, byval index as jsint, byval rval as jsval ptr) as JSBool
declare sub JS_ClearScope (byval cx as JSContext ptr, byval obj as JSObject ptr)
declare function JS_Enumerate (byval cx as JSContext ptr, byval obj as JSObject ptr) as JSIdArray ptr
declare function JS_CheckAccess (byval cx as JSContext ptr, byval obj as JSObject ptr, byval id as jsid, byval mode as JSAccessMode, byval vp as jsval ptr, byval attrsp as uintN ptr) as JSBool
declare function JS_SetCheckObjectAccessCallback (byval rt as JSRuntime ptr, byval acb as JSCheckAccessOp) as JSCheckAccessOp
declare function JS_GetReservedSlot (byval cx as JSContext ptr, byval obj as JSObject ptr, byval index as uint32, byval vp as jsval ptr) as JSBool
declare function JS_SetReservedSlot (byval cx as JSContext ptr, byval obj as JSObject ptr, byval index as uint32, byval v as jsval) as JSBool
declare function JS_SetPrincipalsTranscoder (byval rt as JSRuntime ptr, byval px as JSPrincipalsTranscoder) as JSPrincipalsTranscoder
declare function JS_SetObjectPrincipalsFinder (byval cx as JSContext ptr, byval fop as JSObjectPrincipalsFinder) as JSObjectPrincipalsFinder
declare function JS_NewFunction (byval cx as JSContext ptr, byval call as JSNative, byval nargs as uintN, byval flags as uintN, byval parent as JSObject ptr, byval name as zstring ptr) as JSFunction ptr
declare function JS_GetFunctionObject (byval fun as JSFunction ptr) as JSObject ptr
declare function JS_GetFunctionName (byval fun as JSFunction ptr) as zstring ptr
declare function JS_GetFunctionId (byval fun as JSFunction ptr) as JSString ptr
declare function JS_GetFunctionFlags (byval fun as JSFunction ptr) as uintN
declare function JS_ObjectIsFunction (byval cx as JSContext ptr, byval obj as JSObject ptr) as JSBool
declare function JS_DefineFunctions (byval cx as JSContext ptr, byval obj as JSObject ptr, byval fs as JSFunctionSpec ptr) as JSBool
declare function JS_DefineFunction (byval cx as JSContext ptr, byval obj as JSObject ptr, byval name as zstring ptr, byval call as JSNative, byval nargs as uintN, byval attrs as uintN) as JSFunction ptr
declare function JS_DefineUCFunction (byval cx as JSContext ptr, byval obj as JSObject ptr, byval name as jschar ptr, byval namelen as size_t, byval call as JSNative, byval nargs as uintN, byval attrs as uintN) as JSFunction ptr
declare function JS_CloneFunctionObject (byval cx as JSContext ptr, byval funobj as JSObject ptr, byval parent as JSObject ptr) as JSObject ptr
declare function JS_BufferIsCompilableUnit (byval cx as JSContext ptr, byval obj as JSObject ptr, byval bytes as zstring ptr, byval length as size_t) as JSBool
declare function JS_CompileScript (byval cx as JSContext ptr, byval obj as JSObject ptr, byval bytes as zstring ptr, byval length as size_t, byval filename as zstring ptr, byval lineno as uintN) as JSScript ptr
declare function JS_CompileScriptForPrincipals (byval cx as JSContext ptr, byval obj as JSObject ptr, byval principals as JSPrincipals ptr, byval bytes as zstring ptr, byval length as size_t, byval filename as zstring ptr, byval lineno as uintN) as JSScript ptr
declare function JS_CompileUCScript (byval cx as JSContext ptr, byval obj as JSObject ptr, byval chars as jschar ptr, byval length as size_t, byval filename as zstring ptr, byval lineno as uintN) as JSScript ptr
declare function JS_CompileUCScriptForPrincipals (byval cx as JSContext ptr, byval obj as JSObject ptr, byval principals as JSPrincipals ptr, byval chars as jschar ptr, byval length as size_t, byval filename as zstring ptr, byval lineno as uintN) as JSScript ptr
declare function JS_CompileFile (byval cx as JSContext ptr, byval obj as JSObject ptr, byval filename as zstring ptr) as JSScript ptr
declare function JS_CompileFileHandle (byval cx as JSContext ptr, byval obj as JSObject ptr, byval filename as zstring ptr, byval fh as FILE ptr) as JSScript ptr
declare function JS_CompileFileHandleForPrincipals (byval cx as JSContext ptr, byval obj as JSObject ptr, byval filename as zstring ptr, byval fh as FILE ptr, byval principals as JSPrincipals ptr) as JSScript ptr
declare function JS_NewScriptObject (byval cx as JSContext ptr, byval script as JSScript ptr) as JSObject ptr
declare function JS_GetScriptObject (byval script as JSScript ptr) as JSObject ptr
declare sub JS_DestroyScript (byval cx as JSContext ptr, byval script as JSScript ptr)
declare function JS_CompileFunction (byval cx as JSContext ptr, byval obj as JSObject ptr, byval name as zstring ptr, byval nargs as uintN, byval argnames as byte ptr ptr, byval bytes as zstring ptr, byval length as size_t, byval filename as zstring ptr, byval lineno as uintN) as JSFunction ptr
declare function JS_CompileFunctionForPrincipals (byval cx as JSContext ptr, byval obj as JSObject ptr, byval principals as JSPrincipals ptr, byval name as zstring ptr, byval nargs as uintN, byval argnames as byte ptr ptr, byval bytes as zstring ptr, byval length as size_t, byval filename as zstring ptr, byval lineno as uintN) as JSFunction ptr
declare function JS_CompileUCFunction (byval cx as JSContext ptr, byval obj as JSObject ptr, byval name as zstring ptr, byval nargs as uintN, byval argnames as byte ptr ptr, byval chars as jschar ptr, byval length as size_t, byval filename as zstring ptr, byval lineno as uintN) as JSFunction ptr
declare function JS_CompileUCFunctionForPrincipals (byval cx as JSContext ptr, byval obj as JSObject ptr, byval principals as JSPrincipals ptr, byval name as zstring ptr, byval nargs as uintN, byval argnames as byte ptr ptr, byval chars as jschar ptr, byval length as size_t, byval filename as zstring ptr, byval lineno as uintN) as JSFunction ptr
declare function JS_DecompileScript (byval cx as JSContext ptr, byval script as JSScript ptr, byval name as zstring ptr, byval indent as uintN) as JSString ptr
declare function JS_DecompileFunction (byval cx as JSContext ptr, byval fun as JSFunction ptr, byval indent as uintN) as JSString ptr
declare function JS_DecompileFunctionBody (byval cx as JSContext ptr, byval fun as JSFunction ptr, byval indent as uintN) as JSString ptr
declare function JS_ExecuteScript (byval cx as JSContext ptr, byval obj as JSObject ptr, byval script as JSScript ptr, byval rval as jsval ptr) as JSBool
declare function JS_ExecuteScriptPart (byval cx as JSContext ptr, byval obj as JSObject ptr, byval script as JSScript ptr, byval part as JSExecPart, byval rval as jsval ptr) as JSBool
declare function JS_EvaluateScript (byval cx as JSContext ptr, byval obj as JSObject ptr, byval bytes as zstring ptr, byval length as uintN, byval filename as zstring ptr, byval lineno as uintN, byval rval as jsval ptr) as JSBool
declare function JS_EvaluateScriptForPrincipals (byval cx as JSContext ptr, byval obj as JSObject ptr, byval principals as JSPrincipals ptr, byval bytes as zstring ptr, byval length as uintN, byval filename as zstring ptr, byval lineno as uintN, byval rval as jsval ptr) as JSBool
declare function JS_EvaluateUCScript (byval cx as JSContext ptr, byval obj as JSObject ptr, byval chars as jschar ptr, byval length as uintN, byval filename as zstring ptr, byval lineno as uintN, byval rval as jsval ptr) as JSBool
declare function JS_EvaluateUCScriptForPrincipals (byval cx as JSContext ptr, byval obj as JSObject ptr, byval principals as JSPrincipals ptr, byval chars as jschar ptr, byval length as uintN, byval filename as zstring ptr, byval lineno as uintN, byval rval as jsval ptr) as JSBool
declare function JS_CallFunction (byval cx as JSContext ptr, byval obj as JSObject ptr, byval fun as JSFunction ptr, byval argc as uintN, byval argv as jsval ptr, byval rval as jsval ptr) as JSBool
declare function JS_CallFunctionName (byval cx as JSContext ptr, byval obj as JSObject ptr, byval name as zstring ptr, byval argc as uintN, byval argv as jsval ptr, byval rval as jsval ptr) as JSBool
declare function JS_CallFunctionValue (byval cx as JSContext ptr, byval obj as JSObject ptr, byval fval as jsval, byval argc as uintN, byval argv as jsval ptr, byval rval as jsval ptr) as JSBool
declare function JS_SetBranchCallback (byval cx as JSContext ptr, byval cb as JSBranchCallback) as JSBranchCallback
declare function JS_IsRunning (byval cx as JSContext ptr) as JSBool
declare function JS_IsConstructing (byval cx as JSContext ptr) as JSBool
declare function JS_IsAssigning (byval cx as JSContext ptr) as JSBool
declare sub JS_SetCallReturnValue2 (byval cx as JSContext ptr, byval v as jsval)
declare function JS_NewString (byval cx as JSContext ptr, byval bytes as zstring ptr, byval length as size_t) as JSString ptr
declare function JS_NewStringCopyN (byval cx as JSContext ptr, byval s as zstring ptr, byval n as size_t) as JSString ptr
declare function JS_NewStringCopyZ (byval cx as JSContext ptr, byval s as zstring ptr) as JSString ptr
declare function JS_InternString (byval cx as JSContext ptr, byval s as zstring ptr) as JSString ptr
declare function JS_NewUCString (byval cx as JSContext ptr, byval chars as jschar ptr, byval length as size_t) as JSString ptr
declare function JS_NewUCStringCopyN (byval cx as JSContext ptr, byval s as jschar ptr, byval n as size_t) as JSString ptr
declare function JS_NewUCStringCopyZ (byval cx as JSContext ptr, byval s as jschar ptr) as JSString ptr
declare function JS_InternUCStringN (byval cx as JSContext ptr, byval s as jschar ptr, byval length as size_t) as JSString ptr
declare function JS_InternUCString (byval cx as JSContext ptr, byval s as jschar ptr) as JSString ptr
declare function JS_GetStringBytes (byval str as JSString ptr) as zstring ptr
declare function JS_GetStringChars (byval str as JSString ptr) as jschar ptr
declare function JS_GetStringLength (byval str as JSString ptr) as size_t
declare function JS_CompareStrings (byval str1 as JSString ptr, byval str2 as JSString ptr) as intN
declare function JS_NewGrowableString (byval cx as JSContext ptr, byval chars as jschar ptr, byval length as size_t) as JSString ptr
declare function JS_NewDependentString (byval cx as JSContext ptr, byval str as JSString ptr, byval start as size_t, byval length as size_t) as JSString ptr
declare function JS_ConcatStrings (byval cx as JSContext ptr, byval left as JSString ptr, byval right as JSString ptr) as JSString ptr
declare function JS_UndependString (byval cx as JSContext ptr, byval str as JSString ptr) as jschar ptr
declare function JS_MakeStringImmutable (byval cx as JSContext ptr, byval str as JSString ptr) as JSBool
declare sub JS_SetLocaleCallbacks (byval cx as JSContext ptr, byval callbacks as JSLocaleCallbacks ptr)
declare function JS_GetLocaleCallbacks (byval cx as JSContext ptr) as JSLocaleCallbacks ptr
declare sub JS_ReportError (byval cx as JSContext ptr, byval format as zstring ptr, ...)
declare sub JS_ReportErrorNumber (byval cx as JSContext ptr, byval errorCallback as JSErrorCallback, byval userRef as any ptr, byval errorNumber as uintN, ...)
declare sub JS_ReportErrorNumberUC (byval cx as JSContext ptr, byval errorCallback as JSErrorCallback, byval userRef as any ptr, byval errorNumber as uintN, ...)
declare function JS_ReportWarning (byval cx as JSContext ptr, byval format as zstring ptr, ...) as JSBool
declare function JS_ReportErrorFlagsAndNumber (byval cx as JSContext ptr, byval flags as uintN, byval errorCallback as JSErrorCallback, byval userRef as any ptr, byval errorNumber as uintN, ...) as JSBool
declare function JS_ReportErrorFlagsAndNumberUC (byval cx as JSContext ptr, byval flags as uintN, byval errorCallback as JSErrorCallback, byval userRef as any ptr, byval errorNumber as uintN, ...) as JSBool
declare sub JS_ReportOutOfMemory (byval cx as JSContext ptr)
declare function JS_SetErrorReporter (byval cx as JSContext ptr, byval er as JSErrorReporter) as JSErrorReporter
declare function JS_NewRegExpObject (byval cx as JSContext ptr, byval bytes as zstring ptr, byval length as size_t, byval flags as uintN) as JSObject ptr
declare function JS_NewUCRegExpObject (byval cx as JSContext ptr, byval chars as jschar ptr, byval length as size_t, byval flags as uintN) as JSObject ptr
declare sub JS_SetRegExpInput (byval cx as JSContext ptr, byval input as JSString ptr, byval multiline as JSBool)
declare sub JS_ClearRegExpStatics (byval cx as JSContext ptr)
declare sub JS_ClearRegExpRoots (byval cx as JSContext ptr)
declare function JS_IsExceptionPending (byval cx as JSContext ptr) as JSBool
declare function JS_GetPendingException (byval cx as JSContext ptr, byval vp as jsval ptr) as JSBool
declare sub JS_SetPendingException (byval cx as JSContext ptr, byval v as jsval)
declare sub JS_ClearPendingException (byval cx as JSContext ptr)
declare function JS_ReportPendingException (byval cx as JSContext ptr) as JSBool
declare function JS_SaveExceptionState (byval cx as JSContext ptr) as JSExceptionState ptr
declare sub JS_RestoreExceptionState (byval cx as JSContext ptr, byval state as JSExceptionState ptr)
declare sub JS_DropExceptionState (byval cx as JSContext ptr, byval state as JSExceptionState ptr)
declare function JS_ErrorFromException (byval cx as JSContext ptr, byval v as jsval) as JSErrorReport ptr
end extern

#endif
