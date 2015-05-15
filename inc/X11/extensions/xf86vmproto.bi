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

#include once "X11/extensions/xf86vm.bi"

#define _XF86VIDMODEPROTO_H_
#define XF86VIDMODENAME "XFree86-VidModeExtension"
const XF86VIDMODE_MAJOR_VERSION = 2
const XF86VIDMODE_MINOR_VERSION = 2
const X_XF86VidModeQueryVersion = 0
const X_XF86VidModeGetModeLine = 1
const X_XF86VidModeModModeLine = 2
const X_XF86VidModeSwitchMode = 3
const X_XF86VidModeGetMonitor = 4
const X_XF86VidModeLockModeSwitch = 5
const X_XF86VidModeGetAllModeLines = 6
const X_XF86VidModeAddModeLine = 7
const X_XF86VidModeDeleteModeLine = 8
const X_XF86VidModeValidateModeLine = 9
const X_XF86VidModeSwitchToMode = 10
const X_XF86VidModeGetViewPort = 11
const X_XF86VidModeSetViewPort = 12
const X_XF86VidModeGetDotClocks = 13
const X_XF86VidModeSetClientVersion = 14
const X_XF86VidModeSetGamma = 15
const X_XF86VidModeGetGamma = 16
const X_XF86VidModeGetGammaRamp = 17
const X_XF86VidModeSetGammaRamp = 18
const X_XF86VidModeGetGammaRampSize = 19
const X_XF86VidModeGetPermissions = 20

type _XF86VidModeQueryVersion
	reqType as CARD8
	xf86vidmodeReqType as CARD8
	length as CARD16
end type

type xXF86VidModeQueryVersionReq as _XF86VidModeQueryVersion
const sz_xXF86VidModeQueryVersionReq = 4

type xXF86VidModeQueryVersionReply
	as UBYTE type
	pad1 as XBOOL
	sequenceNumber as CARD16
	length as CARD32
	majorVersion as CARD16
	minorVersion as CARD16
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
end type

const sz_xXF86VidModeQueryVersionReply = 32

type _XF86VidModeGetModeLine
	reqType as CARD8
	xf86vidmodeReqType as CARD8
	length as CARD16
	screen as CARD16
	pad as CARD16
end type

type xXF86VidModeGetModeLineReq as _XF86VidModeGetModeLine
type xXF86VidModeGetAllModeLinesReq as _XF86VidModeGetModeLine
type xXF86VidModeGetMonitorReq as _XF86VidModeGetModeLine
type xXF86VidModeGetViewPortReq as _XF86VidModeGetModeLine
type xXF86VidModeGetDotClocksReq as _XF86VidModeGetModeLine
type xXF86VidModeGetPermissionsReq as _XF86VidModeGetModeLine

const sz_xXF86VidModeGetModeLineReq = 8
const sz_xXF86VidModeGetAllModeLinesReq = 8
const sz_xXF86VidModeGetMonitorReq = 8
const sz_xXF86VidModeGetViewPortReq = 8
const sz_xXF86VidModeGetDotClocksReq = 8
const sz_xXF86VidModeGetPermissionsReq = 8

type xXF86VidModeGetModeLineReply
	as UBYTE type
	pad1 as XBOOL
	sequenceNumber as CARD16
	length as CARD32
	dotclock as CARD32
	hdisplay as CARD16
	hsyncstart as CARD16
	hsyncend as CARD16
	htotal as CARD16
	hskew as CARD16
	vdisplay as CARD16
	vsyncstart as CARD16
	vsyncend as CARD16
	vtotal as CARD16
	pad2 as CARD16
	flags as CARD32
	reserved1 as CARD32
	reserved2 as CARD32
	reserved3 as CARD32
	privsize as CARD32
end type

const sz_xXF86VidModeGetModeLineReply = 52

type xXF86OldVidModeGetModeLineReply
	as UBYTE type
	pad1 as XBOOL
	sequenceNumber as CARD16
	length as CARD32
	dotclock as CARD32
	hdisplay as CARD16
	hsyncstart as CARD16
	hsyncend as CARD16
	htotal as CARD16
	vdisplay as CARD16
	vsyncstart as CARD16
	vsyncend as CARD16
	vtotal as CARD16
	flags as CARD32
	privsize as CARD32
