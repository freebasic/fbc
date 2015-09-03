'' FreeBASIC binding for libXt-1.1.4
''
'' based on the C header files:
''   *********************************************************
''   Copyright 1987, 1988 by Digital Equipment Corporation, Maynard, Massachusetts,
''
''   			All Rights Reserved
''
''   Permission to use, copy, modify, and distribute this software and its
''   documentation for any purpose and without fee is hereby granted,
''   provided that the above copyright notice appear in all copies and that
''   both that copyright notice and this permission notice appear in
''   supporting documentation, and that the name Digital not be
''   used in advertising or publicity pertaining to distribution of the
''   software without specific, written prior permission.
''
''   DIGITAL DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING
''   ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT SHALL
''   DIGITAL BE LIABLE FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR
''   ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS,
''   WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION,
''   ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS
''   SOFTWARE.
''
''   *****************************************************************
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/long.bi"
#include once "X11/Xlib.bi"
#include once "X11/Xutil.bi"
#include once "X11/Xresource.bi"
#include once "X11/Xfuncproto.bi"
#include once "X11/Xosdefs.bi"
#include once "crt/string.bi"
#include once "crt/stddef.bi"

'' The following symbols have been renamed:
''     typedef String => String_
''     typedef Boolean => XBoolean
''     procedure XtIsOverrideShell => XtIsOverrideShell_
''     procedure XtIsVendorShell => XtIsVendorShell_
''     procedure XtIsTransientShell => XtIsTransientShell_
''     procedure XtIsApplicationShell => XtIsApplicationShell_
''     procedure XtIsSessionShell => XtIsSessionShell_
''     procedure XtMapWidget => XtMapWidget_
''     procedure XtUnmapWidget => XtUnmapWidget_
''     procedure XtNewString => XtNewString_

extern "C"

#define _XtIntrinsic_h
const XtSpecificationRelease = 6
type String_ as zstring ptr
#define XtNumber(arr) cast(Cardinal, sizeof(arr) / sizeof(arr[0]))
type Widget as _WidgetRec ptr
type WidgetList as Widget ptr
type WidgetClass as _WidgetClassRec ptr
type CompositeWidget as _CompositeRec ptr
type XtActionList as _XtActionsRec ptr
type XtEventTable as _XtEventRec ptr
type XtAppContext as _XtAppStruct ptr
type XtValueMask as culong
type XtIntervalId as culong
type XtInputId as culong
type XtWorkProcId as culong
type XtSignalId as culong
type XtGeometryMask as ulong
type XtGCMask as culong
type Pixel as culong
type XtCacheType as long

const XtCacheNone = &h001
const XtCacheAll = &h002
const XtCacheByDisplay = &h003
const XtCacheRefCount = &h100

type XBoolean as byte
type XtArgVal as clong
type XtEnum as ubyte
type Cardinal as ulong
type Dimension as ushort
type Position as short
type XtPointer as any ptr
type Opaque as XtPointer
type XtTranslations as _TranslationData ptr
type XtAccelerators as _TranslationData ptr
type Modifiers as ulong
type XtActionProc as sub(byval as Widget, byval as XEvent ptr, byval as String_ ptr, byval as Cardinal ptr)
type XtBoundActions as XtActionProc ptr

type _XtActionsRec
	string as String_
	proc as XtActionProc
end type

type XtActionsRec as _XtActionsRec

type XtAddressMode as long
enum
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
type XtConvertArgProc as sub(byval as Widget, byval as Cardinal ptr, byval as XrmValue ptr)

type XtWidgetGeometry
	request_mode as XtGeometryMask
	x as Position
	y as Position
	width as Dimension
	height as Dimension
	border_width as Dimension
	sibling as Widget
	stack_mode as long
end type

const XtCWQueryOnly = 1 shl 7
const XtSMDontChange = 5
type XtConverter as sub(byval as XrmValue ptr, byval as Cardinal ptr, byval as XrmValue ptr, byval as XrmValue ptr)
type XtTypeConverter as function(byval as Display ptr, byval as XrmValue ptr, byval as Cardinal ptr, byval as XrmValue ptr, byval as XrmValue ptr, byval as XtPointer ptr) as XBoolean
type XtDestructor as sub(byval as XtAppContext, byval as XrmValue ptr, byval as XtPointer, byval as XrmValue ptr, byval as Cardinal ptr)
type XtCacheRef as Opaque
type XtActionHookId as Opaque
type XtActionHookProc as sub(byval as Widget, byval as XtPointer, byval as String_, byval as XEvent ptr, byval as String_ ptr, byval as Cardinal ptr)
type XtBlockHookId as culong
type XtBlockHookProc as sub(byval as XtPointer)
type XtKeyProc as sub(byval as Display ptr, byval as KeyCode, byval as Modifiers, byval as Modifiers ptr, byval as KeySym ptr)
type XtCaseProc as sub(byval as Display ptr, byval as KeySym, byval as KeySym ptr, byval as KeySym ptr)
type XtEventHandler as sub(byval as Widget, byval as XtPointer, byval as XEvent ptr, byval as XBoolean ptr)
type EventMask as culong

type XtListPosition as long
enum
	XtListHead
	XtListTail
end enum

type XtInputMask as culong
const XtInputNoneMask = cast(clong, 0)
const XtInputReadMask = cast(clong, 1) shl 0
const XtInputWriteMask = cast(clong, 1) shl 1
const XtInputExceptMask = cast(clong, 1) shl 2

type XtTimerCallbackProc as sub(byval as XtPointer, byval as XtIntervalId ptr)
type XtInputCallbackProc as sub(byval as XtPointer, byval as long ptr, byval as XtInputId ptr)
type XtSignalCallbackProc as sub(byval as XtPointer, byval as XtSignalId ptr)

type Arg
	name as String_
	value as XtArgVal
