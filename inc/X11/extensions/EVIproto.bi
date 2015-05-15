'' FreeBASIC binding for xextproto-7.3.0
''
'' based on the C header files:
''   **********************************************************
''   Copyright (c) 1997 by Silicon Graphics Computer Systems, Inc.
''   Permission to use, copy, modify, and distribute this
''   software and its documentation for any purpose and without
''   fee is hereby granted, provided that the above copyright
''   notice appear in all copies and that both that copyright
''   notice and this permission notice appear in supporting
''   documentation, and that the name of Silicon Graphics not be
''   used in advertising or publicity pertaining to distribution
''   of the software without specific prior written permission.
''   Silicon Graphics makes no representation about the suitability
''   of this software for any purpose. It is provided "as is"
''   without any express or implied warranty.
''   SILICON GRAPHICS DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS
''   SOFTWARE, INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
''   AND FITNESS FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL SILICON
''   GRAPHICS BE LIABLE FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL
''   DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE,
''   DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE
''   OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION  WITH
''   THE USE OR PERFORMANCE OF THIS SOFTWARE.
''   *******************************************************
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

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
