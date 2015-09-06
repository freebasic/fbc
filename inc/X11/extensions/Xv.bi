'' FreeBASIC binding for videoproto-2.3.2
''
'' based on the C header files:
''   *********************************************************
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
''   *****************************************************************
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/long.bi"
#include once "X11/X.bi"

#define XV_H
#define XvName "XVideo"
const XvVersion = 2
const XvRevision = 2
type XvPortID as XID
type XvEncodingID as XID
const XvNone = 0
const XvInput = 0
const XvOutput = 1
const XvInputMask = cast(clong, 1) shl XvInput
const XvOutputMask = cast(clong, 1) shl XvOutput
const XvVideoMask = &h00000004
const XvStillMask = &h00000008
const XvImageMask = &h00000010
const XvPixmapMask = &h00010000
const XvWindowMask = &h00020000
const XvGettable = &h01
const XvSettable = &h02
const XvRGB = 0
const XvYUV = 1
const XvPacked = 0
const XvPlanar = 1
const XvTopToBottom = 0
const XvBottomToTop = 1
const XvVideoNotify = 0
const XvPortNotify = 1
const XvNumEvents = 2
const XvStarted = 0
const XvStopped = 1
const XvBusy = 2
const XvPreempted = 3
const XvHardError = 4
const XvLastReason = 4
const XvNumReasons = XvLastReason + 1
const XvStartedMask = cast(clong, 1) shl XvStarted
const XvStoppedMask = cast(clong, 1) shl XvStopped
const XvBusyMask = cast(clong, 1) shl XvBusy
const XvPreemptedMask = cast(clong, 1) shl XvPreempted
const XvHardErrorMask = cast(clong, 1) shl XvHardError
const XvAnyReasonMask = (cast(clong, 1) shl XvNumReasons) - 1
const XvNoReasonMask = 0
const XvBadPort = 0
const XvBadEncoding = 1
const XvBadControl = 2
const XvNumErrors = 3
const XvBadExtension = 1
const XvAlreadyGrabbed = 2
const XvInvalidTime = 3
const XvBadReply = 4
const XvBadAlloc = 5
