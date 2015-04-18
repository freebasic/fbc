'' FreeBASIC binding for libXext-1.3.3
''
'' based on the C header files:
''   ***************************************************************
''
''   Copyright (c) 1996 Digital Equipment Corporation, Maynard, Massachusetts.
''
''   Permission is hereby granted, free of charge, to any person obtaining a copy
''   of this software and associated documentation files (the "Software"), to deal
''   in the Software without restriction, including without limitation the rights
''   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
''   copies of the Software.
''
''   The above copyright notice and this permission notice shall be included in
''   all copies or substantial portions of the Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
''   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
''   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
''   DIGITAL EQUIPMENT CORPORATION BE LIABLE FOR ANY CLAIM, DAMAGES, INCLUDING,
''   BUT NOT LIMITED TO CONSEQUENTIAL OR INCIDENTAL DAMAGES, OR OTHER LIABILITY,
''   WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR
''   IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
''
''   Except as contained in this notice, the name of Digital Equipment Corporation
''   shall not be used in advertising or otherwise to promote the sale, use or other
''   dealings in this Software without prior written authorization from Digital
''   Equipment Corporation.
''
''   *****************************************************************
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "X11/X.bi"
#include once "X11/Xmd.bi"
#include once "X11/extensions/dpmsconst.bi"

extern "C"

const _X11_EXTENSIONS_DPMS_H = 1
declare function DPMSQueryExtension(byval as Display ptr, byval as long ptr, byval as long ptr) as long
declare function DPMSGetVersion(byval as Display ptr, byval as long ptr, byval as long ptr) as long
declare function DPMSCapable(byval as Display ptr) as long
declare function DPMSSetTimeouts(byval as Display ptr, byval as CARD16, byval as CARD16, byval as CARD16) as long
declare function DPMSGetTimeouts(byval as Display ptr, byval as CARD16 ptr, byval as CARD16 ptr, byval as CARD16 ptr) as long
declare function DPMSEnable(byval as Display ptr) as long
declare function DPMSDisable(byval as Display ptr) as long
declare function DPMSForceLevel(byval as Display ptr, byval as CARD16) as long
declare function DPMSInfo(byval as Display ptr, byval as CARD16 ptr, byval as XBOOL ptr) as long

end extern
