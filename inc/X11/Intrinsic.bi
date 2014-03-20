''
''
'' Intrinsic -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __Intrinsic_bi__
#define __Intrinsic_bi__

#define XtSpecificationRelease 6

#define FALSE 0
#define TRUE 1

type Widget as _WidgetRec ptr
type WidgetList as Widget ptr
type WidgetClass as _WidgetClassRec ptr
type CompositeWidget as _CompositeRec ptr
type XtActionList as _XtActionsRec ptr
type XtEventTable as _XtEventRec ptr
type XtAppContext as _XtAppStruct ptr
type XtValueMask as uinteger
type XtIntervalId as uinteger
type XtInputId as uinteger
type XtWorkProcId as uinteger
type XtSignalId as uinteger
type XtGeometryMask as uinteger
type XtGCMask as uinteger
type Pixel as uinteger
type XtCacheType as integer

#define XtCacheNone &h001
#define XtCacheAll &h002
#define XtCacheByDisplay &h003
#define XtCacheRefCount &h100

type Boolean as byte
type XtArgVal as integer
type XtEnum as ubyte
type Cardinal as uinteger
type Dimension as ushort
type Position as short
type XtPointer as any ptr
type Opaque as XtPointer
type XtTranslations as _TranslationData ptr
type XtAccelerators as _TranslationData ptr
type Modifiers as uinteger
type XtActionProc as sub cdecl(byval as Widget, byval as XEvent ptr, byval as zstring ptr ptr, byval as Cardinal ptr)
type XtBoundActions as XtActionProc ptr

type _XtActionsRec
	string as zstring ptr
	proc as XtActionProc
end type

type XtActionsRec as _XtActionsRec

enum XtAddressMode
	XtAddress
	XtBaseOffset
	XtImmediate
	XtResourceString
	XtResourceQuark
	XtWidgetBaseOffset
	XtProcedureArg
end enum


type XtConvertArgRec
	address_mode as XtAddressMode
	address_id as XtPointer
	size as Cardinal
end type

type XtConvertArgList as XtConvertArgRec ptr
type XtConvertArgProc as sub cdecl(byval as Widget, byval as Cardinal ptr, byval as XrmValue ptr)

type XtWidgetGeometry
	request_mode as XtGeometryMask
	x as Position
	y as Position
	width as Dimension
	height as Dimension
	border_width as Dimension
	sibling as Widget
	stack_mode as integer
end type

#define XtCWQueryOnly (1 shl 7)
#define XtSMDontChange 5

type XtConverter as sub cdecl(byval as XrmValue ptr, byval as Cardinal ptr, byval as XrmValue ptr, byval as XrmValue ptr)
type XtTypeConverter as function cdecl(byval as Display ptr, byval as XrmValue ptr, byval as Cardinal ptr, byval as XrmValue ptr, byval as XrmValue ptr, byval as XtPointer ptr) as Boolean
type XtDestructor as sub cdecl(byval as XtAppContext, byval as XrmValue ptr, byval as XtPointer, byval as XrmValue ptr, byval as Cardinal ptr)
type XtCacheRef as Opaque
type XtActionHookId as Opaque
type XtActionHookProc as sub cdecl(byval as Widget, byval as XtPointer, byval as zstring ptr, byval as XEvent ptr, byval as zstring ptr ptr, byval as Cardinal ptr)
type XtBlockHookId as uinteger
type XtBlockHookProc as sub cdecl(byval as XtPointer)
type XtKeyProc as sub cdecl(byval as Display ptr, byval as KeyCode, byval as Modifiers, byval as Modifiers ptr, byval as KeySym ptr)
type XtCaseProc as sub cdecl(byval as Display ptr, byval as KeySym, byval as KeySym ptr, byval as KeySym ptr)
type XtEventHandler as sub cdecl(byval as Widget, byval as XtPointer, byval as XEvent ptr, byval as Boolean ptr)
type EventMask as uinteger

enum XtListPosition
	XtListHead
	XtListTail
end enum

type XtInputMask as uinteger

#define XtInputNoneMask 0L
#define XtInputReadMask (1L shl 0)
#define XtInputWriteMask (1L shl 1)
#define XtInputExceptMask (1L shl 2)

type XtTimerCallbackProc as sub cdecl(byval as XtPointer, byval as XtIntervalId ptr)
type XtInputCallbackProc as sub cdecl(byval as XtPointer, byval as integer ptr, byval as XtInputId ptr)
type XtSignalCallbackProc as sub cdecl(byval as XtPointer, byval as XtSignalId ptr)

type Arg
	name as zstring ptr
	value as XtArgVal
end type

type ArgList as Arg ptr
type XtVarArgsList as XtPointer
type XtCallbackProc as sub cdecl(byval as Widget, byval as XtPointer, byval as XtPointer)

type _XtCallbackRec
	callback as XtCallbackProc
	closure as XtPointer
end type

type XtCallbackRec as _XtCallbackRec
type XtCallbackList as _XtCallbackRec ptr

enum XtCallbackStatus
	XtCallbackNoList
	XtCallbackHasNone
	XtCallbackHasSome
end enum


enum XtGeometryResult
	XtGeometryYes
	XtGeometryNo
	XtGeometryAlmost
	XtGeometryDone
end enum


enum XtGrabKind
	XtGrabNone
	XtGrabNonexclusive
	XtGrabExclusive
end enum