end type

type ArgList as Arg ptr
type XtVarArgsList as XtPointer
type XtCallbackProc as sub(byval as Widget, byval as XtPointer, byval as XtPointer)

type _XtCallbackRec
	callback as XtCallbackProc
	closure as XtPointer
end type

type XtCallbackRec as _XtCallbackRec
type XtCallbackList as _XtCallbackRec ptr

type XtCallbackStatus as long
enum
	XtCallbackNoList
	XtCallbackHasNone
	XtCallbackHasSome
end enum

type XtGeometryResult as long
enum
	XtGeometryYes
	XtGeometryNo
	XtGeometryAlmost
	XtGeometryDone
end enum

type XtGrabKind as long
enum
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
	resource_name as String_
	resource_class as String_
	resource_type as String_
	resource_size as Cardinal
	resource_offset as Cardinal
	default_type as String_
	default_addr as XtPointer
end type

type XtResource as _XtResource
type XtResourceList as _XtResource ptr
type XtResourceDefaultProc as sub(byval as Widget, byval as long, byval as XrmValue ptr)
type XtLanguageProc as function(byval as Display ptr, byval as String_, byval as XtPointer) as String_
type XtErrorMsgHandler as sub(byval as String_, byval as String_, byval as String_, byval as String_, byval as String_ ptr, byval as Cardinal ptr)
type XtErrorHandler as sub(byval as String_)
type XtCreatePopupChildProc as sub(byval as Widget)
type XtWorkProc as function(byval as XtPointer) as XBoolean

type SubstitutionRec
	match as byte
	substitution as String_
end type

type Substitution as SubstitutionRec ptr
type XtFilePredicate as function(byval as String_) as XBoolean
type XtRequestId as XtPointer
type XtConvertSelectionProc as function(byval as Widget, byval as XAtom ptr, byval as XAtom ptr, byval as XAtom ptr, byval as XtPointer ptr, byval as culong ptr, byval as long ptr) as XBoolean
type XtLoseSelectionProc as sub(byval as Widget, byval as XAtom ptr)
type XtSelectionDoneProc as sub(byval as Widget, byval as XAtom ptr, byval as XAtom ptr)
type XtSelectionCallbackProc as sub(byval as Widget, byval as XtPointer, byval as XAtom ptr, byval as XAtom ptr, byval as XtPointer, byval as culong ptr, byval as long ptr)
type XtLoseSelectionIncrProc as sub(byval as Widget, byval as XAtom ptr, byval as XtPointer)
type XtSelectionDoneIncrProc as sub(byval as Widget, byval as XAtom ptr, byval as XAtom ptr, byval as XtRequestId ptr, byval as XtPointer)
type XtConvertSelectionIncrProc as function(byval as Widget, byval as XAtom ptr, byval as XAtom ptr, byval as XAtom ptr, byval as XtPointer ptr, byval as culong ptr, byval as long ptr, byval as culong ptr, byval as XtPointer, byval as XtRequestId ptr) as XBoolean
type XtCancelConvertSelectionProc as sub(byval as Widget, byval as XAtom ptr, byval as XAtom ptr, byval as XtRequestId ptr, byval as XtPointer)
type XtEventDispatchProc as function(byval as XEvent ptr) as XBoolean
type XtExtensionSelectProc as sub(byval as Widget, byval as long ptr, byval as XtPointer ptr, byval as long, byval as XtPointer)

