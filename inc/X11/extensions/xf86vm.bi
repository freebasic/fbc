'' FreeBASIC binding for xf86vidmodeproto-2.3.1
''
'' based on the C header files:
''
''   Copyright 1995  Kaleb S. KEITHLEY
''
''   Permission is hereby granted, free of charge, to any person obtaining
''   a copy of this software and associated documentation files (the
''   "Software"), to deal in the Software without restriction, including
''   without limitation the rights to use, copy, modify, merge, publish,
''   distribute, sublicense, and/or sell copies of the Software, and to
''   permit persons to whom the Software is furnished to do so, subject to
''   the following conditions:
''
''   The above copyright notice and this permission notice shall be
''   included in all copies or substantial portions of the Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
''   EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
''   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
''   IN NO EVENT SHALL Kaleb S. KEITHLEY BE LIABLE FOR ANY CLAIM, DAMAGES 
''   OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
''   ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
''   OTHER DEALINGS IN THE SOFTWARE.
''
''   Except as contained in this notice, the name of Kaleb S. KEITHLEY 
''   shall not be used in advertising or otherwise to promote the sale, use 
''   or other dealings in this Software without prior written authorization
''   from Kaleb S. KEITHLEY
''
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "X11/Xmd.bi"

#define _XF86VM_H_
const CLKFLAG_PROGRAMABLE = 1
const XF86VidModeNumberEvents = 0
const XF86VidModeBadClock = 0
const XF86VidModeBadHTimings = 1
const XF86VidModeBadVTimings = 2
const XF86VidModeModeUnsuitable = 3
const XF86VidModeExtensionDisabled = 4
const XF86VidModeClientNotLocal = 5
const XF86VidModeZoomLocked = 6
#define XF86VidModeNumberErrors (XF86VidModeZoomLocked + 1)
const XF86VM_READ_PERMISSION = 1
const XF86VM_WRITE_PERMISSION = 2
