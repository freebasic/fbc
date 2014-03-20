''
''
'' IntrinsicP -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __IntrinsicP_bi__
#define __IntrinsicP_bi__

type XrmResource
	xrm_name as integer
	xrm_class as integer
	xrm_type as integer
	xrm_size as Cardinal
	xrm_offset as integer
	xrm_default_type as integer
	xrm_default_addr as XtPointer
end type

type XrmResourceList as XrmResource ptr
type XtVersionType as uinteger

#define XT_VERSION 11
#define XT_REVISION 6
#define XtVersion (11*1000+6)
#define XtVersionDontCheck 0

type XtProc as sub cdecl()
type XtWidgetClassProc as sub cdecl(byval as WidgetClass)
type XtWidgetProc as sub cdecl(byval as Widget)
type XtAcceptFocusProc as function cdecl(byval as Widget, byval as Time ptr) as Boolean
type XtArgsProc as sub cdecl(byval as Widget, byval as ArgList, byval as Cardinal ptr)
type XtInitProc as sub cdecl(byval as Widget, byval as Widget, byval as ArgList, byval as Cardinal ptr)
type XtSetValuesFunc as function cdecl(byval as Widget, byval as Widget, byval as Widget, byval as ArgList, byval as Cardinal ptr) as Boolean
type XtArgsFunc as function cdecl(byval as Widget, byval as ArgList, byval as Cardinal ptr) as Boolean
type XtAlmostProc as sub cdecl(byval as Widget, byval as Widget, byval as XtWidgetGeometry ptr, byval as XtWidgetGeometry ptr)
type XtExposeProc as sub cdecl(byval as Widget, byval as XEvent ptr, byval as Region)

#define XtExposeCompressMultiple 2
#define XtExposeCompressMaximal 3
#define XtExposeGraphicsExpose &h10
#define XtExposeGraphicsExposeMerged &h20
#define XtExposeNoExpose &h40
#define XtExposeNoRegion &h80

type XtRealizeProc as sub cdecl(byval as Widget, byval as XtValueMask ptr, byval as XSetWindowAttributes ptr)
type XtGeometryHandler as function cdecl(byval as Widget, byval as XtWidgetGeometry ptr, byval as XtWidgetGeometry ptr) as XtGeometryResult
type XtStringProc as sub cdecl(byval as Widget, byval as zstring ptr)

type XtTypedArg
	name as String
	type as String
	value as XtArgVal
	size as integer
end type

type XtTypedArgList as XtTypedArg ptr
type XtAllocateProc as sub cdecl(byval as WidgetClass, byval as Cardinal ptr, byval as Cardinal ptr, byval as ArgList, byval as Cardinal ptr, byval as XtTypedArgList, byval as Cardinal ptr, byval as Widget ptr, byval as XtPointer ptr)
type XtDeallocateProc as sub cdecl(byval as Widget, byval as XtPointer)

type _XtTMRec
	translations as XtTranslations
	proc_table as XtBoundActions
	current_state as _XtStateRec ptr
	lastEventTime as uinteger
end type

type XtTMRec as _XtTMRec
type XtTM as _XtTMRec ptr

declare function XtIsRectObj cdecl alias "XtIsRectObj" (byval as Widget) as Boolean
declare function XtIsWidget cdecl alias "XtIsWidget" (byval as Widget) as Boolean
declare function XtIsComposite cdecl alias "XtIsComposite" (byval as Widget) as Boolean
declare function XtIsConstraint cdecl alias "XtIsConstraint" (byval as Widget) as Boolean
declare function XtIsShell cdecl alias "XtIsShell" (byval as Widget) as Boolean
declare function XtIsWMShell cdecl alias "XtIsWMShell" (byval as Widget) as Boolean
declare function XtIsTopLevelShell cdecl alias "XtIsTopLevelShell" (byval as Widget) as Boolean
declare sub _XtInherit cdecl alias "_XtInherit" ()
declare sub _XtHandleFocus cdecl alias "_XtHandleFocus" (byval as Widget, byval as XtPointer, byval as XEvent ptr, byval as Boolean ptr)
declare sub XtCreateWindow cdecl alias "XtCreateWindow" (byval as Widget, byval as uinteger, byval as Visual ptr, byval as XtValueMask, byval as XSetWindowAttributes ptr)
declare sub XtResizeWidget cdecl alias "XtResizeWidget" (byval as Widget, byval as _XtDimension, byval as _XtDimension, byval as _XtDimension)
declare sub XtMoveWidget cdecl alias "XtMoveWidget" (byval as Widget, byval as _XtPosition, byval as _XtPosition)
declare sub XtConfigureWidget cdecl alias "XtConfigureWidget" (byval as Widget, byval as _XtPosition, byval as _XtPosition, byval as _XtDimension, byval as _XtDimension, byval as _XtDimension)
declare sub XtResizeWindow cdecl alias "XtResizeWindow" (byval as Widget)
declare sub XtProcessLock cdecl alias "XtProcessLock" ()
declare sub XtProcessUnlock cdecl alias "XtProcessUnlock" ()

#endif
