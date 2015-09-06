'' FreeBASIC binding for libXt-1.1.4
''
'' based on the C header files:
''   *********************************************************
''
''   Copyright 1987, 1988, 1998  The Open Group
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
#include once "CallbackI.bi"
#include once "EventI.bi"
#include once "HookObjI.bi"
#include once "PassivGraI.bi"
#include once "ThreadsI.bi"
#include once "InitialI.bi"
#include once "ResourceI.bi"
#include once "StringDefs.bi"

extern "C"

#define CACHE_TRANSLATIONS
const TM_NO_MATCH = -2
#define _XtRStateTablePair "_XtStateTablePair"

type TMByteCard as ubyte
type TMShortCard as ushort
type TMLongCard as culong
type TMShortInt as short
type TMTypeMatch as _TMTypeMatchRec ptr
type TMModifierMatch as _TMModifierMatchRec ptr
type TMEventPtr as _TMEventRec ptr
type MatchProc as function(byval typeMatch as TMTypeMatch, byval modMatch as TMModifierMatch, byval eventSeq as TMEventPtr) as XBoolean

type _ModToKeysymTable
	mask as Modifiers
	count as long
	idx as long
end type

type ModToKeysymTable as _ModToKeysymTable

type _LateBindings
	knot : 1 as ulong
	pair : 1 as ulong
	ref_count as ushort
	keysym as KeySym
end type

type LateBindings as _LateBindings
type LateBindingsPtr as _LateBindings ptr
type ModifierMask as short
type ActionPtr as _ActionsRec ptr

type _ActionsRec
	idx as long
	params as String_ ptr
	num_params as Cardinal
	next as ActionPtr
end type

type ActionRec as _ActionsRec
type StatePtr as _XtStateRec ptr

type _XtStateRec_
	isCycleStart : 1 as ulong
	isCycleEnd : 1 as ulong
	typeIndex as TMShortCard
	modIndex as TMShortCard
	actions as ActionPtr
	nextLevel as StatePtr
end type

type StateRec as _XtStateRec
const XtTableReplace = 0
const XtTableAugment = 1
const XtTableOverride = 2
const XtTableUnmerge = 3
type _XtTranslateOp as ulong

type _TMModifierMatchRec
	modifiers as TMLongCard
	modifierMask as TMLongCard
	lateModifiers as LateBindingsPtr
	standard as XBoolean
end type

type TMModifierMatchRec as _TMModifierMatchRec

type _TMTypeMatchRec
	eventType as TMLongCard
	eventCode as TMLongCard
	eventCodeMask as TMLongCard
	matchEvent as MatchProc
end type

type TMTypeMatchRec as _TMTypeMatchRec

type _TMBranchHeadRec
	isSimple : 1 as ulong
	hasActions : 1 as ulong
	hasCycles : 1 as ulong
	more : 13 as ulong
	typeIndex as TMShortCard
	modIndex as TMShortCard
end type

type TMBranchHeadRec as _TMBranchHeadRec
type TMBranchHead as _TMBranchHeadRec ptr

type _TMSimpleStateTreeRec
	isSimple : 1 as ulong
	isAccelerator : 1 as ulong
	mappingNotifyInterest : 1 as ulong
	refCount : 13 as ulong
	numBranchHeads as TMShortCard
	numQuarks as TMShortCard
	unused as TMShortCard
	branchHeadTbl as TMBranchHeadRec ptr
	quarkTbl as XrmQuark ptr
end type

type TMSimpleStateTreeRec as _TMSimpleStateTreeRec
type TMSimpleStateTree as _TMSimpleStateTreeRec ptr

type _TMComplexStateTreeRec
	isSimple : 1 as ulong
	isAccelerator : 1 as ulong
	mappingNotifyInterest : 1 as ulong
	refCount : 13 as ulong
	numBranchHeads as TMShortCard
	numQuarks as TMShortCard
	numComplexBranchHeads as TMShortCard
	branchHeadTbl as TMBranchHeadRec ptr
	quarkTbl as XrmQuark ptr
	complexBranchHeadTbl as StatePtr ptr