end type

const sz_xXF86OldVidModeGetModeLineReply = 36

type xXF86VidModeModeInfo
	dotclock as CARD32
	hdisplay as CARD16
	hsyncstart as CARD16
	hsyncend as CARD16
	htotal as CARD16
	hskew as CARD32
	vdisplay as CARD16
	vsyncstart as CARD16
	vsyncend as CARD16
	vtotal as CARD16
	pad1 as CARD16
	flags as CARD32
	reserved1 as CARD32
	reserved2 as CARD32
	reserved3 as CARD32
	privsize as CARD32
end type

type xXF86OldVidModeModeInfo
	dotclock as CARD32
	hdisplay as CARD16
	hsyncstart as CARD16
	hsyncend as CARD16
	htotal as CARD16
	vdisplay as CARD16
	vsyncstart as CARD16
	vsyncend as CARD16
	vtotal as CARD16
	flags as CARD32
	privsize as CARD32
end type

type xXF86VidModeGetAllModeLinesReply
	as UBYTE type
	pad1 as XBOOL
	sequenceNumber as CARD16
	length as CARD32
	modecount as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
end type

const sz_xXF86VidModeGetAllModeLinesReply = 32

type _XF86VidModeAddModeLine
	reqType as CARD8
	xf86vidmodeReqType as CARD8
	length as CARD16
	screen as CARD32
	dotclock as CARD32
	hdisplay as CARD16
	hsyncstart as CARD16
	hsyncend as CARD16
	htotal as CARD16
	hskew as CARD16
	vdisplay as CARD16
	vsyncstart as CARD16
	vsyncend as CARD16
	vtotal as CARD16
	pad1 as CARD16
	flags as CARD32
	reserved1 as CARD32
	reserved2 as CARD32
	reserved3 as CARD32
	privsize as CARD32
	after_dotclock as CARD32
	after_hdisplay as CARD16
	after_hsyncstart as CARD16
	after_hsyncend as CARD16
	after_htotal as CARD16
	after_hskew as CARD16
	after_vdisplay as CARD16
	after_vsyncstart as CARD16
	after_vsyncend as CARD16
	after_vtotal as CARD16
	pad2 as CARD16
	after_flags as CARD32
	reserved4 as CARD32
	reserved5 as CARD32
	reserved6 as CARD32
end type

type xXF86VidModeAddModeLineReq as _XF86VidModeAddModeLine
const sz_xXF86VidModeAddModeLineReq = 92

type _XF86OldVidModeAddModeLine
	reqType as CARD8
	xf86vidmodeReqType as CARD8
	length as CARD16
	screen as CARD32
	dotclock as CARD32
	hdisplay as CARD16
	hsyncstart as CARD16
	hsyncend as CARD16
	htotal as CARD16
	vdisplay as CARD16
	vsyncstart as CARD16
	vsyncend as CARD16
	vtotal as CARD16
	flags as CARD32
	privsize as CARD32
	after_dotclock as CARD32
	after_hdisplay as CARD16
	after_hsyncstart as CARD16
	after_hsyncend as CARD16
	after_htotal as CARD16
	after_vdisplay as CARD16
	after_vsyncstart as CARD16
	after_vsyncend as CARD16
	after_vtotal as CARD16
	after_flags as CARD32
end type

type xXF86OldVidModeAddModeLineReq as _XF86OldVidModeAddModeLine
const sz_xXF86OldVidModeAddModeLineReq = 60

type _XF86VidModeModModeLine
	reqType as CARD8
	xf86vidmodeReqType as CARD8
	length as CARD16
	screen as CARD32
	hdisplay as CARD16
	hsyncstart as CARD16
	hsyncend as CARD16
	htotal as CARD16
	hskew as CARD16
	vdisplay as CARD16
	vsyncstart as CARD16
	vsyncend as CARD16
	vtotal as CARD16
	pad1 as CARD16
	flags as CARD32
	reserved1 as CARD32
	reserved2 as CARD32
	reserved3 as CARD32
	privsize as CARD32
