'' FreeBASIC binding for xf86dgaproto-2.1
''
'' based on the C header files:
''
''   Copyright (c) 1995  Jon Tombs
''   Copyright (c) 1995  XFree86 Inc
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
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#define _XF86DGA1CONST_H_
const X_XF86DGAQueryVersion = 0
const X_XF86DGAGetVideoLL = 1
const X_XF86DGADirectVideo = 2
const X_XF86DGAGetViewPortSize = 3
const X_XF86DGASetViewPort = 4
const X_XF86DGAGetVidPage = 5
const X_XF86DGASetVidPage = 6
const X_XF86DGAInstallColormap = 7
const X_XF86DGAQueryDirectVideo = 8
const X_XF86DGAViewPortChanged = 9
const XF86DGADirectPresent = &h0001
const XF86DGADirectGraphics = &h0002
const XF86DGADirectMouse = &h0004
const XF86DGADirectKeyb = &h0008
const XF86DGAHasColormap = &h0100
const XF86DGADirectColormap = &h0200