declare function XtConvertAndStore(byval as Widget, byval as const zstring ptr, byval as XrmValue ptr, byval as const zstring ptr, byval as XrmValue ptr) as XBoolean
declare function XtCallConverter(byval as Display ptr, byval as XtTypeConverter, byval as XrmValuePtr, byval as Cardinal, byval as XrmValuePtr, byval as XrmValue ptr, byval as XtCacheRef ptr) as XBoolean
declare function XtDispatchEvent(byval as XEvent ptr) as XBoolean
declare function XtCallAcceptFocus(byval as Widget, byval as Time ptr) as XBoolean
declare function XtPeekEvent(byval as XEvent ptr) as XBoolean
declare function XtAppPeekEvent(byval as XtAppContext, byval as XEvent ptr) as XBoolean
declare function XtIsSubclass(byval as Widget, byval as WidgetClass) as XBoolean
declare function XtIsObject(byval as Widget) as XBoolean
declare function _XtCheckSubclassFlag(byval as Widget, byval as XtEnum) as XBoolean
declare function _XtIsSubclassOf(byval as Widget, byval as WidgetClass, byval as WidgetClass, byval as XtEnum) as XBoolean
declare function XtIsManaged(byval as Widget) as XBoolean
declare function XtIsRealized(byval as Widget) as XBoolean
declare function XtIsSensitive(byval as Widget) as XBoolean
declare function XtOwnSelection(byval as Widget, byval as XAtom, byval as Time, byval as XtConvertSelectionProc, byval as XtLoseSelectionProc, byval as XtSelectionDoneProc) as XBoolean
declare function XtOwnSelectionIncremental(byval as Widget, byval as XAtom, byval as Time, byval as XtConvertSelectionIncrProc, byval as XtLoseSelectionIncrProc, byval as XtSelectionDoneIncrProc, byval as XtCancelConvertSelectionProc, byval as XtPointer) as XBoolean
declare function XtMakeResizeRequest(byval as Widget, byval as Dimension, byval as Dimension, byval as Dimension ptr, byval as Dimension ptr) as XtGeometryResult
declare sub XtTranslateCoords(byval as Widget, byval as Position, byval as Position, byval as Position ptr, byval as Position ptr)
declare function XtGetKeysymTable(byval as Display ptr, byval as KeyCode ptr, byval as long ptr) as KeySym ptr
declare sub XtKeysymToKeycodeList(byval as Display ptr, byval as KeySym, byval as KeyCode ptr ptr, byval as Cardinal ptr)
declare sub XtStringConversionWarning(byval as const zstring ptr, byval as const zstring ptr)
declare sub XtDisplayStringConversionWarning(byval as Display ptr, byval as const zstring ptr, byval as const zstring ptr)
#define colorConvertArgs(i) ((@__colorConvertArgs)[i])
extern __colorConvertArgs alias "colorConvertArgs" as const XtConvertArgRec
#define screenConvertArg(i) ((@__screenConvertArg)[i])
extern __screenConvertArg alias "screenConvertArg" as const XtConvertArgRec
declare sub XtAppAddConverter(byval as XtAppContext, byval as const zstring ptr, byval as const zstring ptr, byval as XtConverter, byval as XtConvertArgList, byval as Cardinal)
declare sub XtAddConverter(byval as const zstring ptr, byval as const zstring ptr, byval as XtConverter, byval as XtConvertArgList, byval as Cardinal)
declare sub XtSetTypeConverter(byval as const zstring ptr, byval as const zstring ptr, byval as XtTypeConverter, byval as XtConvertArgList, byval as Cardinal, byval as XtCacheType, byval as XtDestructor)
declare sub XtAppSetTypeConverter(byval as XtAppContext, byval as const zstring ptr, byval as const zstring ptr, byval as XtTypeConverter, byval as XtConvertArgList, byval as Cardinal, byval as XtCacheType, byval as XtDestructor)
declare sub XtConvert(byval as Widget, byval as const zstring ptr, byval as XrmValue ptr, byval as const zstring ptr, byval as XrmValue ptr)
declare sub XtDirectConvert(byval as XtConverter, byval as XrmValuePtr, byval as Cardinal, byval as XrmValuePtr, byval as XrmValue ptr)
declare function XtParseTranslationTable(byval as const zstring ptr) as XtTranslations
declare function XtParseAcceleratorTable(byval as const zstring ptr) as XtAccelerators
declare sub XtOverrideTranslations(byval as Widget, byval as XtTranslations)
declare sub XtAugmentTranslations(byval as Widget, byval as XtTranslations)
declare sub XtInstallAccelerators(byval as Widget, byval as Widget)
declare sub XtInstallAllAccelerators(byval as Widget, byval as Widget)
declare sub XtUninstallTranslations(byval as Widget)
declare sub XtAppAddActions(byval as XtAppContext, byval as XtActionList, byval as Cardinal)
declare sub XtAddActions(byval as XtActionList, byval as Cardinal)
declare function XtAppAddActionHook(byval as XtAppContext, byval as XtActionHookProc, byval as XtPointer) as XtActionHookId
declare sub XtRemoveActionHook(byval as XtActionHookId)
declare sub XtGetActionList(byval as WidgetClass, byval as XtActionList ptr, byval as Cardinal ptr)
declare sub XtCallActionProc(byval as Widget, byval as const zstring ptr, byval as XEvent ptr, byval as String_ ptr, byval as Cardinal)
declare sub XtRegisterGrabAction(byval as XtActionProc, byval as XBoolean, byval as ulong, byval as long, byval as long)
declare sub XtSetMultiClickTime(byval as Display ptr, byval as long)
declare function XtGetMultiClickTime(byval as Display ptr) as long
declare function XtGetActionKeysym(byval as XEvent ptr, byval as Modifiers ptr) as KeySym
declare sub XtTranslateKeycode(byval as Display ptr, byval as KeyCode, byval as Modifiers, byval as Modifiers ptr, byval as KeySym ptr)
declare sub XtTranslateKey(byval as Display ptr, byval as KeyCode, byval as Modifiers, byval as Modifiers ptr, byval as KeySym ptr)
declare sub XtSetKeyTranslator(byval as Display ptr, byval as XtKeyProc)
declare sub XtRegisterCaseConverter(byval as Display ptr, byval as XtCaseProc, byval as KeySym, byval as KeySym)
declare sub XtConvertCase(byval as Display ptr, byval as KeySym, byval as KeySym ptr, byval as KeySym ptr)
const XtAllEvents = cast(EventMask, -cast(clong, 1))
declare sub XtAddEventHandler(byval as Widget, byval as EventMask, byval as XBoolean, byval as XtEventHandler, byval as XtPointer)
declare sub XtRemoveEventHandler(byval as Widget, byval as EventMask, byval as XBoolean, byval as XtEventHandler, byval as XtPointer)
declare sub XtAddRawEventHandler(byval as Widget, byval as EventMask, byval as XBoolean, byval as XtEventHandler, byval as XtPointer)
declare sub XtRemoveRawEventHandler(byval as Widget, byval as EventMask, byval as XBoolean, byval as XtEventHandler, byval as XtPointer)
declare sub XtInsertEventHandler(byval as Widget, byval as EventMask, byval as XBoolean, byval as XtEventHandler, byval as XtPointer, byval as XtListPosition)
declare sub XtInsertRawEventHandler(byval as Widget, byval as EventMask, byval as XBoolean, byval as XtEventHandler, byval as XtPointer, byval as XtListPosition)
declare function XtSetEventDispatcher(byval as Display ptr, byval as long, byval as XtEventDispatchProc) as XtEventDispatchProc
declare function XtDispatchEventToWidget(byval as Widget, byval as XEvent ptr) as XBoolean
declare sub XtInsertEventTypeHandler(byval as Widget, byval as long, byval as XtPointer, byval as XtEventHandler, byval as XtPointer, byval as XtListPosition)
declare sub XtRemoveEventTypeHandler(byval as Widget, byval as long, byval as XtPointer, byval as XtEventHandler, byval as XtPointer)
declare function XtBuildEventMask(byval as Widget) as EventMask
declare sub XtRegisterExtensionSelector(byval as Display ptr, byval as long, byval as long, byval as XtExtensionSelectProc, byval as XtPointer)
declare sub XtAddGrab(byval as Widget, byval as XBoolean, byval as XBoolean)
declare sub XtRemoveGrab(byval as Widget)
declare sub XtProcessEvent(byval as XtInputMask)
declare sub XtAppProcessEvent(byval as XtAppContext, byval as XtInputMask)
declare sub XtMainLoop()
declare sub XtAppMainLoop(byval as XtAppContext)
declare sub XtAddExposureToRegion(byval as XEvent ptr, byval as Region)
declare sub XtSetKeyboardFocus(byval as Widget, byval as Widget)
declare function XtGetKeyboardFocusWidget(byval as Widget) as Widget
declare function XtLastEventProcessed(byval as Display ptr) as XEvent ptr
declare function XtLastTimestampProcessed(byval as Display ptr) as Time
declare function XtAddTimeOut(byval as culong, byval as XtTimerCallbackProc, byval as XtPointer) as XtIntervalId
declare function XtAppAddTimeOut(byval as XtAppContext, byval as culong, byval as XtTimerCallbackProc, byval as XtPointer) as XtIntervalId
declare sub XtRemoveTimeOut(byval as XtIntervalId)
declare function XtAddInput(byval as long, byval as XtPointer, byval as XtInputCallbackProc, byval as XtPointer) as XtInputId
declare function XtAppAddInput(byval as XtAppContext, byval as long, byval as XtPointer, byval as XtInputCallbackProc, byval as XtPointer) as XtInputId
declare sub XtRemoveInput(byval as XtInputId)
declare function XtAddSignal(byval as XtSignalCallbackProc, byval as XtPointer) as XtSignalId
declare function XtAppAddSignal(byval as XtAppContext, byval as XtSignalCallbackProc, byval as XtPointer) as XtSignalId
declare sub XtRemoveSignal(byval as XtSignalId)
declare sub XtNoticeSignal(byval as XtSignalId)
declare sub XtNextEvent(byval as XEvent ptr)
declare sub XtAppNextEvent(byval as XtAppContext, byval as XEvent ptr)