type XtPopdownIDRec
	shell_widget as Widget
	enable_widget as Widget
end type

type XtPopdownID as XtPopdownIDRec ptr

type _XtResource
	resource_name as zstring ptr
	resource_class as zstring ptr
	resource_type as zstring ptr
	resource_size as Cardinal
	resource_offset as Cardinal
	default_type as zstring ptr
	default_addr as XtPointer
end type

type XtResource as _XtResource
type XtResourceList as _XtResource ptr
type XtResourceDefaultProc as sub cdecl(byval as Widget, byval as integer, byval as XrmValue ptr)
type XtLanguageProc as function cdecl(byval as Display ptr, byval as zstring ptr, byval as XtPointer) as zstring ptr
type XtErrorMsgHandler as sub cdecl(byval as zstring ptr, byval as zstring ptr, byval as zstring ptr, byval as zstring ptr, byval as zstring ptr ptr, byval as Cardinal ptr)
type XtErrorHandler as sub cdecl(byval as zstring ptr)
type XtCreatePopupChildProc as sub cdecl(byval as Widget)
type XtWorkProc as function cdecl(byval as XtPointer) as Boolean

type SubstitutionRec
	match as byte
	substitution as zstring ptr
end type

type Substitution as SubstitutionRec ptr
type XtFilePredicate as function cdecl(byval as zstring ptr) as Boolean
type XtRequestId as XtPointer
type XtConvertSelectionProc as function cdecl(byval as Widget, byval as Atom ptr, byval as Atom ptr, byval as Atom ptr, byval as XtPointer ptr, byval as uinteger ptr, byval as integer ptr) as Boolean
type XtLoseSelectionProc as sub cdecl(byval as Widget, byval as Atom ptr)
type XtSelectionDoneProc as sub cdecl(byval as Widget, byval as Atom ptr, byval as Atom ptr)
type XtSelectionCallbackProc as sub cdecl(byval as Widget, byval as XtPointer, byval as Atom ptr, byval as Atom ptr, byval as XtPointer, byval as uinteger ptr, byval as integer ptr)
type XtLoseSelectionIncrProc as sub cdecl(byval as Widget, byval as Atom ptr, byval as XtPointer)
type XtSelectionDoneIncrProc as sub cdecl(byval as Widget, byval as Atom ptr, byval as Atom ptr, byval as XtRequestId ptr, byval as XtPointer)
type XtConvertSelectionIncrProc as function cdecl(byval as Widget, byval as Atom ptr, byval as Atom ptr, byval as Atom ptr, byval as XtPointer ptr, byval as uinteger ptr, byval as integer ptr, byval as uinteger ptr, byval as XtPointer, byval as XtRequestId ptr) as Boolean
type XtCancelConvertSelectionProc as sub cdecl(byval as Widget, byval as Atom ptr, byval as Atom ptr, byval as XtRequestId ptr, byval as XtPointer)
type XtEventDispatchProc as function cdecl(byval as XEvent ptr) as Boolean
type XtExtensionSelectProc as sub cdecl(byval as Widget, byval as integer ptr, byval as XtPointer ptr, byval as integer, byval as XtPointer)

