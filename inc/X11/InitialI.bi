'' FreeBASIC binding for libXt-1.1.4
''
'' based on the C header files:
''   *********************************************************
''
''   Copyright 1987, 1988, 1994, 1998  The Open Group
''
''   Permission to use, copy, modify, distribute, and sell this software and its
''   documentation for any purpose is hereby granted without fee, provided that
''   the above copyright notice appear in all copies and that both that
''   copyright notice and this permission notice appear in supporting
''   documentation.
''
''   The above copyright notice and this permission notice shall be included in
''   all copies or substantial portions of the Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
''   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
''   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
''   OPEN GROUP BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
''   AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
''   CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
''
''   Except as contained in this notice, the name of The Open Group shall not be
''   used in advertising or otherwise to promote the sale, use or other dealings
''   in this Software without prior written authorization from The Open Group.
''
''
''   Copyright 1987, 1988 by Digital Equipment Corporation, Maynard, Massachusetts.
''
''                           All Rights Reserved
''
''   Permission to use, copy, modify, and distribute this software and its
''   documentation for any purpose and without fee is hereby granted,
''   provided that the above copyright notice appear in all copies and that
''   both that copyright notice and this permission notice appear in
''   supporting documentation, and that the name of Digital not be
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
#include once "crt/sys/time.bi"

#ifdef __FB_UNIX__
	#include once "crt/limits.bi"
#elseif defined(__FB_WIN32__)
	#include once "win/winsock2.bi"
#endif

#include once "X11/Xos.bi"

extern "C"

#define _XtinitialI_h

type _TimerEventRec
	te_timer_value as timeval
	te_next as _TimerEventRec ptr
	te_proc as XtTimerCallbackProc
	app as XtAppContext
	te_closure as XtPointer
end type

type TimerEventRec as _TimerEventRec

type _InputEvent
	ie_proc as XtInputCallbackProc
	ie_closure as XtPointer
	ie_next as _InputEvent ptr
	ie_oq as _InputEvent ptr
	app as XtAppContext
	ie_source as long
	ie_condition as XtInputMask
end type

type InputEvent as _InputEvent

type _SignalEventRec
	se_proc as XtSignalCallbackProc
	se_closure as XtPointer
	se_next as _SignalEventRec ptr
	app as XtAppContext
	se_notice as XBoolean
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
	nfds as long
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
	bytes_remaining as long
end type

type DestroyRec as _DestroyRec
type _ActionListRec as _ActionListRec_
type _TMBindCacheRec as _TMBindCacheRec_
type ActionHookRec as _ActionHookRec
type ModToKeysymTable as _ModToKeysymTable
type TMKeyContextRec as _TMKeyContextRec

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
	selectionTimeout as culong
	fds as FdStruct
	count as short
	max as short
	last as short
	input_count as short
	input_max as short
	sync as XBoolean
	being_destroyed as XBoolean
	error_inited as XBoolean
	identify_windows as XBoolean
	heap as Heap
	fallback_resources as String_ ptr
	action_hook_list as ActionHookRec ptr
	block_hook_list as _BlockHookRec ptr
	destroy_list_size as long
	destroy_count as long
	dispatch_level as long
	destroy_list as DestroyRec ptr
	in_phase2_destroy as Widget
	langProcRec as LangProcRec
	free_bindings as _TMBindCacheRec ptr
	display_name_tried as String_
	dpy_destroy_list as Display ptr ptr
	dpy_destroy_count as long
	exit_flag as XBoolean
	rebuild_fdlist as XBoolean
	lock_info as LockPtr
	lock as ThreadAppProc
	unlock as ThreadAppProc
	yield_lock as ThreadAppYieldLockProc
	restore_lock as ThreadAppRestoreLockProc
	free_lock as ThreadAppProc
end type

