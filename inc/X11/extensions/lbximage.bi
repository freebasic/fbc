'' FreeBASIC binding for liblbxutil-1.1.0
''
'' based on the C header files:
''   ****************************************************************************
''
''   Copyright 1994, 1998  The Open Group
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
''   *****************************************************************************
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "X11/Xfuncproto.bi"

extern "C"

#define _LBX_IMAGE_H_

type _LbxBitmapCompMethod
	methodName as zstring ptr
	inited as long
	methodOpCode as long
	compInit as function() as long
	compFunc as function(byval as ubyte ptr, byval as ubyte ptr, byval as long, byval as long, byval as long, byval as long, byval as long, byval as long ptr) as long
	decompFunc as function(byval as ubyte ptr, byval as ubyte ptr, byval as long, byval as long, byval as long, byval as long) as long
end type

type LbxBitmapCompMethod as _LbxBitmapCompMethod
const LBX_MAX_DEPTHS = 5

type _LbxPixmapCompMethod
	methodName as zstring ptr
	formatMask as ulong
	depthCount as long
	depths(0 to 4) as long
	inited as long
	methodOpCode as long
	compInit as function() as long
	compFunc as function(byval as zstring ptr, byval as zstring ptr, byval as long, byval as long, byval as long, byval as long, byval as long, byval as long ptr) as long
	decompFunc as function(byval as zstring ptr, byval as zstring ptr, byval as long, byval as long) as long
end type

type LbxPixmapCompMethod as _LbxPixmapCompMethod
declare function LbxImageEncodePackBits(byval as zstring ptr, byval as zstring ptr, byval as long, byval as long, byval as long, byval as long, byval as long, byval as long ptr) as long
declare function LbxImageEncodeFaxG42D(byval as ubyte ptr, byval as ubyte ptr, byval as long, byval as long, byval as long, byval as long, byval as long, byval as long ptr) as long
declare function LbxImageDecodePackBits(byval as zstring ptr, byval as zstring ptr, byval as long, byval as long) as long
declare function LbxImageDecodeFaxG42D(byval as ubyte ptr, byval as ubyte ptr, byval as long, byval as long, byval as long, byval as long) as long

const LBX_IMAGE_COMPRESS_SUCCESS = 0
const LBX_IMAGE_COMPRESS_NO_SUPPORT = 1
const LBX_IMAGE_COMPRESS_BAD_MALLOC = 2
const LBX_IMAGE_COMPRESS_NOT_WORTH_IT = 3

end extern