end type

type xXF86VidModeModModeLineReq as _XF86VidModeModModeLine
const sz_xXF86VidModeModModeLineReq = 48

type _XF86OldVidModeModModeLine
	reqType as CARD8
	xf86vidmodeReqType as CARD8
	length as CARD16
	screen as CARD32
	hdisplay as CARD16
	hsyncstart as CARD16
	hsyncend as CARD16
	htotal as CARD16
	vdisplay as CARD16
	vsyncstart as CARD16
	vsyncend as CARD16
	vtotal as CARD16
	flags as CARD32
	privsize as CARD32
end type

type xXF86OldVidModeModModeLineReq as _XF86OldVidModeModModeLine
const sz_xXF86OldVidModeModModeLineReq = 32

type _XF86VidModeValidateModeLine
	reqType as CARD8
	xf86vidmodeReqType as CARD8
	length as CARD16
	screen as CARD32
	dotclock as CARD32
	hdisplay as CARD16
	hsyncstart as CARD16
	hsyncend as CARD16
	htotal as CARD16
	hskew as CARD16
	vdisplay as CARD16
	vsyncstart as CARD16
	vsyncend as CARD16
	vtotal as CARD16
	pad1 as CARD16
	flags as CARD32
	reserved1 as CARD32
	reserved2 as CARD32
	reserved3 as CARD32
	privsize as CARD32
end type

type xXF86VidModeDeleteModeLineReq as _XF86VidModeValidateModeLine
type xXF86VidModeValidateModeLineReq as _XF86VidModeValidateModeLine
type xXF86VidModeSwitchToModeReq as _XF86VidModeValidateModeLine

const sz_xXF86VidModeDeleteModeLineReq = 52
const sz_xXF86VidModeValidateModeLineReq = 52
const sz_xXF86VidModeSwitchToModeReq = 52

type _XF86OldVidModeValidateModeLine
	reqType as CARD8
	xf86vidmodeReqType as CARD8
	length as CARD16
	screen as CARD32
	dotclock as CARD32
	hdisplay as CARD16
	hsyncstart as CARD16
	hsyncend as CARD16
	htotal as CARD16
	vdisplay as CARD16
	vsyncstart as CARD16
	vsyncend as CARD16
	vtotal as CARD16
	flags as CARD32
	privsize as CARD32
end type

type xXF86OldVidModeDeleteModeLineReq as _XF86OldVidModeValidateModeLine
type xXF86OldVidModeValidateModeLineReq as _XF86OldVidModeValidateModeLine
type xXF86OldVidModeSwitchToModeReq as _XF86OldVidModeValidateModeLine

const sz_xXF86OldVidModeDeleteModeLineReq = 36
const sz_xXF86OldVidModeValidateModeLineReq = 36
const sz_xXF86OldVidModeSwitchToModeReq = 36

type _XF86VidModeSwitchMode
	reqType as CARD8
	xf86vidmodeReqType as CARD8
	length as CARD16
	screen as CARD16
	zoom as CARD16
end type

type xXF86VidModeSwitchModeReq as _XF86VidModeSwitchMode
const sz_xXF86VidModeSwitchModeReq = 8

type _XF86VidModeLockModeSwitch
	reqType as CARD8
	xf86vidmodeReqType as CARD8
	length as CARD16
	screen as CARD16
	lock as CARD16
end type

type xXF86VidModeLockModeSwitchReq as _XF86VidModeLockModeSwitch
const sz_xXF86VidModeLockModeSwitchReq = 8

type xXF86VidModeValidateModeLineReply
	as UBYTE type
	pad1 as XBOOL
	sequenceNumber as CARD16
	length as CARD32
	status as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
end type

const sz_xXF86VidModeValidateModeLineReply = 32

type xXF86VidModeGetMonitorReply
	as UBYTE type
	pad1 as XBOOL
	sequenceNumber as CARD16
	length as CARD32
	vendorLength as CARD8
	modelLength as CARD8
	nhsync as CARD8
	nvsync as CARD8
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
end type

const sz_xXF86VidModeGetMonitorReply = 32

