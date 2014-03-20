''
''
'' InitialI -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __InitialI_bi__
#define __InitialI_bi__

#define PATH_MAX 1024

type _InputEvent
	ie_proc as XtInputCallbackProc
	ie_closure as XtPointer
	ie_next as _InputEvent ptr
	ie_oq as _InputEvent ptr
	app as XtAppContext
	ie_source as integer
	ie_condition as XtInputMask
end type

type InputEvent as _InputEvent

type _SignalEventRec
	se_proc as XtSignalCallbackProc
	se_closure as XtPointer
	se_next as _SignalEventRec ptr
	app as XtAppContext
	se_notice as Boolean
end type

type SignalEventRec as _SignalEventRec

type _WorkProcRec
	proc as XtWorkProc
	closure as XtPointer
	next as _WorkProcRec ptr
	app as XtAppContext
end type

type WorkProcRec as _WorkProcRec

type FdStruct
	rmask as fd_set
	wmask as fd_set
	emask as fd_set
	nfds as integer
end type

type _LangProcRec
	proc as XtLanguageProc
	closure as XtPointer
end type

type LangProcRec as _LangProcRec

type _ProcessContextRec
	defaultAppContext as XtAppContext
	appContextList as XtAppContext
	globalConverterTable as ConverterTable
	globalLangProcRec as LangProcRec
end type

type ProcessContextRec as _ProcessContextRec
type ProcessContext as _ProcessContextRec ptr

type Heap
	start as zstring ptr
	current as zstring ptr
	bytes_remaining as integer
end type

type DestroyRec as _DestroyRec

type _XtAppStruct
	next as XtAppContext
	process as ProcessContext
	destroy_callbacks as InternalCallbackList
	list as Display ptr ptr
	timerQueue as TimerEventRec ptr
	workQueue as WorkProcRec ptr
	input_list as InputEvent ptr ptr
	outstandingQueue as InputEvent ptr
	signalQueue as SignalEventRec ptr
	errorDB as XrmDatabase
	errorMsgHandler as XtErrorMsgHandler
	warningMsgHandler as XtErrorMsgHandler
	errorHandler as XtErrorHandler
	warningHandler as XtErrorHandler
	action_table as _ActionListRec ptr
	converterTable as ConverterTable
	selectionTimeout as uinteger
	fds as FdStruct
	count as short
	max as short
	last as short
	input_count as short
	input_max as short
	sync as Boolean
	being_destroyed as Boolean
	error_inited as Boolean
	identify_windows as Boolean
	heap as Heap
	fallback_resources as zstring ptr ptr
	action_hook_list as _ActionHookRec ptr
	block_hook_list as _BlockHookRec ptr
	destroy_list_size as integer
	destroy_count as integer
	dispatch_level as integer
	destroy_list as DestroyRec ptr
	in_phase2_destroy as Widget
	langProcRec as LangProcRec
	free_bindings as _TMBindCacheRec ptr
	display_name_tried as zstring ptr
	dpy_destroy_list as Display ptr ptr
	dpy_destroy_count as integer
	exit_flag as Boolean
	rebuild_fdlist as Boolean
end type

type XtAppStruct as _XtAppStruct

declare sub _XtHeapInit cdecl alias "_XtHeapInit" (byval heap as Heap ptr)
declare sub _XtHeapFree cdecl alias "_XtHeapFree" (byval heap as Heap ptr)
declare function _XtHeapAlloc cdecl alias "_XtHeapAlloc" (byval as Heap ptr, byval as Cardinal) as zstring ptr
declare sub _XtSetDefaultErrorHandlers cdecl alias "_XtSetDefaultErrorHandlers" (byval as XtErrorMsgHandler ptr, byval as XtErrorMsgHandler ptr, byval as XtErrorHandler ptr, byval as XtErrorHandler ptr)
declare sub _XtSetDefaultSelectionTimeout cdecl alias "_XtSetDefaultSelectionTimeout" (byval as uinteger ptr)
declare function _XtDefaultAppContext cdecl alias "_XtDefaultAppContext" () as XtAppContext
declare function _XtGetProcessContext cdecl alias "_XtGetProcessContext" () as ProcessContext
declare function _XtAppInit cdecl alias "_XtAppInit" (byval as XtAppContext ptr, byval as zstring ptr, byval as XrmOptionDescRec ptr, byval as Cardinal, byval as integer ptr, byval as zstring ptr ptr ptr, byval as zstring ptr ptr) as Display ptr
declare sub _XtDestroyAppContexts cdecl alias "_XtDestroyAppContexts" ()
declare sub _XtCloseDisplays cdecl alias "_XtCloseDisplays" (byval as XtAppContext)
extern _XtAppDestroyCount alias "_XtAppDestroyCount" as integer
declare function _XtWaitForSomething cdecl alias "_XtWaitForSomething" (byval as XtAppContext, byval as _XtBoolean, byval as _XtBoolean, byval as _XtBoolean, byval as _XtBoolean, byval as _XtBoolean, byval as uinteger ptr) as integer

