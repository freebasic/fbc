''
''
'' SelectionI -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __SelectionI_bi__
#define __SelectionI_bi__

type Request as _RequestRec ptr
type Select as _SelectRec ptr

type _RequestRec
	ctx as Select
	widget as Widget
	requestor as Window
	property as Atom
	target as Atom
	type as Atom
	format as integer
	value as XtPointer
	bytelength as uinteger
	offset as uinteger
	timeout as XtIntervalId
	event as XSelectionRequestEvent
	allSent as Boolean
end type

type RequestRec as _RequestRec

type SelectionPropRec
	prop as Atom
	avail as Boolean
end type

type SelectionProp as SelectionPropRec ptr

type PropListRec
	dpy as Display ptr
	incr_atom as Atom
	indirect_atom as Atom
	timestamp_atom as Atom
	propCount as integer
	list as SelectionProp
end type

type PropList as PropListRec ptr

type _SelectRec
	selection as Atom
	dpy as Display ptr
	widget as Widget
	time as Time
	serial as uinteger
	convert as XtConvertSelectionProc
	loses as XtLoseSelectionProc
	notify as XtSelectionDoneProc
	owner_cancel as XtCancelConvertSelectionProc
	owner_closure as XtPointer
	prop_list as PropList
	req as Request
	ref_count as integer
	incremental:1 as uinteger
	free_when_done:1 as uinteger
	was_disowned:1 as uinteger
end type

type SelectRec as _SelectRec

type _ParamRec
	selection as Atom
	param as Atom
end type

type ParamRec as _ParamRec
type Param as _ParamRec ptr

type _ParamInfoRec
	count as uinteger
	paramlist as Param
end type

type ParamInfoRec as _ParamInfoRec
type ParamInfo as _ParamInfoRec ptr

type _QueuedRequestRec
	selection as Atom
	target as Atom
	param as Atom
	callback as XtSelectionCallbackProc
	closure as XtPointer
	time as Time
	incremental as Boolean
end type

type QueuedRequestRec as _QueuedRequestRec
type QueuedRequest as _QueuedRequestRec ptr

type _QueuedRequestInfoRec
	count as integer
	selections as Atom ptr
	requests as QueuedRequest ptr
end type

type QueuedRequestInfoRec as _QueuedRequestInfoRec
type QueuedRequestInfo as _QueuedRequestInfoRec ptr

type CallBackInfoRec
	callbacks as XtSelectionCallbackProc ptr
	req_closure as XtPointer ptr
	property as Atom
	target as Atom ptr
	type as Atom
	format as integer
	value as zstring ptr
	bytelength as integer
	offset as integer
	timeout as XtIntervalId
	proc as XtEventHandler
	widget as Widget
	time as Time
	ctx as Select
	incremental as Boolean ptr
	current as integer
end type

type CallBackInfo as CallBackInfoRec ptr

type IndirectPair
	target as Atom
	property as Atom
end type

#define IndirectPairWordSize 2

type RequestWindowRec
	active_transfer_count as integer
end type

#endif