type xXF86VidModeGetViewPortReply
	as UBYTE type
	pad1 as XBOOL
	sequenceNumber as CARD16
	length as CARD32
	x as CARD32
	y as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
end type

const sz_xXF86VidModeGetViewPortReply = 32

type _XF86VidModeSetViewPort
	reqType as CARD8
	xf86vidmodeReqType as CARD8
	length as CARD16
	screen as CARD16
	pad as CARD16
	x as CARD32
	y as CARD32
end type

type xXF86VidModeSetViewPortReq as _XF86VidModeSetViewPort
const sz_xXF86VidModeSetViewPortReq = 16

type xXF86VidModeGetDotClocksReply
	as UBYTE type
	pad1 as XBOOL
	sequenceNumber as CARD16
	length as CARD32
	flags as CARD32
	clocks as CARD32
	maxclocks as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
end type

const sz_xXF86VidModeGetDotClocksReply = 32

type _XF86VidModeSetClientVersion
	reqType as CARD8
	xf86vidmodeReqType as CARD8
	length as CARD16
	major as CARD16
	minor as CARD16
end type

type xXF86VidModeSetClientVersionReq as _XF86VidModeSetClientVersion
const sz_xXF86VidModeSetClientVersionReq = 8

type _XF86VidModeGetGamma
	reqType as CARD8
	xf86vidmodeReqType as CARD8
	length as CARD16
	screen as CARD16
	pad as CARD16
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
end type

type xXF86VidModeGetGammaReq as _XF86VidModeGetGamma
const sz_xXF86VidModeGetGammaReq = 32

type xXF86VidModeGetGammaReply
	as UBYTE type
	pad as XBOOL
	sequenceNumber as CARD16
	length as CARD32
	red as CARD32
	green as CARD32
	blue as CARD32
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
end type

const sz_xXF86VidModeGetGammaReply = 32

type _XF86VidModeSetGamma
	reqType as CARD8
	xf86vidmodeReqType as CARD8
	length as CARD16
	screen as CARD16
	pad as CARD16
	red as CARD32
	green as CARD32
	blue as CARD32
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
end type

type xXF86VidModeSetGammaReq as _XF86VidModeSetGamma
const sz_xXF86VidModeSetGammaReq = 32

type _XF86VidModeSetGammaRamp
	reqType as CARD8
	xf86vidmodeReqType as CARD8
	length as CARD16
	screen as CARD16
	size as CARD16
end type

type xXF86VidModeSetGammaRampReq as _XF86VidModeSetGammaRamp
const sz_xXF86VidModeSetGammaRampReq = 8

type _XF86VidModeGetGammaRamp
	reqType as CARD8
	xf86vidmodeReqType as CARD8
	length as CARD16
	screen as CARD16
	size as CARD16
end type

type xXF86VidModeGetGammaRampReq as _XF86VidModeGetGammaRamp
const sz_xXF86VidModeGetGammaRampReq = 8

type xXF86VidModeGetGammaRampReply
	as UBYTE type
	pad as XBOOL
	sequenceNumber as CARD16
	length as CARD32
	size as CARD16
	pad0 as CARD16
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
end type

const sz_xXF86VidModeGetGammaRampReply = 32

type _XF86VidModeGetGammaRampSize
	reqType as CARD8
	xf86vidmodeReqType as CARD8
	length as CARD16
	screen as CARD16
	pad as CARD16
end type

type xXF86VidModeGetGammaRampSizeReq as _XF86VidModeGetGammaRampSize
const sz_xXF86VidModeGetGammaRampSizeReq = 8

type xXF86VidModeGetGammaRampSizeReply
	as UBYTE type
	pad as XBOOL
	sequenceNumber as CARD16
	length as CARD32
	size as CARD16
	pad0 as CARD16
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
end type

const sz_xXF86VidModeGetGammaRampSizeReply = 32

type xXF86VidModeGetPermissionsReply
	as UBYTE type
	pad as XBOOL
	sequenceNumber as CARD16
	length as CARD32
	permissions as CARD32
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
end type

const sz_xXF86VidModeGetPermissionsReply = 32
