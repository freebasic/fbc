'' FreeBASIC binding for videoproto-2.3.2
''
'' based on the C header files:
''   **************************************************************************
''   VLD XvMC Nonstandard extension API.
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
''   Author: Thomas Hellström, 2004.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "X11/Xlib.bi"
#include once "X11/extensions/XvMC.bi"

extern "C"

#define _VLDXVMC_H
const XVMC_VLD = &h0020000
const XVMC_PROGRESSIVE_SEQUENCE = &h00000010
const XVMC_ZIG_ZAG_SCAN = &h00000000
const XVMC_ALTERNATE_SCAN = &h00000100
const XVMC_PRED_DCT_FRAME = &h00000040
const XVMC_PRED_DCT_FIELD = &h00000000
const XVMC_TOP_FIELD_FIRST = &h00000080
const XVMC_BOTTOM_FIELD_FIRST = &h00000000
const XVMC_CONCEALMENT_MOTION_VECTORS = &h00000200
const XVMC_Q_SCALE_TYPE = &h00000400
const XVMC_INTRA_VLC_FORMAT = &h00000800
const XVMC_I_PICTURE = 1
const XVMC_P_PICTURE = 2
const XVMC_B_PICTURE = 3

type _XvMCMpegControl
	BVMV_range as ulong
	BHMV_range as ulong
	FVMV_range as ulong
	FHMV_range as ulong
	picture_structure as ulong
	intra_dc_precision as ulong
	picture_coding_type as ulong
	mpeg_coding as ulong
	flags as ulong
end type

type XvMCMpegControl as _XvMCMpegControl
declare function XvMCBeginSurface(byval display as Display ptr, byval context as XvMCContext ptr, byval target_surface as XvMCSurface ptr, byval past_surface as XvMCSurface ptr, byval future_surface as XvMCSurface ptr, byval control as const XvMCMpegControl ptr) as long

type _XvMCQMatrix
	load_intra_quantiser_matrix as long
	load_non_intra_quantiser_matrix as long
	load_chroma_intra_quantiser_matrix as long
	load_chroma_non_intra_quantiser_matrix as long
	intra_quantiser_matrix(0 to 63) as ubyte
	non_intra_quantiser_matrix(0 to 63) as ubyte
	chroma_intra_quantiser_matrix(0 to 63) as ubyte
	chroma_non_intra_quantiser_matrix(0 to 63) as ubyte
end type

type XvMCQMatrix as _XvMCQMatrix
declare function XvMCLoadQMatrix(byval display as Display ptr, byval context as XvMCContext ptr, byval qmx as const XvMCQMatrix ptr) as long
declare function XvMCPutSlice(byval display as Display ptr, byval context as XvMCContext ptr, byval slice as zstring ptr, byval nBytes as long) as long
declare function XvMCPutSlice2(byval display as Display ptr, byval context as XvMCContext ptr, byval slice as zstring ptr, byval nBytes as long, byval sliceCode as long) as long

end extern