type CaseConverterPtr as _CaseConverterRec ptr

type _CaseConverterRec
	start as KeySym
	stop as KeySym
	proc as XtCaseProc
	next as CaseConverterPtr
end type

type CaseConverterRec as _CaseConverterRec

type _ExtensionSelectorRec
	proc as XtExtensionSelectProc
	min as integer
	max as integer
	client_data as XtPointer
end type

type ExtSelectRec as _ExtensionSelectorRec

type _XtPerDisplayStruct
	destroy_callbacks as InternalCallbackList
	region as Region
	case_cvt as CaseConverterPtr
	defaultKeycodeTranslator as XtKeyProc
	appContext as XtAppContext
	keysyms_serial as uinteger
	keysyms as KeySym ptr
	keysyms_per_keycode as integer
	min_keycode as integer
	max_keycode as integer
	modKeysyms as KeySym ptr
	modsToKeysyms as ModToKeysymTable ptr
	isModifier(0 to 32-1) as ubyte
	lock_meaning as KeySym
	mode_switch as Modifiers
	num_lock as Modifiers
	being_destroyed as Boolean
	rv as Boolean
	name as XrmName
	class as XrmClass
	heap as Heap
	GClist as _GCrec ptr
	pixmap_tab as Drawable ptr ptr
	language as zstring ptr
	last_event as XEvent
	last_timestamp as Time
	multi_click_time as integer
	tm_context as _TMKeyContextRec ptr
	mapping_callbacks as InternalCallbackList
	pdi as XtPerDisplayInputRec
	WWtable as _WWTable ptr
	per_screen_db as XrmDatabase ptr
	cmd_db as XrmDatabase
	server_db as XrmDatabase
	dispatcher_list as XtEventDispatchProc ptr
	ext_select_list as ExtSelectRec ptr
	ext_select_count as integer
	hook_object as Widget
	rcm_init as Atom
	rcm_data as Atom
end type

type XtPerDisplayStruct as _XtPerDisplayStruct
type XtPerDisplay as _XtPerDisplayStruct ptr

type _PerDisplayTable
	dpy as Display ptr
	perDpy as XtPerDisplayStruct
	next as _PerDisplayTable ptr
end type

type PerDisplayTable as _PerDisplayTable
type PerDisplayTablePtr as _PerDisplayTable ptr
extern _XtperDisplayList alias "_XtperDisplayList" as PerDisplayTablePtr

declare function _XtSortPerDisplayList cdecl alias "_XtSortPerDisplayList" (byval as Display ptr) as XtPerDisplay
declare function _XtGetPerDisplay cdecl alias "_XtGetPerDisplay" (byval as Display ptr) as XtPerDisplay
declare function _XtGetPerDisplayInput cdecl alias "_XtGetPerDisplayInput" (byval as Display ptr) as XtPerDisplayInputRec ptr
declare sub _XtCacheFlushTag cdecl alias "_XtCacheFlushTag" (byval as XtAppContext, byval as XtPointer)
declare sub _XtFreeActions cdecl alias "_XtFreeActions" (byval as _ActionListRec ptr)
declare sub _XtDoPhase2Destroy cdecl alias "_XtDoPhase2Destroy" (byval as XtAppContext, byval as integer)
declare sub _XtDoFreeBindings cdecl alias "_XtDoFreeBindings" (byval as XtAppContext)
declare sub _XtExtensionSelect cdecl alias "_XtExtensionSelect" (byval as Widget)
declare sub _XtAllocWWTable cdecl alias "_XtAllocWWTable" (byval pd as XtPerDisplay)
declare sub _XtFreeWWTable cdecl alias "_XtFreeWWTable" (byval pd as XtPerDisplay)
declare function _XtGetUserName cdecl alias "_XtGetUserName" (byval dest as zstring ptr, byval len as integer) as zstring ptr
declare function _XtPreparseCommandLine cdecl alias "_XtPreparseCommandLine" (byval urlist as XrmOptionDescRec ptr, byval num_urs as Cardinal, byval argc as integer, byval argv as zstring ptr ptr, byval applName as zstring ptr ptr, byval displayName as zstring ptr ptr, byval language as zstring ptr ptr) as XrmDatabase

#endif