const XtIMXEvent = 1
const XtIMTimer = 2
const XtIMAlternateInput = 4
const XtIMSignal = 8
const XtIMAll = ((XtIMXEvent or XtIMTimer) or XtIMAlternateInput) or XtIMSignal

declare function XtPending() as XBoolean
declare function XtAppPending(byval as XtAppContext) as XtInputMask
declare function XtAppAddBlockHook(byval as XtAppContext, byval as XtBlockHookProc, byval as XtPointer) as XtBlockHookId
declare sub XtRemoveBlockHook(byval as XtBlockHookId)

#define XtIsRectObj(object) _XtCheckSubclassFlag(object, cast(XtEnum, &h02))
#define XtIsWidget(object) _XtCheckSubclassFlag(object, cast(XtEnum, &h04))
#define XtIsComposite(widget) _XtCheckSubclassFlag(widget, cast(XtEnum, &h08))
#define XtIsConstraint(widget) _XtCheckSubclassFlag(widget, cast(XtEnum, &h10))
#define XtIsShell(widget) _XtCheckSubclassFlag(widget, cast(XtEnum, &h20))
#undef XtIsOverrideShell
declare function XtIsOverrideShell_ alias "XtIsOverrideShell"(byval as Widget) as XBoolean
#define XtIsOverrideShell(widget) _XtIsSubclassOf(widget, cast(WidgetClass, overrideShellWidgetClass), cast(WidgetClass, shellWidgetClass), cast(XtEnum, &h20))
#define XtIsWMShell(widget) _XtCheckSubclassFlag(widget, cast(XtEnum, &h40))
#undef XtIsVendorShell
declare function XtIsVendorShell_ alias "XtIsVendorShell"(byval as Widget) as XBoolean
#define XtIsVendorShell(widget) _XtIsSubclassOf(widget, cast(WidgetClass, vendorShellWidgetClass), cast(WidgetClass, wmShellWidgetClass), cast(XtEnum, &h40))
#undef XtIsTransientShell
declare function XtIsTransientShell_ alias "XtIsTransientShell"(byval as Widget) as XBoolean
#define XtIsTransientShell(widget) _XtIsSubclassOf(widget, cast(WidgetClass, transientShellWidgetClass), cast(WidgetClass, wmShellWidgetClass), cast(XtEnum, &h40))
#define XtIsTopLevelShell(widget) _XtCheckSubclassFlag(widget, cast(XtEnum, &h80))
#undef XtIsApplicationShell
declare function XtIsApplicationShell_ alias "XtIsApplicationShell"(byval as Widget) as XBoolean
#define XtIsApplicationShell(widget) _XtIsSubclassOf(widget, cast(WidgetClass, applicationShellWidgetClass), cast(WidgetClass, topLevelShellWidgetClass), cast(XtEnum, &h80))
#undef XtIsSessionShell
declare function XtIsSessionShell_ alias "XtIsSessionShell"(byval as Widget) as XBoolean
#define XtIsSessionShell(widget) _XtIsSubclassOf(widget, cast(WidgetClass, sessionShellWidgetClass), cast(WidgetClass, topLevelShellWidgetClass), cast(XtEnum, &h80))

declare sub XtRealizeWidget(byval as Widget)
declare sub XtUnrealizeWidget(byval as Widget)
declare sub XtDestroyWidget(byval as Widget)
declare sub XtSetSensitive(byval as Widget, byval as XBoolean)
declare sub XtSetMappedWhenManaged(byval as Widget, byval as XBoolean)
declare function XtNameToWidget(byval as Widget, byval as const zstring ptr) as Widget
declare function XtWindowToWidget(byval as Display ptr, byval as Window) as Widget
declare function XtGetClassExtension(byval as WidgetClass, byval as Cardinal, byval as XrmQuark, byval as clong, byval as Cardinal) as XtPointer
#macro XtSetArg(arg, n, d)
	scope
		(arg).name = (n)
		(arg).value = cast(XtArgVal, (d))
	end scope