declare function XtCallConverter cdecl alias "XtCallConverter" (byval as Display ptr, byval as XtTypeConverter, byval as XrmValuePtr, byval as Cardinal, byval as XrmValuePtr, byval as XrmValue ptr, byval as XtCacheRef ptr) as Boolean
declare function XtDispatchEvent cdecl alias "XtDispatchEvent" (byval as XEvent ptr) as Boolean
declare function XtCallAcceptFocus cdecl alias "XtCallAcceptFocus" (byval as Widget, byval as Time ptr) as Boolean
declare function XtPeekEvent cdecl alias "XtPeekEvent" (byval as XEvent ptr) as Boolean
declare function XtAppPeekEvent cdecl alias "XtAppPeekEvent" (byval as XtAppContext, byval as XEvent ptr) as Boolean
declare function XtIsSubclass cdecl alias "XtIsSubclass" (byval as Widget, byval as WidgetClass) as Boolean
declare function XtIsObject cdecl alias "XtIsObject" (byval as Widget) as Boolean
declare function _XtCheckSubclassFlag cdecl alias "_XtCheckSubclassFlag" (byval as Widget, byval as XtEnum) as Boolean
declare function _XtIsSubclassOf cdecl alias "_XtIsSubclassOf" (byval as Widget, byval as WidgetClass, byval as WidgetClass, byval as XtEnum) as Boolean
declare function XtIsManaged cdecl alias "XtIsManaged" (byval as Widget) as Boolean
declare function XtIsRealized cdecl alias "XtIsRealized" (byval as Widget) as Boolean
declare function XtIsSensitive cdecl alias "XtIsSensitive" (byval as Widget) as Boolean
declare function XtOwnSelection cdecl alias "XtOwnSelection" (byval as Widget, byval as Atom, byval as Time, byval as XtConvertSelectionProc, byval as XtLoseSelectionProc, byval as XtSelectionDoneProc) as Boolean
declare function XtOwnSelectionIncremental cdecl alias "XtOwnSelectionIncremental" (byval as Widget, byval as Atom, byval as Time, byval as XtConvertSelectionIncrProc, byval as XtLoseSelectionIncrProc, byval as XtSelectionDoneIncrProc, byval as XtCancelConvertSelectionProc, byval as XtPointer) as Boolean
declare function XtMakeResizeRequest cdecl alias "XtMakeResizeRequest" (byval as Widget, byval as Dimension, byval as Dimension, byval as Dimension ptr, byval as Dimension ptr) as XtGeometryResult
declare sub XtTranslateCoords cdecl alias "XtTranslateCoords" (byval as Widget, byval as Position, byval as Position, byval as Position ptr, byval as Position ptr)
declare function XtGetKeysymTable cdecl alias "XtGetKeysymTable" (byval as Display ptr, byval as KeyCode ptr, byval as integer ptr) as KeySym ptr
declare sub XtKeysymToKeycodeList cdecl alias "XtKeysymToKeycodeList" (byval as Display ptr, byval as KeySym, byval as KeyCode ptr ptr, byval as Cardinal ptr)
extern colorConvertArgs(0 to -1) alias "colorConvertArgs" as XtConvertArgRec
extern screenConvertArg(0 to -1) alias "screenConvertArg" as XtConvertArgRec
declare sub XtDirectConvert cdecl alias "XtDirectConvert" (byval as XtConverter, byval as XrmValuePtr, byval as Cardinal, byval as XrmValuePtr, byval as XrmValue ptr)
declare sub XtOverrideTranslations cdecl alias "XtOverrideTranslations" (byval as Widget, byval as XtTranslations)
declare sub XtAugmentTranslations cdecl alias "XtAugmentTranslations" (byval as Widget, byval as XtTranslations)
declare sub XtInstallAccelerators cdecl alias "XtInstallAccelerators" (byval as Widget, byval as Widget)
declare sub XtInstallAllAccelerators cdecl alias "XtInstallAllAccelerators" (byval as Widget, byval as Widget)
declare sub XtUninstallTranslations cdecl alias "XtUninstallTranslations" (byval as Widget)
declare sub XtAppAddActions cdecl alias "XtAppAddActions" (byval as XtAppContext, byval as XtActionList, byval as Cardinal)
declare sub XtAddActions cdecl alias "XtAddActions" (byval as XtActionList, byval as Cardinal)
declare function XtAppAddActionHook cdecl alias "XtAppAddActionHook" (byval as XtAppContext, byval as XtActionHookProc, byval as XtPointer) as XtActionHookId
declare sub XtRemoveActionHook cdecl alias "XtRemoveActionHook" (byval as XtActionHookId)
declare sub XtGetActionList cdecl alias "XtGetActionList" (byval as WidgetClass, byval as XtActionList ptr, byval as Cardinal ptr)
declare sub XtRegisterGrabAction cdecl alias "XtRegisterGrabAction" (byval as XtActionProc, byval as Boolean, byval as uinteger, byval as integer, byval as integer)
declare sub XtSetMultiClickTime cdecl alias "XtSetMultiClickTime" (byval as Display ptr, byval as integer)
declare function XtGetMultiClickTime cdecl alias "XtGetMultiClickTime" (byval as Display ptr) as integer
declare function XtGetActionKeysym cdecl alias "XtGetActionKeysym" (byval as XEvent ptr, byval as Modifiers ptr) as KeySym
declare sub XtTranslateKeycode cdecl alias "XtTranslateKeycode" (byval as Display ptr, byval as KeyCode, byval as Modifiers, byval as Modifiers ptr, byval as KeySym ptr)
declare sub XtTranslateKey cdecl alias "XtTranslateKey" (byval as Display ptr, byval as KeyCode, byval as Modifiers, byval as Modifiers ptr, byval as KeySym ptr)
declare sub XtSetKeyTranslator cdecl alias "XtSetKeyTranslator" (byval as Display ptr, byval as XtKeyProc)
declare sub XtRegisterCaseConverter cdecl alias "XtRegisterCaseConverter" (byval as Display ptr, byval as XtCaseProc, byval as KeySym, byval as KeySym)
declare sub XtConvertCase cdecl alias "XtConvertCase" (byval as Display ptr, byval as KeySym, byval as KeySym ptr, byval as KeySym ptr)
declare sub XtAddEventHandler cdecl alias "XtAddEventHandler" (byval as Widget, byval as EventMask, byval as Boolean, byval as XtEventHandler, byval as XtPointer)
declare sub XtRemoveEventHandler cdecl alias "XtRemoveEventHandler" (byval as Widget, byval as EventMask, byval as Boolean, byval as XtEventHandler, byval as XtPointer)
declare sub XtAddRawEventHandler cdecl alias "XtAddRawEventHandler" (byval as Widget, byval as EventMask, byval as Boolean, byval as XtEventHandler, byval as XtPointer)
declare sub XtRemoveRawEventHandler cdecl alias "XtRemoveRawEventHandler" (byval as Widget, byval as EventMask, byval as Boolean, byval as XtEventHandler, byval as XtPointer)
declare sub XtInsertEventHandler cdecl alias "XtInsertEventHandler" (byval as Widget, byval as EventMask, byval as Boolean, byval as XtEventHandler, byval as XtPointer, byval as XtListPosition)
declare sub XtInsertRawEventHandler cdecl alias "XtInsertRawEventHandler" (byval as Widget, byval as EventMask, byval as Boolean, byval as XtEventHandler, byval as XtPointer, byval as XtListPosition)
declare function XtSetEventDispatcher cdecl alias "XtSetEventDispatcher" (byval as Display ptr, byval as integer, byval as XtEventDispatchProc) as XtEventDispatchProc
declare function XtDispatchEventToWidget cdecl alias "XtDispatchEventToWidget" (byval as Widget, byval as XEvent ptr) as Boolean
declare sub XtInsertEventTypeHandler cdecl alias "XtInsertEventTypeHandler" (byval as Widget, byval as integer, byval as XtPointer, byval as XtEventHandler, byval as XtPointer, byval as XtListPosition)
declare sub XtRemoveEventTypeHandler cdecl alias "XtRemoveEventTypeHandler" (byval as Widget, byval as integer, byval as XtPointer, byval as XtEventHandler, byval as XtPointer)
declare function XtBuildEventMask cdecl alias "XtBuildEventMask" (byval as Widget) as EventMask
declare sub XtRegisterExtensionSelector cdecl alias "XtRegisterExtensionSelector" (byval as Display ptr, byval as integer, byval as integer, byval as XtExtensionSelectProc, byval as XtPointer)
declare sub XtAddGrab cdecl alias "XtAddGrab" (byval as Widget, byval as Boolean, byval as Boolean)
declare sub XtRemoveGrab cdecl alias "XtRemoveGrab" (byval as Widget)
declare sub XtProcessEvent cdecl alias "XtProcessEvent" (byval as XtInputMask)
declare sub XtAppProcessEvent cdecl alias "XtAppProcessEvent" (byval as XtAppContext, byval as XtInputMask)
declare sub XtMainLoop cdecl alias "XtMainLoop" ()
declare sub XtAppMainLoop cdecl alias "XtAppMainLoop" (byval as XtAppContext)
declare sub XtAddExposureToRegion cdecl alias "XtAddExposureToRegion" (byval as XEvent ptr, byval as Region)
declare sub XtSetKeyboardFocus cdecl alias "XtSetKeyboardFocus" (byval as Widget, byval as Widget)
declare function XtGetKeyboardFocusWidget cdecl alias "XtGetKeyboardFocusWidget" (byval as Widget) as Widget
declare function XtLastEventProcessed cdecl alias "XtLastEventProcessed" (byval as Display ptr) as XEvent ptr
declare function XtLastTimestampProcessed cdecl alias "XtLastTimestampProcessed" (byval as Display ptr) as Time
declare function XtAddTimeOut cdecl alias "XtAddTimeOut" (byval as uinteger, byval as XtTimerCallbackProc, byval as XtPointer) as XtIntervalId
declare function XtAppAddTimeOut cdecl alias "XtAppAddTimeOut" (byval as XtAppContext, byval as uinteger, byval as XtTimerCallbackProc, byval as XtPointer) as XtIntervalId
declare sub XtRemoveTimeOut cdecl alias "XtRemoveTimeOut" (byval as XtIntervalId)
declare function XtAddInput cdecl alias "XtAddInput" (byval as integer, byval as XtPointer, byval as XtInputCallbackProc, byval as XtPointer) as XtInputId
declare function XtAppAddInput cdecl alias "XtAppAddInput" (byval as XtAppContext, byval as integer, byval as XtPointer, byval as XtInputCallbackProc, byval as XtPointer) as XtInputId
declare sub XtRemoveInput cdecl alias "XtRemoveInput" (byval as XtInputId)
declare function XtAddSignal cdecl alias "XtAddSignal" (byval as XtSignalCallbackProc, byval as XtPointer) as XtSignalId
declare function XtAppAddSignal cdecl alias "XtAppAddSignal" (byval as XtAppContext, byval as XtSignalCallbackProc, byval as XtPointer) as XtSignalId
declare sub XtRemoveSignal cdecl alias "XtRemoveSignal" (byval as XtSignalId)
declare sub XtNoticeSignal cdecl alias "XtNoticeSignal" (byval as XtSignalId)
declare sub XtNextEvent cdecl alias "XtNextEvent" (byval as XEvent ptr)
declare sub XtAppNextEvent cdecl alias "XtAppNextEvent" (byval as XtAppContext, byval as XEvent ptr)

