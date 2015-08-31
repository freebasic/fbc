'' FreeBASIC binding for xextproto-7.3.0
''
'' based on the C header files:
''   Copyright 1996, 1998  The Open Group
''
''   Permission to use, copy, modify, distribute, and sell this software and its
''   documentation for any purpose is hereby granted without fee, provided that
''   the above copyright notice appear in all copies and that both that
''   copyright notice and this permission notice appear in supporting
''   documentation.
''
''   The above copyright notice and this permission notice shall be included
''   in all copies or substantial portions of the Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
''   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
''   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
''   IN NO EVENT SHALL THE OPEN GROUP BE LIABLE FOR ANY CLAIM, DAMAGES OR
''   OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
''   ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
''   OTHER DEALINGS IN THE SOFTWARE.
''
''   Except as contained in this notice, the name of The Open Group shall
''   not be used in advertising or otherwise to promote the sale, use or
''   other dealings in this Software without prior written authorization
''   from The Open Group.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#define _AG_H_
#define XAGNAME "XC-APPGROUP"
const XAG_MAJOR_VERSION = 1
const XAG_MINOR_VERSION = 0
const XagWindowTypeX11 = 0
const XagWindowTypeMacintosh = 1
const XagWindowTypeWin32 = 2
const XagWindowTypeWin16 = 3
const XagBadAppGroup = 0
const XagNumberErrors = XagBadAppGroup + 1
const XagNsingleScreen = 7
const XagNdefaultRoot = 1
const XagNrootVisual = 2
const XagNdefaultColormap = 3
const XagNblackPixel = 4
const XagNwhitePixel = 5
const XagNappGroupLeader = 6