#endmacro
declare function XtMergeArgLists(byval as ArgList, byval as Cardinal, byval as ArgList, byval as Cardinal) as ArgList
#define XtVaNestedList "XtVaNestedList"
#define XtVaTypedArg "XtVaTypedArg"
declare function XtVaCreateArgsList(byval as XtPointer, ...) as XtVarArgsList
declare function XtDisplay(byval as Widget) as Display ptr
declare function XtDisplayOfObject(byval as Widget) as Display ptr
declare function XtScreen(byval as Widget) as Screen ptr
declare function XtScreenOfObject(byval as Widget) as Screen ptr
declare function XtWindow(byval as Widget) as Window
declare function XtWindowOfObject(byval as Widget) as Window
declare function XtName(byval as Widget) as String_
declare function XtSuperclass(byval as Widget) as WidgetClass
declare function XtClass(byval as Widget) as WidgetClass
declare function XtParent(byval as Widget) as Widget
#undef XtMapWidget
declare sub XtMapWidget_ alias "XtMapWidget"(byval as Widget)
#define XtMapWidget(widget) XMapWindow(XtDisplay(widget), XtWindow(widget))
#undef XtUnmapWidget
declare sub XtUnmapWidget_ alias "XtUnmapWidget"(byval as Widget)
#define XtUnmapWidget(widget) XUnmapWindow(XtDisplay(widget), XtWindow(widget))
declare sub XtAddCallback(byval as Widget, byval as const zstring ptr, byval as XtCallbackProc, byval as XtPointer)
declare sub XtRemoveCallback(byval as Widget, byval as const zstring ptr, byval as XtCallbackProc, byval as XtPointer)
declare sub XtAddCallbacks(byval as Widget, byval as const zstring ptr, byval as XtCallbackList)
declare sub XtRemoveCallbacks(byval as Widget, byval as const zstring ptr, byval as XtCallbackList)
declare sub XtRemoveAllCallbacks(byval as Widget, byval as const zstring ptr)
declare sub XtCallCallbacks(byval as Widget, byval as const zstring ptr, byval as XtPointer)
declare sub XtCallCallbackList(byval as Widget, byval as XtCallbackList, byval as XtPointer)
declare function XtHasCallbacks(byval as Widget, byval as const zstring ptr) as XtCallbackStatus
declare function XtMakeGeometryRequest(byval as Widget, byval as XtWidgetGeometry ptr, byval as XtWidgetGeometry ptr) as XtGeometryResult
declare function XtQueryGeometry(byval as Widget, byval as XtWidgetGeometry ptr, byval as XtWidgetGeometry ptr) as XtGeometryResult
declare function XtCreatePopupShell(byval as const zstring ptr, byval as WidgetClass, byval as Widget, byval as ArgList, byval as Cardinal) as Widget
declare function XtVaCreatePopupShell(byval as const zstring ptr, byval as WidgetClass, byval as Widget, ...) as Widget
declare sub XtPopup(byval as Widget, byval as XtGrabKind)
declare sub XtPopupSpringLoaded(byval as Widget)
declare sub XtCallbackNone(byval as Widget, byval as XtPointer, byval as XtPointer)
declare sub XtCallbackNonexclusive(byval as Widget, byval as XtPointer, byval as XtPointer)
declare sub XtCallbackExclusive(byval as Widget, byval as XtPointer, byval as XtPointer)
declare sub XtPopdown(byval as Widget)
declare sub XtCallbackPopdown(byval as Widget, byval as XtPointer, byval as XtPointer)
declare sub XtMenuPopupAction(byval as Widget, byval as XEvent ptr, byval as String_ ptr, byval as Cardinal ptr)
declare function XtCreateWidget(byval as const zstring ptr, byval as WidgetClass, byval as Widget, byval as ArgList, byval as Cardinal) as Widget
declare function XtCreateManagedWidget(byval as const zstring ptr, byval as WidgetClass, byval as Widget, byval as ArgList, byval as Cardinal) as Widget
declare function XtVaCreateWidget(byval as const zstring ptr, byval as WidgetClass, byval as Widget, ...) as Widget
declare function XtVaCreateManagedWidget(byval as const zstring ptr, byval as WidgetClass, byval as Widget, ...) as Widget
declare function XtCreateApplicationShell(byval as const zstring ptr, byval as WidgetClass, byval as ArgList, byval as Cardinal) as Widget
declare function XtAppCreateShell(byval as const zstring ptr, byval as const zstring ptr, byval as WidgetClass, byval as Display ptr, byval as ArgList, byval as Cardinal) as Widget
declare function XtVaAppCreateShell(byval as const zstring ptr, byval as const zstring ptr, byval as WidgetClass, byval as Display ptr, ...) as Widget
declare sub XtToolkitInitialize()
declare function XtSetLanguageProc(byval as XtAppContext, byval as XtLanguageProc, byval as XtPointer) as XtLanguageProc
declare sub XtDisplayInitialize(byval as XtAppContext, byval as Display ptr, byval as const zstring ptr, byval as const zstring ptr, byval as XrmOptionDescRec ptr, byval as Cardinal, byval as long ptr, byval as zstring ptr ptr)
declare function XtOpenApplication(byval as XtAppContext ptr, byval as const zstring ptr, byval as XrmOptionDescList, byval as Cardinal, byval as long ptr, byval as String_ ptr, byval as String_ ptr, byval as WidgetClass, byval as ArgList, byval as Cardinal) as Widget
declare function XtVaOpenApplication(byval as XtAppContext ptr, byval as const zstring ptr, byval as XrmOptionDescList, byval as Cardinal, byval as long ptr, byval as String_ ptr, byval as String_ ptr, byval as WidgetClass, ...) as Widget
declare function XtAppInitialize(byval as XtAppContext ptr, byval as const zstring ptr, byval as XrmOptionDescList, byval as Cardinal, byval as long ptr, byval as String_ ptr, byval as String_ ptr, byval as ArgList, byval as Cardinal) as Widget
declare function XtVaAppInitialize(byval as XtAppContext ptr, byval as const zstring ptr, byval as XrmOptionDescList, byval as Cardinal, byval as long ptr, byval as String_ ptr, byval as String_ ptr, ...) as Widget
declare function XtInitialize(byval as const zstring ptr, byval as const zstring ptr, byval as XrmOptionDescRec ptr, byval as Cardinal, byval as long ptr, byval as zstring ptr ptr) as Widget
declare function XtOpenDisplay(byval as XtAppContext, byval as const zstring ptr, byval as const zstring ptr, byval as const zstring ptr, byval as XrmOptionDescRec ptr, byval as Cardinal, byval as long ptr, byval as zstring ptr ptr) as Display ptr
declare function XtCreateApplicationContext() as XtAppContext
declare sub XtAppSetFallbackResources(byval as XtAppContext, byval as String_ ptr)
declare sub XtDestroyApplicationContext(byval as XtAppContext)
declare sub XtInitializeWidgetClass(byval as WidgetClass)
declare function XtWidgetToApplicationContext(byval as Widget) as XtAppContext
declare function XtDisplayToApplicationContext(byval as Display ptr) as XtAppContext
declare function XtDatabase(byval as Display ptr) as XrmDatabase
declare function XtScreenDatabase(byval as Screen ptr) as XrmDatabase
declare sub XtCloseDisplay(byval as Display ptr)
declare sub XtGetApplicationResources(byval as Widget, byval as XtPointer, byval as XtResourceList, byval as Cardinal, byval as ArgList, byval as Cardinal)
declare sub XtVaGetApplicationResources(byval as Widget, byval as XtPointer, byval as XtResourceList, byval as Cardinal, ...)
declare sub XtGetSubresources(byval as Widget, byval as XtPointer, byval as const zstring ptr, byval as const zstring ptr, byval as XtResourceList, byval as Cardinal, byval as ArgList, byval as Cardinal)
declare sub XtVaGetSubresources(byval as Widget, byval as XtPointer, byval as const zstring ptr, byval as const zstring ptr, byval as XtResourceList, byval as Cardinal, ...)
declare sub XtSetValues(byval as Widget, byval as ArgList, byval as Cardinal)
declare sub XtVaSetValues(byval as Widget, ...)
declare sub XtGetValues(byval as Widget, byval as ArgList, byval as Cardinal)
declare sub XtVaGetValues(byval as Widget, ...)
declare sub XtSetSubvalues(byval as XtPointer, byval as XtResourceList, byval as Cardinal, byval as ArgList, byval as Cardinal)
declare sub XtVaSetSubvalues(byval as XtPointer, byval as XtResourceList, byval as Cardinal, ...)
declare sub XtGetSubvalues(byval as XtPointer, byval as XtResourceList, byval as Cardinal, byval as ArgList, byval as Cardinal)
declare sub XtVaGetSubvalues(byval as XtPointer, byval as XtResourceList, byval as Cardinal, ...)
declare sub XtGetResourceList(byval as WidgetClass, byval as XtResourceList ptr, byval as Cardinal ptr)
declare sub XtGetConstraintResourceList(byval as WidgetClass, byval as XtResourceList ptr, byval as Cardinal ptr)