type XtAppStruct as _XtAppStruct
declare sub _XtHeapInit(byval heap as Heap ptr)
declare sub _XtHeapFree(byval heap as Heap ptr)
declare function _XtHeapAlloc(byval as Heap ptr, byval as Cardinal) as zstring ptr
declare sub _XtSetDefaultErrorHandlers(byval as XtErrorMsgHandler ptr, byval as XtErrorMsgHandler ptr, byval as XtErrorHandler ptr, byval as XtErrorHandler ptr)
declare sub _XtSetDefaultSelectionTimeout(byval as culong ptr)
declare function _XtDefaultAppContext() as XtAppContext
declare function _XtGetProcessContext() as ProcessContext
declare function _XtAppInit(byval as XtAppContext ptr, byval as String_, byval as XrmOptionDescRec ptr, byval as Cardinal, byval as long ptr, byval as String_ ptr ptr, byval as String_ ptr) as Display ptr
declare sub _XtDestroyAppContexts()
declare sub _XtCloseDisplays(byval as XtAppContext)
extern _XtAppDestroyCount as long
declare function _XtWaitForSomething(byval as XtAppContext, byval as XBoolean, byval as XBoolean, byval as XBoolean, byval as XBoolean, byval as XBoolean, byval as XBoolean, byval as culong ptr) as long
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
	min as long
	max as long
	client_data as XtPointer
end type

type ExtSelectRec as _ExtensionSelectorRec
type _GCrec as _GCrec_
type _WWTable as _WWTable_

type _XtPerDisplayStruct
	destroy_callbacks as InternalCallbackList
	region as Region
	case_cvt as CaseConverterPtr
	defaultKeycodeTranslator as XtKeyProc
	appContext as XtAppContext
	keysyms_serial as culong
	keysyms as KeySym ptr
	keysyms_per_keycode as long
	min_keycode as long
	max_keycode as long
	modKeysyms as KeySym ptr
	modsToKeysyms as ModToKeysymTable ptr
	isModifier(0 to 31) as ubyte
	lock_meaning as KeySym
	mode_switch as Modifiers
	num_lock as Modifiers
	being_destroyed as XBoolean
	rv as XBoolean
	name as XrmName
	class as XrmClass
	heap as Heap
	GClist as _GCrec ptr
	pixmap_tab as Drawable ptr ptr
	language as String_
	last_event as XEvent
	last_timestamp as Time
	multi_click_time as long
	tm_context as TMKeyContextRec ptr
	mapping_callbacks as InternalCallbackList
	pdi as XtPerDisplayInputRec
	WWtable as _WWTable ptr
	per_screen_db as XrmDatabase ptr
	cmd_db as XrmDatabase
	server_db as XrmDatabase
	dispatcher_list as XtEventDispatchProc ptr
	ext_select_list as ExtSelectRec ptr
	ext_select_count as long
	hook_object as Widget
	rcm_init as XAtom
	rcm_data as XAtom
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
extern _XtperDisplayList as PerDisplayTablePtr
declare function _XtSortPerDisplayList(byval as Display ptr) as XtPerDisplay
declare function _XtGetPerDisplay(byval as Display ptr) as XtPerDisplay
declare function _XtGetPerDisplayInput(byval as Display ptr) as XtPerDisplayInputRec ptr
declare sub _XtDisplayInitialize(byval as Display ptr, byval as XtPerDisplay, byval as const zstring ptr, byval as XrmOptionDescRec ptr, byval as Cardinal, byval as long ptr, byval as zstring ptr ptr)
declare sub _XtCacheFlushTag(byval as XtAppContext, byval as XtPointer)
declare sub _XtFreeActions(byval as _ActionListRec ptr)
declare sub _XtDoPhase2Destroy(byval as XtAppContext, byval as long)
declare sub _XtDoFreeBindings(byval as XtAppContext)
declare sub _XtExtensionSelect(byval as Widget)
#define _XtSafeToDestroy(app) ((app)->dispatch_level = 0)
declare sub _XtAllocWWTable(byval pd as XtPerDisplay)
declare sub _XtFreeWWTable(byval pd as XtPerDisplay)
declare function _XtGetUserName(byval dest as String_, byval len as long) as String_
declare function _XtPreparseCommandLine(byval urlist as XrmOptionDescRec ptr, byval num_urs as Cardinal, byval argc as long, byval argv as String_ ptr, byval applName as String_ ptr, byval displayName as String_ ptr, byval language as String_ ptr) as XrmDatabase

end extern
