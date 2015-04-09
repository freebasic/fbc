'' FreeBASIC binding for liblbxutil-1.1.0

#pragma once

#include once "lbxproto.bi"

extern "C"

#define LBX_DELTA_STRUCT_H
const MIN_CACHEABLE_LEN = 8
#define DELTA_CACHEABLE(pcache, len) (((len) > MIN_CACHEABLE_LEN) andalso ((len) <= (pcache)->maxDeltasize))

type _LBXDeltaElem
	length as long
	buf as ubyte ptr
end type

type LBXDeltaElemRec as _LBXDeltaElem
type LBXDeltaElemPtr as _LBXDeltaElem ptr

type _LBXDeltas
	nDeltas as ushort
	maxDeltasize as ushort
	deltas as LBXDeltaElemPtr
	nextDelta as ushort
	activeDeltas as ushort
end type

type LBXDeltasRec as _LBXDeltas
type LBXDeltasPtr as _LBXDeltas ptr

type lbxMotionCache
	swapped as UBYTE
	detail as UBYTE
	sequenceNumber as CARD16
	time as Time
	root as Window
	event as Window
	child as Window
	rootX as INT16
	rootY as INT16
	eventX as INT16
	eventY as INT16
	state as KeyButMask
	sameScreen as XBOOL
end type

type lbxQuickMotionDeltaEvent
	as UBYTE type
	deltaTime as CARD8
	deltaX as INT8
	deltaY as INT8
end type

const sz_lbxQuickMotionDeltaEvent = 4

type lbxMotionDeltaEvent
	as UBYTE type
	lbxType as UBYTE
	deltaX as INT8
	deltaY as INT8
	deltaTime as CARD16
	deltaSequence as CARD16
end type

const sz_lbxMotionDeltaEvent = 8
declare function LBXInitDeltaCache(byval pcache as LBXDeltasPtr, byval nDeltas as long, byval maxDeltasize as long) as long
declare sub LBXFreeDeltaCache(byval pcache as LBXDeltasPtr)
declare function LBXDeltaMinDiffs(byval pcache as LBXDeltasPtr, byval inmsg as ubyte ptr, byval inmsglen as long, byval maxdiff as long, byval pindex as long ptr) as long
declare sub LBXEncodeDelta(byval pcache as LBXDeltasPtr, byval inmsg as ubyte ptr, byval ndiff as long, byval index as long, byval buf as ubyte ptr)
declare function LBXDecodeDelta(byval pcache as LBXDeltasPtr, byval deltas as xLbxDiffItem ptr, byval ndiff as long, byval index as long, byval buf as ubyte ptr ptr) as long
declare sub LBXAddDeltaOut(byval pcache as LBXDeltasPtr, byval inmsg as ubyte ptr, byval inmsglen as long)
declare sub LBXAddDeltaIn(byval pcache as LBXDeltasPtr, byval inmsg as ubyte ptr, byval inmsglen as long)

end extern