const XtUnspecifiedPixmap = cast(Pixmap, 2)
const XtUnspecifiedShellInt = -1
const XtUnspecifiedWindow = cast(Window, 2)
const XtUnspecifiedWindowGroup = cast(Window, 3)
#define XtCurrentDirectory "XtCurrentDirectory"
#define XtDefaultForeground "XtDefaultForeground"
#define XtDefaultBackground "XtDefaultBackground"
#define XtDefaultFont "XtDefaultFont"
#define XtDefaultFontSet "XtDefaultFontSet"
#define XtOffset(p_type, field) cast(Cardinal, cptr(byte ptr, @cast(p_type, NULL)->field) - cptr(byte ptr, NULL))
#define XtOffsetOf(s_type, field) XtOffset(s_type ptr, field)

type _XtCheckpointTokenRec
	save_type as long
	interact_style as long
	shutdown as XBoolean
	fast as XBoolean
	cancel_shutdown as XBoolean
	phase as long
	interact_dialog_type as long
	request_cancel as XBoolean
	request_next_phase as XBoolean
	save_success as XBoolean
	as long type
	widget as Widget
end type

type XtCheckpointTokenRec as _XtCheckpointTokenRec
type XtCheckpointToken as _XtCheckpointTokenRec ptr
declare function XtSessionGetToken(byval as Widget) as XtCheckpointToken
declare sub XtSessionReturnToken(byval as XtCheckpointToken)
declare function XtAppSetErrorMsgHandler(byval as XtAppContext, byval as XtErrorMsgHandler) as XtErrorMsgHandler
declare sub XtSetErrorMsgHandler(byval as XtErrorMsgHandler)
declare function XtAppSetWarningMsgHandler(byval as XtAppContext, byval as XtErrorMsgHandler) as XtErrorMsgHandler
declare sub XtSetWarningMsgHandler(byval as XtErrorMsgHandler)
declare sub XtAppErrorMsg(byval as XtAppContext, byval as const zstring ptr, byval as const zstring ptr, byval as const zstring ptr, byval as const zstring ptr, byval as String_ ptr, byval as Cardinal ptr)
declare sub XtErrorMsg(byval as const zstring ptr, byval as const zstring ptr, byval as const zstring ptr, byval as const zstring ptr, byval as String_ ptr, byval as Cardinal ptr)
declare sub XtAppWarningMsg(byval as XtAppContext, byval as const zstring ptr, byval as const zstring ptr, byval as const zstring ptr, byval as const zstring ptr, byval as String_ ptr, byval as Cardinal ptr)
declare sub XtWarningMsg(byval as const zstring ptr, byval as const zstring ptr, byval as const zstring ptr, byval as const zstring ptr, byval as String_ ptr, byval as Cardinal ptr)
declare function XtAppSetErrorHandler(byval as XtAppContext, byval as XtErrorHandler) as XtErrorHandler
declare sub XtSetErrorHandler(byval as XtErrorHandler)
declare function XtAppSetWarningHandler(byval as XtAppContext, byval as XtErrorHandler) as XtErrorHandler
declare sub XtSetWarningHandler(byval as XtErrorHandler)
declare sub XtAppError(byval as XtAppContext, byval as const zstring ptr)
declare sub XtError(byval as const zstring ptr)
declare sub XtAppWarning(byval as XtAppContext, byval as const zstring ptr)
declare sub XtWarning(byval as const zstring ptr)
declare function XtAppGetErrorDatabase(byval as XtAppContext) as XrmDatabase ptr
declare function XtGetErrorDatabase() as XrmDatabase ptr
declare sub XtAppGetErrorDatabaseText(byval as XtAppContext, byval as const zstring ptr, byval as const zstring ptr, byval as const zstring ptr, byval as const zstring ptr, byval as String_, byval as long, byval as XrmDatabase)
declare sub XtGetErrorDatabaseText(byval as const zstring ptr, byval as const zstring ptr, byval as const zstring ptr, byval as const zstring ptr, byval as String_, byval as long)
declare function XtMalloc(byval as Cardinal) as zstring ptr
declare function XtCalloc(byval as Cardinal, byval as Cardinal) as zstring ptr
declare function XtRealloc(byval as zstring ptr, byval as Cardinal) as zstring ptr
declare sub XtFree(byval as zstring ptr)
declare function XtAsprintf(byval new_string as String_ ptr, byval format as const zstring ptr, ...) as Cardinal
#define XtNew(type) cptr(type ptr, XtMalloc(culng(sizeof(type))))
#undef XtNewString
declare function XtNewString_ alias "XtNewString"(byval as String_) as String_
#define XtNewString(str) iif((str) <> NULL, strcpy(XtMalloc(culng(culng(strlen(str)) + 1)), str), NULL)
declare function XtAddWorkProc(byval as XtWorkProc, byval as XtPointer) as XtWorkProcId
declare function XtAppAddWorkProc(byval as XtAppContext, byval as XtWorkProc, byval as XtPointer) as XtWorkProcId
declare sub XtRemoveWorkProc(byval as XtWorkProcId)
declare function XtGetGC(byval as Widget, byval as XtGCMask, byval as XGCValues ptr) as GC
declare function XtAllocateGC(byval as Widget, byval as Cardinal, byval as XtGCMask, byval as XGCValues ptr, byval as XtGCMask, byval as XtGCMask) as GC
declare sub XtDestroyGC(byval as GC)
declare sub XtReleaseGC(byval as Widget, byval as GC)
declare sub XtAppReleaseCacheRefs(byval as XtAppContext, byval as XtCacheRef ptr)
declare sub XtCallbackReleaseCacheRef(byval as Widget, byval as XtPointer, byval as XtPointer)
declare sub XtCallbackReleaseCacheRefList(byval as Widget, byval as XtPointer, byval as XtPointer)
declare sub XtSetWMColormapWindows(byval as Widget, byval as Widget ptr, byval as Cardinal)
declare function XtFindFile(byval as const zstring ptr, byval as Substitution, byval as Cardinal, byval as XtFilePredicate) as String_
declare function XtResolvePathname(byval as Display ptr, byval as const zstring ptr, byval as const zstring ptr, byval as const zstring ptr, byval as const zstring ptr, byval as Substitution, byval as Cardinal, byval as XtFilePredicate) as String_
const XT_CONVERT_FAIL = cast(XAtom, &h80000001)
declare sub XtDisownSelection(byval as Widget, byval as XAtom, byval as Time)
declare sub XtGetSelectionValue(byval as Widget, byval as XAtom, byval as XAtom, byval as XtSelectionCallbackProc, byval as XtPointer, byval as Time)
declare sub XtGetSelectionValues(byval as Widget, byval as XAtom, byval as XAtom ptr, byval as long, byval as XtSelectionCallbackProc, byval as XtPointer ptr, byval as Time)
declare sub XtAppSetSelectionTimeout(byval as XtAppContext, byval as culong)
declare sub XtSetSelectionTimeout(byval as culong)
declare function XtAppGetSelectionTimeout(byval as XtAppContext) as culong
declare function XtGetSelectionTimeout() as culong
declare function XtGetSelectionRequest(byval as Widget, byval as XAtom, byval as XtRequestId) as XSelectionRequestEvent ptr
declare sub XtGetSelectionValueIncremental(byval as Widget, byval as XAtom, byval as XAtom, byval as XtSelectionCallbackProc, byval as XtPointer, byval as Time)
declare sub XtGetSelectionValuesIncremental(byval as Widget, byval as XAtom, byval as XAtom ptr, byval as long, byval as XtSelectionCallbackProc, byval as XtPointer ptr, byval as Time)
declare sub XtSetSelectionParameters(byval as Widget, byval as XAtom, byval as XAtom, byval as XtPointer, byval as culong, byval as long)
declare sub XtGetSelectionParameters(byval as Widget, byval as XAtom, byval as XtRequestId, byval as XAtom ptr, byval as XtPointer ptr, byval as culong ptr, byval as long ptr)
declare sub XtCreateSelectionRequest(byval as Widget, byval as XAtom)
declare sub XtSendSelectionRequest(byval as Widget, byval as XAtom, byval as Time)
declare sub XtCancelSelectionRequest(byval as Widget, byval as XAtom)
declare function XtReservePropertyAtom(byval as Widget) as XAtom
declare sub XtReleasePropertyAtom(byval as Widget, byval as XAtom)
declare sub XtGrabKey(byval as Widget, byval as KeyCode, byval as Modifiers, byval as XBoolean, byval as long, byval as long)
declare sub XtUngrabKey(byval as Widget, byval as KeyCode, byval as Modifiers)
declare function XtGrabKeyboard(byval as Widget, byval as XBoolean, byval as long, byval as long, byval as Time) as long
declare sub XtUngrabKeyboard(byval as Widget, byval as Time)
declare sub XtGrabButton(byval as Widget, byval as long, byval as Modifiers, byval as XBoolean, byval as ulong, byval as long, byval as long, byval as Window, byval as Cursor)
declare sub XtUngrabButton(byval as Widget, byval as ulong, byval as Modifiers)
declare function XtGrabPointer(byval as Widget, byval as XBoolean, byval as ulong, byval as long, byval as long, byval as Window, byval as Cursor, byval as Time) as long
declare sub XtUngrabPointer(byval as Widget, byval as Time)
declare sub XtGetApplicationNameAndClass(byval as Display ptr, byval as String_ ptr, byval as String_ ptr)
declare sub XtRegisterDrawable(byval as Display ptr, byval as Drawable, byval as Widget)
declare sub XtUnregisterDrawable(byval as Display ptr, byval as Drawable)
declare function XtHooksOfDisplay(byval as Display ptr) as Widget