end type

type TMComplexStateTreeRec as _TMComplexStateTreeRec
type TMComplexStateTree as _TMComplexStateTreeRec ptr

type _TMParseStateTreeRec
	isSimple : 1 as ulong
	isAccelerator : 1 as ulong
	mappingNotifyInterest : 1 as ulong
	isStackQuarks : 1 as ulong
	isStackBranchHeads : 1 as ulong
	isStackComplexBranchHeads : 1 as ulong
	unused : 10 as ulong
	numBranchHeads as TMShortCard
	numQuarks as TMShortCard
	numComplexBranchHeads as TMShortCard
	branchHeadTbl as TMBranchHeadRec ptr
	quarkTbl as XrmQuark ptr
	complexBranchHeadTbl as StatePtr ptr
	branchHeadTblSize as TMShortCard
	quarkTblSize as TMShortCard
	complexBranchHeadTblSize as TMShortCard
	head as StatePtr
end type

type TMParseStateTreeRec as _TMParseStateTreeRec
type TMParseStateTree as _TMParseStateTreeRec ptr

union _TMStateTreeRec
	simple as TMSimpleStateTreeRec
	parse as TMParseStateTreeRec
	complex as TMComplexStateTreeRec
end union

type TMStateTree as _TMStateTreeRec ptr
type TMStateTreePtr as _TMStateTreeRec ptr ptr
type TMStateTreeList as _TMStateTreeRec ptr ptr

type _TMSimpleBindProcsRec
	procs as XtActionProc ptr
end type

type TMSimpleBindProcsRec as _TMSimpleBindProcsRec
type TMSimpleBindProcs as _TMSimpleBindProcsRec ptr

type _TMComplexBindProcsRec
	widget as Widget
	aXlations as XtTranslations
	procs as XtActionProc ptr
end type

type TMComplexBindProcsRec as _TMComplexBindProcsRec
type TMComplexBindProcs as _TMComplexBindProcsRec ptr

type _TMSimpleBindDataRec
	isComplex : 1 as ulong
	bindTbl(0 to 0) as TMSimpleBindProcsRec
end type

type TMSimpleBindDataRec as _TMSimpleBindDataRec
type TMSimpleBindData as _TMSimpleBindDataRec ptr
type _ATranslationData as _ATranslationData_

type _TMComplexBindDataRec
	isComplex : 1 as ulong
	accel_context as _ATranslationData ptr
	bindTbl(0 to 0) as TMComplexBindProcsRec
end type

type TMComplexBindDataRec as _TMComplexBindDataRec
type TMComplexBindData as _TMComplexBindDataRec ptr

union _TMBindDataRec
	simple as TMSimpleBindDataRec
	complex as TMComplexBindDataRec
end union

type TMBindData as _TMBindDataRec ptr

type _TranslationData
	hasBindings as ubyte
	operation as ubyte
	numStateTrees as TMShortCard
	composers(0 to 1) as _TranslationData ptr
	eventMask as EventMask
	stateTreeTbl(0 to 0) as TMStateTree
end type

type TranslationData as _TranslationData

type _ATranslationData_
	hasBindings as ubyte
	operation as ubyte
	xlations as _TranslationData ptr
	next as _ATranslationData ptr
	bindTbl(0 to 0) as TMComplexBindProcsRec
end type

type ATranslationData as _ATranslationData
type ATranslations as _ATranslationData ptr

type _TMConvertRec
	old as XtTranslations
	new_ as XtTranslations
end type

type TMConvertRec as _TMConvertRec
const _XtEventTimerEventType = cast(TMLongCard, not cast(clong, 0))
const KeysymModMask = cast(clong, 1) shl 27
const AnyButtonMask = cast(clong, 1) shl 28

type _EventRec
	modifiers as TMLongCard
	modifierMask as TMLongCard
	lateModifiers as LateBindingsPtr
	eventType as TMLongCard
	eventCode as TMLongCard
	eventCodeMask as TMLongCard
	matchEvent as MatchProc
	standard as XBoolean