#define XtIMXEvent 1
#define XtIMTimer 2
#define XtIMAlternateInput 4
#define XtIMSignal 8
#define XtIMAll (1 or 2 or 4 or 8)

declare function XtPending cdecl alias "XtPending" () as Boolean
declare function XtAppPending cdecl alias "XtAppPending" (byval as XtAppContext) as XtInputMask
declare function XtAppAddBlockHook cdecl alias "XtAppAddBlockHook" (byval as XtAppContext, byval as XtBlockHookProc, byval as XtPointer) as XtBlockHookId
declare sub XtRemoveBlockHook cdecl alias "XtRemoveBlockHook" (byval as XtBlockHookId)
declare function XtIsOverrideShell cdecl alias "XtIsOverrideShell" (byval as Widget) as Boolean
declare function XtIsVendorShell cdecl alias "XtIsVendorShell" (byval as Widget) as Boolean
declare function XtIsTransientShell cdecl alias "XtIsTransientShell" (byval as Widget) as Boolean
declare function XtIsApplicationShell cdecl alias "XtIsApplicationShell" (byval as Widget) as Boolean
declare function XtIsSessionShell cdecl alias "XtIsSessionShell" (byval as Widget) as Boolean
declare sub XtRealizeWidget cdecl alias "XtRealizeWidget" (byval as Widget)
declare sub XtUnrealizeWidget cdecl alias "XtUnrealizeWidget" (byval as Widget)
declare sub XtDestroyWidget cdecl alias "XtDestroyWidget" (byval as Widget)
declare sub XtSetSensitive cdecl alias "XtSetSensitive" (byval as Widget, byval as Boolean)
declare sub XtSetMappedWhenManaged cdecl alias "XtSetMappedWhenManaged" (byval as Widget, byval as Boolean)
declare function XtWindowToWidget cdecl alias "XtWindowToWidget" (byval as Display ptr, byval as Window) as Widget
declare function XtGetClassExtension cdecl alias "XtGetClassExtension" (byval as WidgetClass, byval as Cardinal, byval as XrmQuark, byval as integer, byval as Cardinal) as XtPointer
declare function XtMergeArgLists cdecl alias "XtMergeArgLists" (byval as ArgList, byval as Cardinal, byval as ArgList, byval as Cardinal) as ArgList

