'' FreeBASIC binding for libXxf86vm-1.1.4
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

#include once "crt/long.bi"
#include once "X11/Xfuncproto.bi"
#include once "X11/Xmd.bi"
#include once "X11/extensions/xf86vm.bi"

extern "C"

#define _XF86VIDMODE_H_
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

type XF86VidModeModeLine
	hdisplay as ushort
	hsyncstart as ushort
	hsyncend as ushort
	htotal as ushort
	hskew as ushort
	vdisplay as ushort
	vsyncstart as ushort
	vsyncend as ushort
	vtotal as ushort
	flags as ulong
	privsize as long
	as INT32 ptr private
end type

type XF86VidModeModeInfo
	dotclock as ulong
	hdisplay as ushort
	hsyncstart as ushort
	hsyncend as ushort
	htotal as ushort
	hskew as ushort
	vdisplay as ushort
	vsyncstart as ushort
	vsyncend as ushort
	vtotal as ushort
	flags as ulong
	privsize as long
	as INT32 ptr private
end type

type XF86VidModeSyncRange
	hi as single
	lo as single
end type

type XF86VidModeMonitor
	vendor as zstring ptr
	model as zstring ptr
	EMPTY as single
	nhsync as ubyte
	hsync as XF86VidModeSyncRange ptr
	nvsync as ubyte
	vsync as XF86VidModeSyncRange ptr
end type

type XF86VidModeNotifyEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	root as Window
	state as long
	kind as long
	forced as long
	time as Time
end type

type XF86VidModeGamma
	red as single
	green as single
	blue as single
end type

#define XF86VidModeSelectNextMode(disp, scr) XF86VidModeSwitchMode(disp, scr, 1)
#define XF86VidModeSelectPrevMode(disp, scr) XF86VidModeSwitchMode(disp, scr, -1)
declare function XF86VidModeQueryVersion(byval as Display ptr, byval as long ptr, byval as long ptr) as long
declare function XF86VidModeQueryExtension(byval as Display ptr, byval as long ptr, byval as long ptr) as long
declare function XF86VidModeSetClientVersion(byval as Display ptr) as long
declare function XF86VidModeGetModeLine(byval as Display ptr, byval as long, byval as long ptr, byval as XF86VidModeModeLine ptr) as long
declare function XF86VidModeGetAllModeLines(byval as Display ptr, byval as long, byval as long ptr, byval as XF86VidModeModeInfo ptr ptr ptr) as long
declare function XF86VidModeAddModeLine(byval as Display ptr, byval as long, byval as XF86VidModeModeInfo ptr, byval as XF86VidModeModeInfo ptr) as long
declare function XF86VidModeDeleteModeLine(byval as Display ptr, byval as long, byval as XF86VidModeModeInfo ptr) as long
declare function XF86VidModeModModeLine(byval as Display ptr, byval as long, byval as XF86VidModeModeLine ptr) as long
declare function XF86VidModeValidateModeLine(byval as Display ptr, byval as long, byval as XF86VidModeModeInfo ptr) as long
declare function XF86VidModeSwitchMode(byval as Display ptr, byval as long, byval as long) as long
declare function XF86VidModeSwitchToMode(byval as Display ptr, byval as long, byval as XF86VidModeModeInfo ptr) as long
declare function XF86VidModeLockModeSwitch(byval as Display ptr, byval as long, byval as long) as long
declare function XF86VidModeGetMonitor(byval as Display ptr, byval as long, byval as XF86VidModeMonitor ptr) as long
declare function XF86VidModeGetViewPort(byval as Display ptr, byval as long, byval as long ptr, byval as long ptr) as long
declare function XF86VidModeSetViewPort(byval as Display ptr, byval as long, byval as long, byval as long) as long
declare function XF86VidModeGetDotClocks(byval as Display ptr, byval as long, byval as long ptr, byval as long ptr, byval as long ptr, byval as long ptr ptr) as long
declare function XF86VidModeGetGamma(byval as Display ptr, byval as long, byval as XF86VidModeGamma ptr) as long
declare function XF86VidModeSetGamma(byval as Display ptr, byval as long, byval as XF86VidModeGamma ptr) as long
declare function XF86VidModeSetGammaRamp(byval as Display ptr, byval as long, byval as long, byval as ushort ptr, byval as ushort ptr, byval as ushort ptr) as long
declare function XF86VidModeGetGammaRamp(byval as Display ptr, byval as long, byval as long, byval as ushort ptr, byval as ushort ptr, byval as ushort ptr) as long
declare function XF86VidModeGetGammaRampSize(byval as Display ptr, byval as long, byval as long ptr) as long
declare function XF86VidModeGetPermissions(byval as Display ptr, byval as long, byval as long ptr) as long

end extern
