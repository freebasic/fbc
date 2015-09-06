'' FreeBASIC binding for videoproto-2.3.2
''
'' based on the C header files:
''   Copyright 1991 by Digital Equipment Corporation, Maynard, Massachusetts,
''   and the Massachusetts Institute of Technology, Cambridge, Massachusetts.
''
''                           All Rights Reserved
''
''   Permission to use, copy, modify, and distribute this software and its
''   documentation for any purpose and without fee is hereby granted,
''   provided that the above copyright notice appear in all copies and that
''   both that copyright notice and this permission notice appear in
''   supporting documentation, and that the names of Digital or MIT not be
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
''
''   Permission is hereby granted, free of charge, to any person obtaining a copy
''   of this software and associated documentation files (the "Software"), to deal
''   in the Software without restriction, including without limitation the rights
''   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
''   copies of the Software, and to permit persons to whom the Software is
''   furnished to do so, subject to the following conditions:
''
''   The above copyright notice and this permission notice shall be included in all
''   copies or substantial portions of the Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
''   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
''   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
''   XFREE86 PROJECT BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
''   IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
''   CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
''
''   Except as contained in this notice, the name of the XFree86 Project shall not
''   be used in advertising or otherwise to promote the sale, use or other dealings
''   in this Software without prior written authorization from the XFree86 Project.
''
''
''   Copyright (c) 2004 The Unichrome Project. All rights reserved.
''
''   Permission is hereby granted, free of charge, to any person obtaining a
''   copy of this software and associated documentation files (the "Software"),
''   to deal in the Software without restriction, including without limitation
''   the rights to use, copy, modify, merge, publish, distribute, sublicense,
''   and/or sell copies of the Software, and to permit persons to whom the
''   Software is furnished to do so, subject to the following conditions:
''
''   The above copyright notice and this permission notice shall be included in
''   all copies or substantial portions of the Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
''   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
''   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
''   AUTHOR(S) OR COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
''   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
''   FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
''   DEALINGS IN THE SOFTWARE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "X11/X.bi"
#include once "X11/extensions/Xv.bi"

#define _XVMC_H_
#define XvMCName "XVideo-MotionCompensation"
const XvMCNumEvents = 0
const XvMCNumErrors = 3
const XvMCVersion = 1
const XvMCRevision = 1
const XvMCBadContext = 0
const XvMCBadSurface = 1
const XvMCBadSubpicture = 2
const XVMC_CHROMA_FORMAT_420 = &h00000001
const XVMC_CHROMA_FORMAT_422 = &h00000002
const XVMC_CHROMA_FORMAT_444 = &h00000003
const XVMC_OVERLAID_SURFACE = &h00000001
const XVMC_BACKEND_SUBPICTURE = &h00000002
const XVMC_SUBPICTURE_INDEPENDENT_SCALING = &h00000004
const XVMC_INTRA_UNSIGNED = &h00000008
const XVMC_MOCOMP = &h00000000
const XVMC_IDCT = &h00010000
const XVMC_MPEG_1 = &h00000001
const XVMC_MPEG_2 = &h00000002
const XVMC_H263 = &h00000003
const XVMC_MPEG_4 = &h00000004
const XVMC_MB_TYPE_MOTION_FORWARD = &h02
const XVMC_MB_TYPE_MOTION_BACKWARD = &h04
const XVMC_MB_TYPE_PATTERN = &h08
const XVMC_MB_TYPE_INTRA = &h10
const XVMC_PREDICTION_FIELD = &h01
const XVMC_PREDICTION_FRAME = &h02
const XVMC_PREDICTION_DUAL_PRIME = &h03
const XVMC_PREDICTION_16x8 = &h02
const XVMC_PREDICTION_4MV = &h04
const XVMC_SELECT_FIRST_FORWARD = &h01
const XVMC_SELECT_FIRST_BACKWARD = &h02
const XVMC_SELECT_SECOND_FORWARD = &h04
const XVMC_SELECT_SECOND_BACKWARD = &h08
const XVMC_DCT_TYPE_FRAME = &h00
const XVMC_DCT_TYPE_FIELD = &h01
const XVMC_TOP_FIELD = &h00000001
const XVMC_BOTTOM_FIELD = &h00000002
const XVMC_FRAME_PICTURE = XVMC_TOP_FIELD or XVMC_BOTTOM_FIELD
const XVMC_SECOND_FIELD = &h00000004
const XVMC_DIRECT = &h00000001
const XVMC_RENDERING = &h00000001
const XVMC_DISPLAYING = &h00000002

type XvMCSurfaceInfo
	surface_type_id as long
	chroma_format as long
	max_width as ushort
	max_height as ushort
	subpicture_max_width as ushort
	subpicture_max_height as ushort
	mc_type as long
	flags as long
end type

type XvMCContext
	context_id as XID
	surface_type_id as long
	width as ushort
	height as ushort
	port as XvPortID
	flags as long
	privData as any ptr
end type

type XvMCSurface
	surface_id as XID
	context_id as XID
	surface_type_id as long
	width as ushort
	height as ushort
	privData as any ptr
end type

type XvMCSubpicture
	subpicture_id as XID
	context_id as XID
	xvimage_id as long
	width as ushort
	height as ushort
	num_palette_entries as long
	entry_bytes as long
	component_order as zstring * 4
	privData as any ptr
end type

type XvMCBlockArray
	num_blocks as ulong
	context_id as XID
	privData as any ptr
	blocks as short ptr
end type

type XvMCMacroBlock
	x as ushort
	y as ushort
	macroblock_type as ubyte
	motion_type as ubyte
	motion_vertical_field_select as ubyte
	dct_type as ubyte
	PMV(0 to 1, 0 to 1, 0 to 1) as short
	index as ulong
	coded_block_pattern as ushort
	pad0 as ushort
end type

type XvMCMacroBlockArray
	num_blocks as ulong
	context_id as XID
	privData as any ptr
	macro_blocks as XvMCMacroBlock ptr
end type