#define XtVaNestedList "XtVaNestedList"
#define XtVaTypedArg "XtVaTypedArg"

declare function XtDisplay cdecl alias "XtDisplay" (byval as Widget) as Display ptr
declare function XtDisplayOfObject cdecl alias "XtDisplayOfObject" (byval as Widget) as Display ptr
declare function XtScreen cdecl alias "XtScreen" (byval as Widget) as Screen ptr
declare function XtScreenOfObject cdecl alias "XtScreenOfObject" (byval as Widget) as Screen ptr
declare function XtWindow cdecl alias "XtWindow" (byval as Widget) as Window
declare function XtWindowOfObject cdecl alias "XtWindowOfObject" (byval as Widget) as Window
declare function XtName cdecl alias "XtName" (byval as Widget) as zstring ptr
declare function XtSuperclass cdecl alias "XtSuperclass" (byval as Widget) as WidgetClass
declare function XtClass cdecl alias "XtClass" (byval as Widget) as WidgetClass
declare function XtParent cdecl alias "XtParent" (byval as Widget) as Widget
declare sub XtMapWidget cdecl alias "XtMapWidget" (byval as Widget)
declare sub XtUnmapWidget cdecl alias "XtUnmapWidget" (byval as Widget)
declare sub XtCallCallbackList cdecl alias "XtCallCallbackList" (byval as Widget, byval as XtCallbackList, byval as XtPointer)
declare function XtMakeGeometryRequest cdecl alias "XtMakeGeometryRequest" (byval as Widget, byval as XtWidgetGeometry ptr, byval as XtWidgetGeometry ptr) as XtGeometryResult
declare function XtQueryGeometry cdecl alias "XtQueryGeometry" (byval as Widget, byval as XtWidgetGeometry ptr, byval as XtWidgetGeometry ptr) as XtGeometryResult
declare sub XtPopup cdecl alias "XtPopup" (byval as Widget, byval as XtGrabKind)
declare sub XtPopupSpringLoaded cdecl alias "XtPopupSpringLoaded" (byval as Widget)
declare sub XtCallbackNone cdecl alias "XtCallbackNone" (byval as Widget, byval as XtPointer, byval as XtPointer)
declare sub XtCallbackNonexclusive cdecl alias "XtCallbackNonexclusive" (byval as Widget, byval as XtPointer, byval as XtPointer)
declare sub XtCallbackExclusive cdecl alias "XtCallbackExclusive" (byval as Widget, byval as XtPointer, byval as XtPointer)
declare sub XtPopdown cdecl alias "XtPopdown" (byval as Widget)
declare sub XtCallbackPopdown cdecl alias "XtCallbackPopdown" (byval as Widget, byval as XtPointer, byval as XtPointer)
declare sub XtMenuPopupAction cdecl alias "XtMenuPopupAction" (byval as Widget, byval as XEvent ptr, byval as zstring ptr ptr, byval as Cardinal ptr)
declare sub XtToolkitInitialize cdecl alias "XtToolkitInitialize" ()
declare function XtSetLanguageProc cdecl alias "XtSetLanguageProc" (byval as XtAppContext, byval as XtLanguageProc, byval as XtPointer) as XtLanguageProc
declare function XtCreateApplicationContext cdecl alias "XtCreateApplicationContext" () as XtAppContext
declare sub XtAppSetFallbackResources cdecl alias "XtAppSetFallbackResources" (byval as XtAppContext, byval as zstring ptr ptr)
declare sub XtDestroyApplicationContext cdecl alias "XtDestroyApplicationContext" (byval as XtAppContext)
declare sub XtInitializeWidgetClass cdecl alias "XtInitializeWidgetClass" (byval as WidgetClass)
declare function XtWidgetToApplicationContext cdecl alias "XtWidgetToApplicationContext" (byval as Widget) as XtAppContext
declare function XtDisplayToApplicationContext cdecl alias "XtDisplayToApplicationContext" (byval as Display ptr) as XtAppContext
declare function XtDatabase cdecl alias "XtDatabase" (byval as Display ptr) as XrmDatabase
declare function XtScreenDatabase cdecl alias "XtScreenDatabase" (byval as Screen ptr) as XrmDatabase
declare sub XtCloseDisplay cdecl alias "XtCloseDisplay" (byval as Display ptr)
declare sub XtGetApplicationResources cdecl alias "XtGetApplicationResources" (byval as Widget, byval as XtPointer, byval as XtResourceList, byval as Cardinal, byval as ArgList, byval as Cardinal)
declare sub XtSetValues cdecl alias "XtSetValues" (byval as Widget, byval as ArgList, byval as Cardinal)
declare sub XtGetValues cdecl alias "XtGetValues" (byval as Widget, byval as ArgList, byval as Cardinal)
declare sub XtSetSubvalues cdecl alias "XtSetSubvalues" (byval as XtPointer, byval as XtResourceList, byval as Cardinal, byval as ArgList, byval as Cardinal)
declare sub XtGetSubvalues cdecl alias "XtGetSubvalues" (byval as XtPointer, byval as XtResourceList, byval as Cardinal, byval as ArgList, byval as Cardinal)
declare sub XtGetResourceList cdecl alias "XtGetResourceList" (byval as WidgetClass, byval as XtResourceList ptr, byval as Cardinal ptr)
declare sub XtGetConstraintResourceList cdecl alias "XtGetConstraintResourceList" (byval as WidgetClass, byval as XtResourceList ptr, byval as Cardinal ptr)

