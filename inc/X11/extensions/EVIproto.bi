#pragma once

#include once "X11/extensions/EVI.bi"

#define _EVIPROTO_H_
const X_EVIQueryVersion = 0
const X_EVIGetVisualInfo = 1
type VisualID32 as CARD32
const sz_VisualID32 = 4

type _xExtendedVisualInfo
	core_visual_id as CARD32
	screen as INT8
	level as INT8
	transparency_type as CARD8
	pad0 as CARD8
	transparency_value as CARD32
	min_hw_colormaps as CARD8
	max_hw_colormaps as CARD8
	num_colormap_conflicts as CARD16
end type

type xExtendedVisualInfo as _xExtendedVisualInfo
const sz_xExtendedVisualInfo = 16

type _XEVIQueryVersion
	reqType as CARD8
	xeviReqType as CARD8
	length as CARD16
end type

type xEVIQueryVersionReq as _XEVIQueryVersion
const sz_xEVIQueryVersionReq = 4

type xEVIQueryVersionReply
	as UBYTE type
	unused as CARD8
	sequenceNumber as CARD16
	length as CARD32
	majorVersion as CARD16
	minorVersion as CARD16
	pad0 as CARD32
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
end type

const sz_xEVIQueryVersionReply = 32

type _XEVIGetVisualInfoReq
	reqType as CARD8
	xeviReqType as CARD8
	length as CARD16
	n_visual as CARD32
end type

type xEVIGetVisualInfoReq as _XEVIGetVisualInfoReq
const sz_xEVIGetVisualInfoReq = 8

type _XEVIGetVisualInfoReply
	as UBYTE type
	unused as CARD8
	sequenceNumber as CARD16
	length as CARD32
	n_info as CARD32
	n_conflicts as CARD32
	pad0 as CARD32
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
end type

type xEVIGetVisualInfoReply as _XEVIGetVisualInfoReply
const sz_xEVIGetVisualInfoReply = 32