type XtCreateHookDataRec
	as String_ type
	widget as Widget
	args as ArgList
	num_args as Cardinal
end type

type XtCreateHookData as XtCreateHookDataRec ptr

type XtChangeHookDataRec
	as String_ type
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
	as String_ type
	widget as Widget
	changeMask as XtGeometryMask
	changes as XWindowChanges
end type

type XtConfigureHookData as XtConfigureHookDataRec ptr

type XtGeometryHookDataRec
	as String_ type
	widget as Widget
	request as XtWidgetGeometry ptr
	reply as XtWidgetGeometry ptr
	result as XtGeometryResult
end type

type XtGeometryHookData as XtGeometryHookDataRec ptr

type XtDestroyHookDataRec
	as String_ type
	widget as Widget
end type

type XtDestroyHookData as XtDestroyHookDataRec ptr
declare sub XtGetDisplays(byval as XtAppContext, byval as Display ptr ptr ptr, byval as Cardinal ptr)
declare function XtToolkitThreadInitialize() as XBoolean
declare sub XtAppSetExitFlag(byval as XtAppContext)
declare function XtAppGetExitFlag(byval as XtAppContext) as XBoolean
declare sub XtAppLock(byval as XtAppContext)
declare sub XtAppUnlock(byval as XtAppContext)
declare function XtCvtStringToAcceleratorTable(byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as XBoolean
declare function XtCvtStringToAtom(byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as XBoolean
declare function XtCvtStringToBool(byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as XBoolean
declare function XtCvtStringToBoolean(byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as XBoolean
declare function XtCvtStringToCommandArgArray(byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as XBoolean
declare function XtCvtStringToCursor(byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as XBoolean
declare function XtCvtStringToDimension(byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as XBoolean
declare function XtCvtStringToDirectoryString(byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as XBoolean
declare function XtCvtStringToDisplay(byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as XBoolean
declare function XtCvtStringToFile(byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as XBoolean
declare function XtCvtStringToFloat(byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as XBoolean
declare function XtCvtStringToFont(byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as XBoolean
declare function XtCvtStringToFontSet(byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as XBoolean
declare function XtCvtStringToFontStruct(byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as XBoolean
declare function XtCvtStringToGravity(byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as XBoolean
declare function XtCvtStringToInitialState(byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as XBoolean
declare function XtCvtStringToInt(byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as XBoolean
declare function XtCvtStringToPixel(byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as XBoolean
declare function XtCvtStringToRestartStyle(byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as XBoolean
declare function XtCvtStringToShort(byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as XBoolean
declare function XtCvtStringToPosition alias "XtCvtStringToShort"(byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as XBoolean
declare function XtCvtStringToTranslationTable(byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as XBoolean
declare function XtCvtStringToUnsignedChar(byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as XBoolean
declare function XtCvtStringToVisual(byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as XBoolean
declare function XtCvtIntToBool(byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as XBoolean
declare function XtCvtIntToBoolean(byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as XBoolean
declare function XtCvtIntToColor(byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as XBoolean
declare function XtCvtIntToFloat(byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as XBoolean
declare function XtCvtIntToFont(byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as XBoolean
declare function XtCvtIntToPixel(byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as XBoolean
declare function XtCvtIntToPixmap(byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as XBoolean
declare function XtCvtIntToShort(byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as XBoolean
declare function XtCvtIntToDimension alias "XtCvtIntToShort"(byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as XBoolean
declare function XtCvtIntToPosition alias "XtCvtIntToShort"(byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as XBoolean
declare function XtCvtIntToUnsignedChar(byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as XBoolean
declare function XtCvtColorToPixel(byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as XBoolean
declare function XtCvtPixelToColor alias "XtCvtIntToColor"(byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as XBoolean

end extern

#include once "X11/Composite.bi"
#include once "X11/Core.bi"
#include once "X11/Constraint.bi"
#include once "X11/Object.bi"
#include once "X11/RectObj.bi"