#define XtUnspecifiedShellInt (-1)
#define XtCurrentDirectory "XtCurrentDirectory"
#define XtDefaultForeground "XtDefaultForeground"
#define XtDefaultBackground "XtDefaultBackground"
#define XtDefaultFont "XtDefaultFont"
#define XtDefaultFontSet "XtDefaultFontSet"

type _XtCheckpointTokenRec
	save_type as integer
	interact_style as integer
	shutdown as Boolean
	fast as Boolean
	cancel_shutdown as Boolean
	phase as integer
	interact_dialog_type as integer
	request_cancel as Boolean
	request_next_phase as Boolean
	save_success as Boolean
	type as integer
	widget as Widget
end type

type XtCheckpointTokenRec as _XtCheckpointTokenRec
type XtCheckpointToken as _XtCheckpointTokenRec ptr

declare function XtSessionGetToken cdecl alias "XtSessionGetToken" (byval as Widget) as XtCheckpointToken
declare sub XtSessionReturnToken cdecl alias "XtSessionReturnToken" (byval as XtCheckpointToken)
declare function XtAppSetErrorMsgHandler cdecl alias "XtAppSetErrorMsgHandler" (byval as XtAppContext, byval as XtErrorMsgHandler) as XtErrorMsgHandler
declare sub XtSetErrorMsgHandler cdecl alias "XtSetErrorMsgHandler" (byval as XtErrorMsgHandler)
declare function XtAppSetWarningMsgHandler cdecl alias "XtAppSetWarningMsgHandler" (byval as XtAppContext, byval as XtErrorMsgHandler) as XtErrorMsgHandler
declare sub XtSetWarningMsgHandler cdecl alias "XtSetWarningMsgHandler" (byval as XtErrorMsgHandler)
declare function XtAppSetErrorHandler cdecl alias "XtAppSetErrorHandler" (byval as XtAppContext, byval as XtErrorHandler) as XtErrorHandler
declare sub XtSetErrorHandler cdecl alias "XtSetErrorHandler" (byval as XtErrorHandler)
declare function XtAppSetWarningHandler cdecl alias "XtAppSetWarningHandler" (byval as XtAppContext, byval as XtErrorHandler) as XtErrorHandler
declare sub XtSetWarningHandler cdecl alias "XtSetWarningHandler" (byval as XtErrorHandler)
declare function XtAppGetErrorDatabase cdecl alias "XtAppGetErrorDatabase" (byval as XtAppContext) as XrmDatabase ptr
declare function XtGetErrorDatabase cdecl alias "XtGetErrorDatabase" () as XrmDatabase ptr
declare function XtMalloc cdecl alias "XtMalloc" (byval as Cardinal) as zstring ptr
declare function XtCalloc cdecl alias "XtCalloc" (byval as Cardinal, byval as Cardinal) as zstring ptr
declare function XtRealloc cdecl alias "XtRealloc" (byval as zstring ptr, byval as Cardinal) as zstring ptr
declare sub XtFree cdecl alias "XtFree" (byval as zstring ptr)
declare function XtNewString cdecl alias "XtNewString" (byval as zstring ptr) as zstring ptr
declare function XtAddWorkProc cdecl alias "XtAddWorkProc" (byval as XtWorkProc, byval as XtPointer) as XtWorkProcId
declare function XtAppAddWorkProc cdecl alias "XtAppAddWorkProc" (byval as XtAppContext, byval as XtWorkProc, byval as XtPointer) as XtWorkProcId
declare sub XtRemoveWorkProc cdecl alias "XtRemoveWorkProc" (byval as XtWorkProcId)
declare function XtGetGC cdecl alias "XtGetGC" (byval as Widget, byval as XtGCMask, byval as XGCValues ptr) as GC
declare function XtAllocateGC cdecl alias "XtAllocateGC" (byval as Widget, byval as Cardinal, byval as XtGCMask, byval as XGCValues ptr, byval as XtGCMask, byval as XtGCMask) as GC
declare sub XtDestroyGC cdecl alias "XtDestroyGC" (byval as GC)
declare sub XtReleaseGC cdecl alias "XtReleaseGC" (byval as Widget, byval as GC)
declare sub XtAppReleaseCacheRefs cdecl alias "XtAppReleaseCacheRefs" (byval as XtAppContext, byval as XtCacheRef ptr)
declare sub XtCallbackReleaseCacheRef cdecl alias "XtCallbackReleaseCacheRef" (byval as Widget, byval as XtPointer, byval as XtPointer)
declare sub XtCallbackReleaseCacheRefList cdecl alias "XtCallbackReleaseCacheRefList" (byval as Widget, byval as XtPointer, byval as XtPointer)
declare sub XtSetWMColormapWindows cdecl alias "XtSetWMColormapWindows" (byval as Widget, byval as Widget ptr, byval as Cardinal)
declare sub XtDisownSelection cdecl alias "XtDisownSelection" (byval as Widget, byval as Atom, byval as Time)
declare sub XtGetSelectionValue cdecl alias "XtGetSelectionValue" (byval as Widget, byval as Atom, byval as Atom, byval as XtSelectionCallbackProc, byval as XtPointer, byval as Time)
declare sub XtGetSelectionValues cdecl alias "XtGetSelectionValues" (byval as Widget, byval as Atom, byval as Atom ptr, byval as integer, byval as XtSelectionCallbackProc, byval as XtPointer ptr, byval as Time)
declare sub XtAppSetSelectionTimeout cdecl alias "XtAppSetSelectionTimeout" (byval as XtAppContext, byval as uinteger)
declare sub XtSetSelectionTimeout cdecl alias "XtSetSelectionTimeout" (byval as uinteger)
declare function XtAppGetSelectionTimeout cdecl alias "XtAppGetSelectionTimeout" (byval as XtAppContext) as uinteger
declare function XtGetSelectionTimeout cdecl alias "XtGetSelectionTimeout" () as uinteger
declare function XtGetSelectionRequest cdecl alias "XtGetSelectionRequest" (byval as Widget, byval as Atom, byval as XtRequestId) as XSelectionRequestEvent ptr
declare sub XtGetSelectionValueIncremental cdecl alias "XtGetSelectionValueIncremental" (byval as Widget, byval as Atom, byval as Atom, byval as XtSelectionCallbackProc, byval as XtPointer, byval as Time)
declare sub XtGetSelectionValuesIncremental cdecl alias "XtGetSelectionValuesIncremental" (byval as Widget, byval as Atom, byval as Atom ptr, byval as integer, byval as XtSelectionCallbackProc, byval as XtPointer ptr, byval as Time)
declare sub XtSetSelectionParameters cdecl alias "XtSetSelectionParameters" (byval as Widget, byval as Atom, byval as Atom, byval as XtPointer, byval as uinteger, byval as integer)
declare sub XtGetSelectionParameters cdecl alias "XtGetSelectionParameters" (byval as Widget, byval as Atom, byval as XtRequestId, byval as Atom ptr, byval as XtPointer ptr, byval as uinteger ptr, byval as integer ptr)
declare sub XtCreateSelectionRequest cdecl alias "XtCreateSelectionRequest" (byval as Widget, byval as Atom)
declare sub XtSendSelectionRequest cdecl alias "XtSendSelectionRequest" (byval as Widget, byval as Atom, byval as Time)
declare sub XtCancelSelectionRequest cdecl alias "XtCancelSelectionRequest" (byval as Widget, byval as Atom)
declare function XtReservePropertyAtom cdecl alias "XtReservePropertyAtom" (byval as Widget) as Atom
declare sub XtReleasePropertyAtom cdecl alias "XtReleasePropertyAtom" (byval as Widget, byval as Atom)
declare sub XtGrabKey cdecl alias "XtGrabKey" (byval as Widget, byval as KeyCode, byval as Modifiers, byval as Boolean, byval as integer, byval as integer)
declare sub XtUngrabKey cdecl alias "XtUngrabKey" (byval as Widget, byval as KeyCode, byval as Modifiers)
declare function XtGrabKeyboard cdecl alias "XtGrabKeyboard" (byval as Widget, byval as Boolean, byval as integer, byval as integer, byval as Time) as integer
declare sub XtUngrabKeyboard cdecl alias "XtUngrabKeyboard" (byval as Widget, byval as Time)
declare sub XtGrabButton cdecl alias "XtGrabButton" (byval as Widget, byval as integer, byval as Modifiers, byval as Boolean, byval as uinteger, byval as integer, byval as integer, byval as Window, byval as Cursor)
declare sub XtUngrabButton cdecl alias "XtUngrabButton" (byval as Widget, byval as uinteger, byval as Modifiers)
declare function XtGrabPointer cdecl alias "XtGrabPointer" (byval as Widget, byval as Boolean, byval as uinteger, byval as integer, byval as integer, byval as Window, byval as Cursor, byval as Time) as integer
declare sub XtUngrabPointer cdecl alias "XtUngrabPointer" (byval as Widget, byval as Time)
declare sub XtGetApplicationNameAndClass cdecl alias "XtGetApplicationNameAndClass" (byval as Display ptr, byval as zstring ptr ptr, byval as zstring ptr ptr)
declare sub XtRegisterDrawable cdecl alias "XtRegisterDrawable" (byval as Display ptr, byval as Drawable, byval as Widget)
declare sub XtUnregisterDrawable cdecl alias "XtUnregisterDrawable" (byval as Display ptr, byval as Drawable)
declare function XtHooksOfDisplay cdecl alias "XtHooksOfDisplay" (byval as Display ptr) as Widget