end type

type Event as _EventRec
type EventSeqPtr as _EventSeqRec ptr

type _EventSeqRec
	event as Event
	state as StatePtr
	next as EventSeqPtr
	actions as ActionPtr
end type

type EventSeqRec as _EventSeqRec
type EventRec as EventSeqRec
type EventPtr as EventSeqPtr

type _TMEventRec
	xev as XEvent ptr
	event as Event
end type

type TMEventRec as _TMEventRec

type _ActionHookRec
	next as _ActionHookRec ptr
	app as XtAppContext
	proc as XtActionHookProc
	closure as XtPointer
end type

type ActionHookRec as _ActionHookRec
type ActionHook as _ActionHookRec ptr
const TMKEYCACHELOG2 = 6
const TMKEYCACHESIZE = 1 shl TMKEYCACHELOG2

type _KeyCacheRec
	modifiers_return(0 to 255) as ubyte
	keycode(0 to (1 shl 6) - 1) as KeyCode
	modifiers(0 to (1 shl 6) - 1) as ubyte
	keysym(0 to (1 shl 6) - 1) as KeySym
end type

type TMKeyCache as _KeyCacheRec

type _TMKeyContextRec
	event as XEvent ptr
	serial as culong
	keysym as KeySym
	modifiers as Modifiers
	keycache as TMKeyCache
end type

type TMKeyContextRec as _TMKeyContextRec
type TMKeyContext as _TMKeyContextRec ptr

type _TMGlobalRec
	typeMatchSegmentTbl as TMTypeMatchRec ptr ptr
	numTypeMatches as TMShortCard
	numTypeMatchSegments as TMShortCard
	typeMatchSegmentTblSize as TMShortCard
	modMatchSegmentTbl as TMModifierMatchRec ptr ptr
	numModMatches as TMShortCard
	numModMatchSegments as TMShortCard
	modMatchSegmentTblSize as TMShortCard
	newMatchSemantics as XBoolean
end type

type TMGlobalRec as _TMGlobalRec
extern _XtGlobalTM as TMGlobalRec
const TM_MOD_SEGMENT_SIZE = 16
const TM_TYPE_SEGMENT_SIZE = 16
#define TMGetTypeMatch(idx) cast(TMTypeMatch, @_XtGlobalTM.typeMatchSegmentTbl[((idx) shr 4)][((idx) and 15)])
#define TMGetModifierMatch(idx) cast(TMModifierMatch, @_XtGlobalTM.modMatchSegmentTbl[((idx) shr 4)][((idx) and 15)])
#define TMNewMatchSemantics() _XtGlobalTM.newMatchSemantics
#define TMBranchMore(branch) branch->more
#define TMComplexBranchHead(tree, br) cast(TMComplexStateTree, tree)->complexBranchHeadTbl[TMBranchMore(br)]
#define TMGetComplexBindEntry(bindData, idx) cast(TMComplexBindProcs, @cast(TMComplexBindData, bindData)->bindTbl[idx])
#define TMGetSimpleBindEntry(bindData, idx) cast(TMSimpleBindProcs, @cast(TMSimpleBindData, bindData)->bindTbl[idx])
#macro _InitializeKeysymTables(dpy, pd)
	if pd->keysyms = NULL then
		_XtBuildKeysymTables(dpy, pd)
	end if
#endmacro

declare sub _XtPopup(byval as Widget, byval as XtGrabKind, byval as XBoolean)
declare function _XtPrintXlations(byval as Widget, byval as XtTranslations, byval as Widget, byval as XBoolean) as String_
declare sub _XtRegisterGrabs(byval as Widget)
declare function _XtInitializeActionData(byval as _XtActionsRec ptr, byval as Cardinal, byval as XBoolean) as XtPointer
declare sub _XtAddEventSeqToStateTree(byval as EventSeqPtr, byval as TMParseStateTree)
declare function _XtMatchUsingStandardMods(byval as TMTypeMatch, byval as TMModifierMatch, byval as TMEventPtr) as XBoolean
declare function _XtMatchUsingDontCareMods(byval as TMTypeMatch, byval as TMModifierMatch, byval as TMEventPtr) as XBoolean
declare function _XtRegularMatch(byval as TMTypeMatch, byval as TMModifierMatch, byval as TMEventPtr) as XBoolean
declare function _XtMatchAtom(byval as TMTypeMatch, byval as TMModifierMatch, byval as TMEventPtr) as XBoolean
declare sub _XtTranslateEvent(byval as Widget, byval as XEvent ptr)
declare sub _XtBuildKeysymTables(byval dpy as Display ptr, byval pd as XtPerDisplay)
declare sub _XtDisplayTranslations(byval as Widget, byval as XEvent ptr, byval as String_ ptr, byval as Cardinal ptr)
declare sub _XtDisplayAccelerators(byval as Widget, byval as XEvent ptr, byval as String_ ptr, byval as Cardinal ptr)
declare sub _XtDisplayInstalledAccelerators(byval as Widget, byval as XEvent ptr, byval as String_ ptr, byval as Cardinal ptr)
declare sub _XtPopupInitialize(byval as XtAppContext)
declare sub _XtBindActions(byval as Widget, byval as XtTM)
declare function _XtComputeLateBindings(byval as Display ptr, byval as LateBindingsPtr, byval as Modifiers ptr, byval as Modifiers ptr) as XBoolean
declare function _XtCreateXlations(byval as TMStateTree ptr, byval as TMShortCard, byval as XtTranslations, byval as XtTranslations) as XtTranslations
declare function _XtCvtMergeTranslations(byval as Display ptr, byval as XrmValuePtr, byval as Cardinal ptr, byval as XrmValuePtr, byval as XrmValuePtr, byval as XtPointer ptr) as XBoolean
declare sub _XtRemoveStateTreeByIndex(byval as XtTranslations, byval as TMShortCard)
declare sub _XtFreeTranslations(byval as XtAppContext, byval as XrmValuePtr, byval as XtPointer, byval as XrmValuePtr, byval as Cardinal ptr)
declare function _XtGetModifierIndex(byval as Event ptr) as TMShortCard
declare function _XtGetQuarkIndex(byval as TMParseStateTree, byval as XrmQuark) as TMShortCard
declare function _XtGetTranslationValue(byval as Widget) as XtTranslations
declare function _XtGetTypeIndex(byval as Event ptr) as TMShortCard
declare sub _XtGrabInitialize(byval as XtAppContext)
declare sub _XtInstallTranslations(byval as Widget)
declare sub _XtRemoveTranslations(byval as Widget)
declare sub _XtDestroyTMData(byval as Widget)
declare sub _XtMergeTranslations(byval as Widget, byval as XtTranslations, byval as _XtTranslateOp)
declare sub _XtActionInitialize(byval as XtAppContext)
declare function _XtParseTreeToStateTree(byval as TMParseStateTree) as TMStateTree
declare function _XtPrintActions(byval as ActionRec ptr, byval as XrmQuark ptr) as String_
declare function _XtPrintState(byval as TMStateTree, byval as TMBranchHead) as String_
declare function _XtPrintEventSeq(byval as EventSeqPtr, byval as Display ptr) as String_
type _XtTraversalProc as function(byval as StatePtr, byval as XtPointer) as XBoolean
declare sub _XtTraverseStateTree(byval as TMStateTree, byval as _XtTraversalProc, byval as XtPointer)
declare sub _XtTranslateInitialize()
declare sub _XtAddTMConverters(byval as ConverterTable)
declare sub _XtUnbindActions(byval as Widget, byval as XtTranslations, byval as TMBindData)
declare sub _XtUnmergeTranslations(byval as Widget, byval as XtTranslations)
declare sub _XtAllocTMContext(byval pd as XtPerDisplay)

end extern