type XtCreateHookDataRec
	type as zstring ptr
	widget as Widget
	args as ArgList
	num_args as Cardinal
end type

type XtCreateHookData as XtCreateHookDataRec ptr

type XtChangeHookDataRec
	type as zstring ptr
	widget as Widget
	event_data as XtPointer
	num_event_data as Cardinal
end type

type XtChangeHookData as XtChangeHookDataRec ptr

type XtChangeHookSetValuesDataRec
	old as Widget
	req as Widget
	args as ArgList
	num_args as Cardinal
end type

type XtChangeHookSetValuesData as XtChangeHookSetValuesDataRec ptr

type XtConfigureHookDataRec
	type as zstring ptr
	widget as Widget
	changeMask as XtGeometryMask
	changes as XWindowChanges
end type

type XtConfigureHookData as XtConfigureHookDataRec ptr

type XtGeometryHookDataRec
	type as zstring ptr
	widget as Widget
	request as XtWidgetGeometry ptr
	reply as XtWidgetGeometry ptr
	result as XtGeometryResult
end type

type XtGeometryHookData as XtGeometryHookDataRec ptr

type XtDestroyHookDataRec
	type as zstring ptr
	widget as Widget
end type

type XtDestroyHookData as XtDestroyHookDataRec ptr

declare sub XtGetDisplays cdecl alias "XtGetDisplays" (byval as XtAppContext, byval as Display ptr ptr ptr, byval as Cardinal ptr)
declare function XtToolkitThreadInitialize cdecl alias "XtToolkitThreadInitialize" () as Boolean
declare sub XtAppSetExitFlag cdecl alias "XtAppSetExitFlag" (byval as XtAppContext)
declare function XtAppGetExitFlag cdecl alias "XtAppGetExitFlag" (byval as XtAppContext) as Boolean
declare sub XtAppLock cdecl alias "XtAppLock" (byval as XtAppContext)
declare sub XtAppUnlock cdecl alias "XtAppUnlock" (byval as XtAppContext)
declare function XtCvtStringToAcceleratorTable cdecl alias "XtCvtStringToAcceleratorTable" (byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as Boolean
declare function XtCvtStringToAtom cdecl alias "XtCvtStringToAtom" (byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as Boolean
declare function XtCvtStringToBool cdecl alias "XtCvtStringToBool" (byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as Boolean
declare function XtCvtStringToBoolean cdecl alias "XtCvtStringToBoolean" (byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as Boolean
declare function XtCvtStringToCommandArgArray cdecl alias "XtCvtStringToCommandArgArray" (byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as Boolean
declare function XtCvtStringToCursor cdecl alias "XtCvtStringToCursor" (byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as Boolean
declare function XtCvtStringToDimension cdecl alias "XtCvtStringToDimension" (byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as Boolean
declare function XtCvtStringToDirectoryString cdecl alias "XtCvtStringToDirectoryString" (byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as Boolean
declare function XtCvtStringToDisplay cdecl alias "XtCvtStringToDisplay" (byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as Boolean
declare function XtCvtStringToFile cdecl alias "XtCvtStringToFile" (byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as Boolean
declare function XtCvtStringToFloat cdecl alias "XtCvtStringToFloat" (byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as Boolean
declare function XtCvtStringToFont cdecl alias "XtCvtStringToFont" (byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as Boolean
declare function XtCvtStringToFontSet cdecl alias "XtCvtStringToFontSet" (byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as Boolean
declare function XtCvtStringToFontStruct cdecl alias "XtCvtStringToFontStruct" (byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as Boolean
declare function XtCvtStringToGravity cdecl alias "XtCvtStringToGravity" (byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as Boolean
declare function XtCvtStringToInitialState cdecl alias "XtCvtStringToInitialState" (byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as Boolean
declare function XtCvtStringToInt cdecl alias "XtCvtStringToInt" (byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as Boolean
declare function XtCvtStringToPixel cdecl alias "XtCvtStringToPixel" (byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as Boolean
declare function XtCvtStringToRestartStyle cdecl alias "XtCvtStringToRestartStyle" (byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as Boolean
declare function XtCvtStringToShort cdecl alias "XtCvtStringToShort" (byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as Boolean
declare function XtCvtStringToTranslationTable cdecl alias "XtCvtStringToTranslationTable" (byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as Boolean
declare function XtCvtStringToUnsignedChar cdecl alias "XtCvtStringToUnsignedChar" (byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as Boolean
declare function XtCvtStringToVisual cdecl alias "XtCvtStringToVisual" (byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as Boolean
declare function XtCvtIntToBool cdecl alias "XtCvtIntToBool" (byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as Boolean
declare function XtCvtIntToBoolean cdecl alias "XtCvtIntToBoolean" (byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as Boolean
declare function XtCvtIntToColor cdecl alias "XtCvtIntToColor" (byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as Boolean
declare function XtCvtIntToFloat cdecl alias "XtCvtIntToFloat" (byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as Boolean
declare function XtCvtIntToFont cdecl alias "XtCvtIntToFont" (byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as Boolean
declare function XtCvtIntToPixel cdecl alias "XtCvtIntToPixel" (byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as Boolean
declare function XtCvtIntToPixmap cdecl alias "XtCvtIntToPixmap" (byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as Boolean
declare function XtCvtIntToShort cdecl alias "XtCvtIntToShort" (byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as Boolean
declare function XtCvtIntToUnsignedChar cdecl alias "XtCvtIntToUnsignedChar" (byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as Boolean
declare function XtCvtColorToPixel cdecl alias "XtCvtColorToPixel" (byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as Boolean

#endif
